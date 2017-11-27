module PivxNode
  # Helper module for ges_apigee cookbook
  module Helper
    def coin
      "#{node['chef_node']['coin']}"
    end

  [
    Chef::Recipe,
    Chef::Resource
  ].each { |klass| klass.send :include, self }
  end
end
