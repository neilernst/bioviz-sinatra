# require 'rubygems'
# require 'dm-core'
# DataMapper.setup(:default, 'mysql://localhost/bioViz')

class Gene 
  include DataMapper::Resource
  property :id, Serial
  property :chip_id,  Integer
  property :fragment_id , String
  property :fragment_name, String
  property :sequence_title, Text
  property :known_gene_symbol, String
  
  has n, :samples
  has n, :experiments_genes
  has n, :experiments, :through => :experiments_genes
  has n, :regions, :through => Resource
  # has_and_belongs_to_many :experiments
end

class Region 
  include DataMapper::Resource
  property :id, Serial
  property :common_name, Text
  property :brodmann_code, String
  
  has n, :samples
  has n, :genes, :through => Resource
end

class Experiments_Gene
  include DataMapper::Resource
  property :gene_id, Integer#, :key => True
  property :experiment_id, Integer#, :key => True
end
 
class Sample 
  include DataMapper::Resource
  property :id, Serial
  property :region_id, Integer
  property :gene_id, Integer
  property :experiment_id, Integer
  property :num_subjects, Integer
  property :percent_present, Float
  property :mean_expression_level, Float
  property :sd_mean, Float
  
  belongs_to :gene
  belongs_to :region, :model => 'Region', :child_key => [:region_id]
  belongs_to :experiment
  
end

class Experiment
  include DataMapper::Resource  
  property :id, Serial
  property :platform, Text
  property :date, DateTime
  
  has n, :experiments_genes
  has n, :genes, :through => :experiments_genes
  has n, :samples
  # has_and_belongs_to_many :genes
end

# gene = Gene.get(1)
# puts gene.sequence_title
# # @genes.each do |gene|
#   # puts "Gene is #{gene.known_gene_symbol}"
# # end