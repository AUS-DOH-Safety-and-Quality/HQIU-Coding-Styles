# HQIU R Coding Style

This folder contains the lintr linter configuration for HQIU R coding style.

# HQIU R  Coding Style

The following document provides an overview of HQIU's coding style for R. 

# Purpose

Maintaining reproducibility and transparency is a core value the Healthcare Quality Intelligence team, and a R style guide can help us achieve that goal. Additionally, adhering to the basic rules in this style guide will improve our ability to share, maintain, and extend our analytics when working with R.

This document is written as a manual for anyone working in the HQIU team, but also as a guide for anyone who would like to write clean and clear code that is meant to be shared.

We have adopted the styles and guide from the tidyverse style guide. https://style.tidyverse.org/syntax.html

# Principles

* We take a disciplined and practical approach to writing code.
* We regularly check-in code to Github
* We believe consistency in style is very important.
* We demonstrate intent explicitly in code, via clear structure and comments where needed.

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
