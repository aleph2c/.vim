#!/usr/bin/env ruby

require 'rubygems'
require 'redcarpet/compat'
require 'getopt/std'
require 'albino'
require 'htmlentities'

# highlight code blocks
class HTMLwithAlbino < Redcarpet::Render::HTML
  def block_code(code, language)
    if !language.nil? and !language.empty? then
      Albino.colorize(code, language)
    else
      coder = HTMLEntities.new
      return "<pre class=\"highlight\"><code>" + coder.encode(code, :named) + "</code></pre>"
    end
  end
end

# initialize markdown renderer
markdown = Redcarpet::Markdown.new(HTMLwithAlbino, :fenced_code_blocks => true)

# options
opt = Getopt::Std.getopts("T:o:hHcnp")

title = ARGV[0]
if opt["T"] then
  title = opt["T"]
end

if opt["h"] or opt["H"] or ARGV[0].nil? or !File.exist? ARGV[0] then
  puts "#{$0} [Options] <input-file>"
  puts "  -T <title>        HTML-Title"
  puts "  -o <output-file>  Output file"
  puts "  -h                Help"
  puts "  -c                Use external CSS"
  puts "  -n                Dont create the CSS Files"
  puts "  -p                Plain, no HTML"
  exit 0
end

# make it pretty
main_css = <<eos
html {font:1em/1.5em "Bitstream Vera Sans","Verdana",sans-serif}
h1,h2,h3 {padding-bottom:0.1em}
h1 {border-bottom:0.01em solid #666}
h2 {border-bottom:0.01em solid #999}
h3 {border-bottom:0.01em dashed #ccc}
p {text-align: justify}
.small {font-size:0.75em}
.grey {color:#666666}a:hover{color:#56c2e6}
a{color:#47a1bf;text-decoration:underline}
blockquote {margin:10px 0px;padding-left:10px;border-left:10px solid #ccc}
@media screen {body {max-width:800px;margin:auto}pre{white-space:pre-wrap;}}
eos

# colors for source code
pygment_css = <<eos
code { border:1px solid #999; background-color:#eee; border-radius:2px; padding: 1px 3px }
pre > code { border:none; background-color:transparent; padding:0;}

.highlight {background:#eee; border:1px solid #999; border-radius:5px;padding:5px;}
.highlight pre{margin:0;}
.highlight .c{color:#998;font-style:italic;}
.highlight .err{color:#a61717;background-color:#e3d2d2;}
.highlight .k{font-weight:bold;}
.highlight .o{font-weight:bold;}
.highlight .cm{color:#998;font-style:italic;}
.highlight .cp{color:#999;font-weight:bold;}
.highlight .c1{color:#998;font-style:italic;}
.highlight .cs{color:#999;font-weight:bold;font-style:italic;}
.highlight .gd{color:#000;background-color:#fdd;}
.highlight .gd .x{color:#000;background-color:#faa;}
.highlight .ge{font-style:italic;}
.highlight .gr{color:#a00;}
.highlight .gh{color:#999;}
.highlight .gi{color:#000;background-color:#dfd;}
.highlight .gi .x{color:#000;background-color:#afa;}
.highlight .go{color:#888;}
.highlight .gp{color:#555;}
.highlight .gs{font-weight:bold;}
.highlight .gu{color:#800080;font-weight:bold;}
.highlight .gt{color:#a00;}
.highlight .kc{font-weight:bold;}
.highlight .kd{font-weight:bold;}
.highlight .kp{font-weight:bold;}
.highlight .kr{font-weight:bold;}
.highlight .kt{color:#458;font-weight:bold;}
.highlight .m{color:#099;}
.highlight .s{color:#d14;}
.highlight .na{color:#008080;}
.highlight .nb{color:#0086B3;}
.highlight .nc{color:#458;font-weight:bold;}
.highlight .no{color:#008080;}
.highlight .ni{color:#800080;}
.highlight .ne{color:#900;font-weight:bold;}
.highlight .nf{color:#900;font-weight:bold;}
.highlight .nn{color:#555;}
.highlight .nt{color:#000080;}
.highlight .nv{color:#008080;}
.highlight .ow{font-weight:bold;}
.highlight .w{color:#bbb;}
.highlight .mf{color:#099;}
.highlight .mh{color:#099;}
.highlight .mi{color:#099;}
.highlight .mo{color:#099;}
.highlight .sb{color:#d14;}
.highlight .sc{color:#d14;}
.highlight .sd{color:#d14;}
.highlight .s2{color:#d14;}
.highlight .se{color:#d14;}
.highlight .sh{color:#d14;}
.highlight .si{color:#d14;}
.highlight .sx{color:#d14;}
.highlight .sr{color:#009926;}
.highlight .s1{color:#d14;}
.highlight .ss{color:#990073;}
.highlight .bp{color:#999;}
.highlight .vc{color:#008080;}
.highlight .vg{color:#008080;}
.highlight .vi{color:#008080;}
.highlight .il{color:#099;}
eos

# choose template
if opt["c"] then
  template = <<eos
<!DOCTYPE html>
<html>
  <head>
    <title>{{TITLE}}</title>
    <meta charset="utf-8">
    <link href="main.css" type="text/css" rel="stylesheet">
    <link href="pygment.css" type="text/css" rel="stylesheet">
  </head>
  <body>
{{CONTENT}}
  </body>
</html>
eos
else
  template = <<eos
<!DOCTYPE html>
<html>
  <head>
    <title>{{TITLE}}</title>
    <meta charset="utf-8">
    <style type="text/css">
#{main_css}
#{pygment_css}
    </style>
  </head>
  <body>
{{CONTENT}}
  </body>
</html>
eos
end

# parse markdown
if opt["p"] then
  puts markdown.render(File.open(ARGV[0], "rb").read)
elsif opt["o"] then
  File.open(opt["o"],"w+").puts template.gsub("{{TITLE}}", title).gsub("{{CONTENT}}", markdown.render(File.open(ARGV[0],"rb").read))
else
  puts template.gsub("{{TITLE}}", title).gsub("{{CONTENT}}", markdown.render(File.open(ARGV[0], "rb").read))
end

# create css files
if opt["c"] and !opt["n"] and !opt["p"] then
  File.open("main.css","w+").puts main_css if !File.exist? "main.css"
  File.open("pygment.css","w+").puts pygment_css if !File.exists? "pygment.css"
end

