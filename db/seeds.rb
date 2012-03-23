# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Job.create( 
  [ 
    { :id => 1, :label => "acteur", :description => "C'est un artiste qui prete son physique ou simplement sa voix a un personnage. C'est lui qui agit et lui donne vie." },
    { :id => 2, :label => "realisateur", :description => "C'est une personne qui dirige la fabrication d'une oeuvre audiovisuelle." },
	{ :id => 3, :label => "scenariste", :description => "Il veille au bon deroulement de la creation d'un film." },
	{ :id => 4, :label => "assistant-realisateur", :description => "Il assiste le realisateur." },
	{ :id => 5, :label => "monteur", :description => "Il est charge de l'assemblage des plans et des sequence afin de delivrer toute l'essence decrite par le scenario et voulue lors du tournage par le realisateur." },
	{ :id => 6, :label => "cadreur", :description => "Il a une camera en mains et la dirige lors de prises de vue. Il est un collaborateur essentiel de la mise en scene." },
	{ :id => 7, :label => "producteur", :description => "Il veille au bon deroulement de la creation d'un film." },
	{ :id => 8, :label => "ingenieur-son", :description => "Il est responsable de la prise de son sur le tournage. Il travaille en etroite collaboration avec son assistant le perchman. Il est le garant du son direct." },
	{ :id => 9, :label => "cascadeur", :description => "C'est un metier dangereux." }
  ]
)