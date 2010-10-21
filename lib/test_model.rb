require 'dm-core'
require 'models'

# DataMapper::Logger.new  ($stdout, :debug)
# DataMapper.setup(:default, 'mysql://localhost/bioViz')
# DataMapper.setup(:default, 'sqlite3:/Users/nernst/Dropbox/research/projects/carl/sinatra-template/bioviz-test.db')
DataMapper.setup(:default, 'sqlite3:bioviz-test.db')

@experiments = Experiment.all

# builder do |xml|
#   xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
#   @experiments.each do |exp|
#     xml.experiment(:experiment_id => exp.id)
#     @experiments.samples do |sample|
#       xml.region_name(sample.region.common_name)
#       xml.mel(sample.mean_expression_level)
#       xml.gene(sample.gene.known_gene_symbol)
#     end
#   end
# end

  
  
# for exp in @experiments
#   for sample in exp.samples
#     # for region in sample.region
#       puts exp.platform, sample.region.common_name, sample.mean_expression_level, sample.gene.known_gene_symbol
#     # end
#   end
# end
# @samples = Sample.all
# # puts @samples.length
# for sample in @samples
#   puts sample.region.gene
# 
# end
