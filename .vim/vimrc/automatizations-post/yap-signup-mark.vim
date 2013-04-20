onoremap <silent> irta :<c-u>execute "normal! /In-Reply-To:\r:nohlsearch\rWviW"<CR>
onoremap <silent> irti :<c-u>execute "normal! /In-Reply-To:\r:nohlsearch\rWwvi>"<CR>

function! CollectBufferDataPy()
python << EOF
import vim
import notmuch
import subprocess
import json
import pprint

pp = pprint.PrettyPrinter(indent=2)

def categorize_line(line):
    if line == None:
        return None
    elif len(line) == 0:
        return 'empty'
    elif line[0] == '>':
        return 'quote'
    elif 'On ' == line[0:3] and ' wrote:' == line[-7:]:
        return 'quotestart'
    elif line[0:2] == '--':
        return 'sigmarker'
    else:
        return 'regular'

def categorize_lines_it(lines):
    linetag = None
    lines.append(None)
    prevlinetag = categorize_line(lines[0])
    i = -1
    previ = 0
    for line in lines:
        i += 1
        linetag = categorize_line(line)
        if linetag != prevlinetag:
            yield (prevlinetag, previ, i)
            prevlinetag = linetag
            previ = i

def aggregate_true_mail_content(raw):
    finalcontent = []
    lines = raw.split('\n')
    for tag, start, end in categorize_lines_it(lines):
        if 'regular' == tag:
            finalcontent += lines[start:end]
        if 'sigmarker' == tag:
            break
    return '\n'.join(finalcontent)

def thread_iterator(js):
    acc = []
    if type(js) == list:
        for item in js:
            for message in thread_iterator(item):
                yield message
    elif type(js) == dict:
        if u'body' in js:
            for item in js['body']:
                if 'content' in item:
                    if type(item['content']) == list:
                        for content in item['content']:
                            if 'content-type' in content and content['content-type'] == 'text/plain' and 'filename' not in content:
                                finalcontent = aggregate_true_mail_content(content['content'])
                                yield {'content': finalcontent, 'headers':js['headers'], 'messageid': js['id']}
                    else:
                        finalcontent = aggregate_true_mail_content(item['content'])
                        yield {'content': finalcontent, 'headers':js['headers'], 'messageid': js['id']}

headers = {}

for line in vim.current.buffer:
    if not line:
        break
    split = line.split(": ", 1)
    headers[split[0]] = split[1]

output = subprocess.Popen(["notmuch", "show", "--entire-thread=true", "--format=json",
    "id:"+headers['In-Reply-To'][1:-1] ],
    stdout=subprocess.PIPE).communicate()

json_response = json.loads(output[0])

for msg in thread_iterator(json_response):
    content = msg['content'].split('\n')
    found = False
    for line in content:
        if 'Nota' in line:
            print line
            found = True
            break
    if not found:
        print "Mark not found in message", msg['messageid'], "by", msg['headers']['From'], 'on', msg['headers']['Date']

EOF
endfunction

"autocmd FileType mail call CollectBufferDataPy()
autocmd FileType mail map <F8> :%g/^> >/d<CR>

" :omap z :<c-u>execute "normal! /In-Reply-To:\rWviW"<CR>
" :normal "ryz
" :let var = @r
