# HQIU R Coding Style

This folder contains the lintr linter configuration for HQIU R coding style.

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
