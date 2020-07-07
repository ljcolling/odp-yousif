all: 
	make download
	make analysis
	make document

# Download the data
download: ./code/download.R docker-compose.yml 
	make made/yousif_download_info.Rdata 

made/yousif_download_info.Rdata: ./code/download.R
	docker-compose run --rm download

download-docker: ./code/download.R
	R -e "source('./code/download.R')"

# Analyse the data
analysis: code/analysis.R docker-compose.yml 
	make made/yousif.Rdata

made/yousif.Rdata: ./code/analysis.R data/
	docker-compose run --rm analysis

analysis-docker: ./code/analysis.R
	echo "building yousif"
	R -e "source('./code/analysis.R')"

# Create the data
document: made/yousif.Rdata made/yousif_download_info.Rdata
	docker-compose run --rm document

document-docker: 
	R -e "xfun::pkg_attach2('rmarkdown')"
	R -e "rmarkdown::render('docs/yousif-LJC.Rmd')"

clean:
	rm -rf data
	rm -rf made
	rm -f docs/*.log
	rm -f docs/*.pdf
	rm -f docs/yousif.bib

 
