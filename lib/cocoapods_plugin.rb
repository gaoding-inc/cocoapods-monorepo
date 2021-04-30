require 'cocoapods-monorepo/command'

module CocoapodsMonorepo
    Pod::HooksManager.register("cocoapods-monorepo", :pre_install) do |context, options|
        
        Pod::UI.puts "[cocoapods-monorepo]: Integrating Pods with monorepo..".green
        require 'cocoapods-monorepo/resolver'

        unless options.key?(:path)
            raise Pod::DSLError.new("[cocoapods-monorepo]: Require pass `:path` option by using `:path => dir` in Podfile", 
                                    context.podfile.defined_in_file.to_s, 
                                    Exception.new(""))
        end
          
        Pod::Resolver.monorepo_path = options[:path] 
    end

    Pod::HooksManager.register("cocoapods-monorepo", :post_install) do |context|  
    end
end