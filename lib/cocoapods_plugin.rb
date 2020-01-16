require 'cocoapods-monorepo/command'

module CocoapodsMonorepo
    Pod::HooksManager.register("cocoapods-monorepo", :pre_install) do |context|
        
        Pod::UI.puts "[monorepo-plugin]: 🚀 执行pre_install.".green
        require 'cocoapods-monorepo/resolver'
    end

    Pod::HooksManager.register("cocoapods-monorepo", :post_install) do |context|
        Pod::UI.puts "[monorepo-plugin]: 🚀 执行post_install.".green
    end
end