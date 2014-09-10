#!/usr/bin/env ruby
# encoding: utf-8

require 'open-uri'
require 'readability'
require 'reverse_markdown'
require 'rubygems'

TAGS = %w[div h1 h2 h3 h4 h5 h6 p em strong i b blockquote pre code a hr li ol ul]

def get_body(url)
    response = open(url)

    if response.content_encoding.include?('gzip')
        Zlib::GzipReader.new(response).read
    else
        response.read
    end
end

def to_quoted_markdown(html)
    markdown = ReverseMarkdown.convert(html, unknown_tags: :raise)

    # Break at 78 characters and quote using `> `
    markdown.split("\n").collect! do |line|
        code = line[0...4] == '    '

        if line == ''
            ">\n"
        elsif code or line.length <= 78
            "> #{line}\n"
        else
            line.gsub(/(.{1,78})(\s+|$)/, "\> \\1\n")
        end
    end * ""
end

def slugize(string)
    string.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '').gsub(/\-+/, '-')
end

url = ARGV[0]
body = get_body(url)

document = Readability::Document.new(body, :tags => TAGS)
markdown = to_quoted_markdown(document.content)

path = "_posts/#{Time.now.strftime('%Y-%m-%y')}-#{slugize(document.title)}.md"

File.write path, <<-eos
---
title:    #{(document.title or 'TITLE').strip}
date:     #{Time.now.utc.iso8601}
link:     #{url}
color:    AAAAAA
category: ❤ing
---

[#{document.author or 'AUTHOR'}](#{url}):

#{markdown}
eos

exec "open -a '/Applications/Sublime Text.app/' #{path}"
