require 'cocoapods-monorepo/monorepo_list'

module Pod
  class Command
    # This is an example of a cocoapods plugin adding a top-level subcommand
    # to the 'pod' command.
    #
    # You can also create subcommands of existing or new commands. Say you
    # wanted to add a subcommand to `list` to show newly deprecated pods,
    # (e.g. `pod list deprecated`), there are a few things that would need
    # to change.
    #
    # - move this file to `lib/pod/command/list/deprecated.rb` and update
    #   the class to exist in the the Pod::Command::List namespace
    # - change this class to extend from `List` instead of `Command`. This
    #   tells the plugin system that it is a subcommand of `list`.
    # - edit `lib/cocoapods_plugins.rb` to require this file
    #
    # @todo Create a PR to add your plugin to CocoaPods/cocoapods.org
    #       in the `plugins.json` file, once your plugin is released.
    #
    class Monorepo < Command
      self.summary = '列出大仓中的本地Pod组件.'

      self.description = <<-DESC
        根据Podfile寻找依赖modules的本地Pod组件.
      DESC

      self.arguments = []  # 暂时不需要参数

      def initialize(argv)
        @name = argv.shift_argument
        @git = `git rev-parse --show-toplevel`.chomp
        @modules = File.join(@git, 'modules')
        @podfile = File.join(Dir.pwd, 'Podfile')
        super
      end

      def validate!
        super
        help! '[monorepo]: 未找到Podfile文件，请在Podfile所在目录执行！' unless File.file?(@podfile)
        help! "[monorepo]: 仓库目录错误#{@git}，请在Gaoding-iOS下执行！" unless File.basename(@git) == "Gaoding-iOS"
        help! "[monorepo]: 未找到本地组件目录#{@modules}！" unless File.directory?(@modules)
      end

      def run
        UI.puts "[monorepo]: 开始在modules目录中查找本地Pod组件...".green
        results = CocoapodsMonorepo::MonorepoList.list_podfile_component(@podfile, @modules)
        results.each {|pod| UI.puts "[monorepo]: 本地Pod组件 - #{pod}".cyan}
        UI.puts "[monorepo]: 完成modules目录本地Pod组件检索.".green
      end
    end
  end
end
