require 'sinatra'
require 'sassc'
require './app'

# Sass
template = File.read('stylesheets/style.scss')

options = { style: :compressed,
            filename: 'style.scss',
            output_path: 'style.css',
            source_map_file: 'style.css.map',
            load_paths: ['stylesheets'],
            source_map_contents: true }

engine = SassC::Engine.new(template, options)

css_content = engine.render
File.write('public/css/style.css', css_content)

map = engine.source_map
File.write('public/css/style.css.map', map)

run App
