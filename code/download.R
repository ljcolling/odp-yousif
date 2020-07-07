# Install ODP helper
remotes::install_github("ljcolling/ODPHelper", ref = "dev")
xfun::pkg_attach2("osfr")

geniole_download_info <- ODPHelper::download_yousif()()
dir.create("made")
saveRDS(object = geniole_download_info, file = "made/yousif_download_info.Rdata")
