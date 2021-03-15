require 'cocoapods-monorepo/command'

module CocoapodsMonorepo
    Pod::HooksManager.register("cocoapods-monorepo", :pre_install) do |context, options|
        
        Pod::UI.puts "[cocoapods-monorepo]: start injecting sub-repo into monorepo 🚀...".green
        require 'cocoapods-monorepo/resolver'

        unless options.key?(:path)
            raise Pod::DSLError.new("[cocoapods-monorepo]: require pass `:path` option by using `:path => directory` in Podfile", 
                                    context.podfile.defined_in_file.to_s, 
                                    Exception.new(""))
        end
          
        Pod::Resolver.monorepo_path = options[:path] 
    end

    Pod::HooksManager.register("cocoapods-monorepo", :post_install) do |context|  
    end
end