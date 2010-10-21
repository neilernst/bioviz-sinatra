# xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
# xml.genes{
#     for gene in @genes
#       xml.gene do
#             xml.gene_id(gene.id,  :experiment_id => 1)
#             xml.known_gene_symbol(gene.known_gene_symbol)
#             for sample in gene.samples
#               xml.sample do
#                 xml.mean_expression_level(sample.mean_expression_level)
#                 xml.region(sample.region.brodmann_code)
#               end   
#             end
#       end
#     end
# }
# builder do |xml|
  xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
  @experiments.each do |exp|
    xml.experiment(:experiment_id => exp.id)
    for sample in exp.samples
      xml.sample do
        xml.region_name(sample.region.common_name)
        xml.mel(sample.mean_expression_level)
        # xml.gene(sample.gene.known_gene_symbol)
      end
    end
  end
# end