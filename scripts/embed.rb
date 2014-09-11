#!/usr/bin/env ruby
# encoding: utf-8

require 'json'
require 'openssl'
require 'oembed'
require 'rubygems'
require 'nokogiri'
require 'time'

OEmbed::Providers::Embedly.endpoint += '?key=38d1bccb322844cd99d593cc0741be4d'
OEmbed::Providers::Embedly << "http://*.speakerdeck.com/*"
OEmbed::Providers::Embedly << "http://*.livestream.com/*"

OEmbed::Providers.register_all :aggregators

SETTINGS = {
    'soundcloud.com' => {
        :auto_play => false,
        :show_reposts => false,
        :show_comments => false,
        :show_user => true,
        :color => 'ABABAB',
        :hide_related => true,
        :visual => false
    },
    'vimeo.com' => {
        :color => 'ABABAB',
        :byline => false
    }
}

def slugize(string)
    string.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '').gsub(/\-+/, '-')
end

url = ARGV[0]
host = URI.parse(url).host.gsub('www.', '')

resource = OEmbed::Providers.get(url, SETTINGS[host] || {})
document = Nokogiri::HTML.fragment('<div></div>')

embed = document.child
embed['class'] = [ 'embed', resource.type, slugize(resource.provider_name) ] * ' '

content = Nokogiri::HTML.fragment(resource.html).child

embed.add_child content

if content.name == 'iframe'
    # Suppress a bug in SoundCloud's oEmbed implementation where the returned
    # iframe always contains 'visual=true' in its argument list.
    if resource.provider_name == 'SoundCloud'
        content['src'] = content['src'].gsub('?visual=true&', '?')
    end

    content.add_child Nokogiri::HTML.fragment("Find it on <a href='#{url}'>#{resource.provider_name}</a>.")
end

if content['width'] and content['width'] and not content['width'].match('%')
    # Calculate the aspect ratio
    embed['data-aspect-ratio'] = content['height'].to_f / content['width'].to_f
end

path = "_posts/#{Time.now.strftime('%Y-%m-%y')}-#{slugize(resource.title)}.md"

File.write path, <<-eos
---
title:    #{(resource.title or 'TITLE').strip}
date:     #{Time.now.utc.iso8601}
link:     #{url}
color:    ABABAB
category: ❤ing
---

#{document.to_xhtml(:indent => 4)}
eos

exec "open -a '/Applications/Sublime Text.app/' #{path}"
