# creates a report template .qmd for each
REPORT_PREFIX = "aoi_report"
SUBSTITUTIONS = list(
  c("dt", "{{inputFilePrefix}}")
)
# Set the root directory where the folders are located
DATA_DIR <- "data/01_raw/"
REPORT_NAMES = list(
  "dt", "fgb"
)

if (!nzchar(system.file(package = "librarian"))) {
  install.packages("librarian")
}
librarian::shelf(
  glue,
  whisker  
)

# Proceed if rendering the whole project, exit otherwise
if (!nzchar(Sys.getenv("QUARTO_PROJECT_RENDER_ALL"))) {
  quit()
}

REPORT_TEMPLATE = glue("{REPORT_PREFIX}/{REPORT_PREFIX}_template.qmd")
REPORTS_DIR = glue("{REPORT_PREFIX}/{REPORT_PREFIX}s")

# create the template
templ <- readLines(REPORT_TEMPLATE) 
for (sub in subs) {
  templ <- gsub(sub[1], sub[2], templ)
}

dir.create(REPORTS_DIR, showWarnings=FALSE)

# Loop through each file in the current folder (station)
for (reportName in REPORT_NAMES) {
  # print(paste("Folder:", folder, "File   :", basename(file)))
  params = list(
    reportName = reportName
  )
  print(glue("=== creating template for '{reportName}' ==="))
  writeLines(
    whisker.render(templ, params),
    file.path(REPORTS_DIR, glue("{reportName}.qmd"))
  )
}

