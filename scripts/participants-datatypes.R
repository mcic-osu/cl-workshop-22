## Packages
library(tidyverse)
library(googlesheets4)
library(patchwork)

## Settings
theme_set(theme_minimal(base_size = 13))
theme_update(panel.grid.minor = element_blank(),
             plot.title = element_text(hjust = 0.5))

## Link to the Google Sheet
signup_link <- "https://docs.google.com/spreadsheets/d/1Z1Yl9U6w-O0efRlhqqVOtGBDXcubIoCEU4QiAlMYWtg"

## Target column names
signup_colnames <- c("timestamp",
                     "name",
                     "email",
                     "department",
                     "campus",
                     "position",
                     "attendance_mode",
                     "experience_unix",
                     "experience_OSC",
                     "experience_coding",
                     "experience_genomics",
                     "data_type",
                     "questions",
                     "OSC_username")

exp_levels <- rev(c("None", "Very little", "Some", "A lot"))

## Read and clean up sheet
signup_org <- read_sheet(signup_link)
signup <- signup_org
colnames(signup) <- signup_colnames
signup <- signup %>%
  mutate(experience_unix = factor(experience_unix, levels = exp_levels),
         experience_OSC = factor(experience_OSC, levels = exp_levels),
         experience_coding = factor(experience_coding, levels = exp_levels),
         experience_genomics = factor(experience_genomics, levels = exp_levels)) %>%
  filter(!grepl("Kush|Dina", name))       # Kush won't come



# DATA TYPES -------------------------------------------------------------------
## Wrangle vector
dt <- sub("I am working with the whole genome sequencing data of the bacteria. Jelmer is helping me with the analysis.",
          "WGS", signup$data_type)
dt <- unlist(strsplit(dt, split = c("and")))
dt <- unlist(strsplit(dt, split = c(",")))
dt <- trimws(dt)
dt <- gsub("-| |data", "", dt)
dt <- gsub("yes", NA, dt, ignore.case = TRUE)
dt <- dt[!is.na(dt)]
dt <- str_to_title(dt)
dt <- sub("Alsochipseqresults|Chipseq", "ChIP-Seq", dt)
dt <- sub("Wholegenome(Re)Sequencing", "WGS", dt, fixed = TRUE)
dt <- sub("Wholegenomere(Sequencing)", "WGS", dt, fixed = TRUE)
dt <- sub("Hic|Wgs|Wholegenome|Wholegenomesequencing", "WGS", dt)
dt <- sub("Riboseq|Hic|Crispr|Genomeannotation|Pacbio", "Other", dt)
dt <- sub("Singlecellrnaseq|Singlecellseq", "scRNAseq", dt)
dt <- sub("Rnaseq", "RNAseq", dt)
dt <- sub("Shotgunmetagenomics", "Metagenomics", dt)

## Create df
dt_df <- data.frame(table(dt))
colnames(dt_df) <- c("data_type", "count")
dt_df <- dt_df %>%
  arrange(desc(count)) %>%
  mutate(data_type = fct_inorder(data_type))
