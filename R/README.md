# HQIU R Coding Style

The following document provides an overview of HQIU's coding style in R. 

# Purpose

Maintaining reproducibility and transparency is a core value the Healthcare Quality Intelligence team, and an R style guide can help us achieve that goal. Additionally, adhering to the basic rules in this style guide will improve our ability to share, maintain, and extend our analytics when working with R.

This document is written as a manual for anyone working in the HQIU team, but also as a guide for anyone who would like to write clean and clear code that is meant to be shared.

# Principles

* We take a disciplined and practical approach to writing code.
* We regularly check-in code to Github
* We believe consistency in style is very important.
* We demonstrate intent explicitly in code, via clear structure and comments where needed.

# Rules

HQIU follows the conventions outlined in [the tidyverse style guide](https://style.tidyverse.org/). This is assisted by the R packages [styler](https://styler.r-lib.org/) and [lintr](https://github.com/r-lib/lintr) which support the tidyverse style guide.

# Additional Rules

On top of the tidyverse style guide, there are additional rules put in place for R coding within HQIU. These are outlined below.

## General Practices

* Check code into Github early and often.
* Under Code Options, enable "Insert spaces for Tab" with a Tab width of 2
* No trailing whitespace
* Try to only comment on things that aren't obvious about the script (e.g., function is used, etc.), that explains the reasoning behind your code

## R Project Files

When working within a repository for R, always create an RStudio Project file. An R project file, typically denoted by a `.Rproj` extension, helps maintain a clean and structured workflow by encapsulating your R scripts, data, and associated files within a single directory.

Using an R Project file will ensure that the working directory will always be set to the correct location, which will enable the usage of relative path references. You can also set specific project related settings to ensure consistency across your project.

Here is more information on [Using RStudio Projects](https://support.posit.co/hc/en-us/articles/200526207-Using-RStudio-Projects).

## Documentation

At the beginning of your R script, document the name of the script, purpose of the script and the developers involved. This brief documentation will provide useful information to others about the script, and will also assist you in the future when revisiting your scripts. An example of the structure is below.

```R
################################################################
## Name: Addition Of Two Numbers
## Purpose: This script adds two numbers specified by the user
## Lead Developer: Maya Johnson (Senior Analyst - HQIU)
## Additional Developers (optional): 
##    Emily Chen (Senior Data Analyst - HQIU)
##    Liam Patel (Data Analyst - HQIU)
################################################################
```

## Optimise Installing and Loading Packages

Although RStudio now has automatic checking for missing required packages, it is handy to incorporate installing and loading packages at the start of your script rather than multiple library calls. An example that can be used is below.

```R
# Package names
packages <- c("dplyr", "ggplot2", "hrbrthemes")

# Install packages not yet installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# Packages loading
invisible(lapply(packages, library, character.only = TRUE))
```

It should be noted that packages that are not available on CRAN are unable to be installed through the above script. These non-CRAN packages will need to be installed through their appropriate methods.

## Other Conventions

We use the following coding conventions for our R code:

1. **Variable and Function Names**:
   - Use **snake_case** for variable and function names. This means joining words with underscores (e.g., `my_variable`, `calculate_sum`).
   - Be descriptive in your naming to enhance readability.
   - Avoid overly short or cryptic names.
   - - When formatting a value as a count or percentage, append this to the end of the variable (e.g. `separation_count`, `separation_percentage` 

2. **Consistency**:
   - Maintain consistent naming conventions throughout your codebase. If you start with snake case, stick to it.
   - When defining column names in data frames, follow the same snake case pattern (e.g., `codes_count`, `hospital_identifier`).
   
3. **Commenting**
   - Commenting what your code does, gives another reader the opportunity check that your code does what you intend.
   - Include *why* you are are coding, i.e. if its used in text later, or if you are calculating a numerator for a value.
   - Large comment chunks are fine to break up your code.

Remember, clear and consistent naming improves code maintainability and collaboration. 
