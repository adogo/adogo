require 'rake/tasklib'

module Rake
  module Flex
    class MxmlcTask < Rake::TaskLib
      attr_accessor :name
      attr_accessor :input, :output
      attr_accessor :includes, :libraries, :sources

      def initialize(name = :mxmlc)
        @name = name
        @includes, @libraries, @sources = [], [], []
        @input, @output = 'Main.mxml', 'Main.swf'

        yield self if block_given?
        define if block_given?
      end

      def define
        unless Rake.application.last_comment
          desc 'Compiling Flex' + (@name == :mxmlc ? '' : " for #{@name}") + '.'
        end

        task name => [output]

        file output => dependencies do
          when_writing('Compiling Flex application.') do
            mxmlc
          end
        end
      end

      def mxmlc
        mxmlc = windows? ? 'mxmlc.exe' : 'mxmlc'

        options = ''
        options << option('include-libraries', @includes)
        options << option('library-path', @libraries)
        options << option('source-path', @sources)
        options << option('output', @output)
        options << " #{@input}"

        system(mxmlc, options)
      end

      def option(name, value)
        value = [value].flatten.compact
        (" -#{name}=#{value.join(' ')}" unless value.empty?).to_s
      end
      protected :option

      def dependencies
        (@includes + @libraries + @sources).collect do |path|
          Dir.glob("#{path}/**/*")
        end.flatten + [@input]
      end
      protected :dependencies

      def windows?
        /mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM
      end
      protected :windows?
    end
  end
end
