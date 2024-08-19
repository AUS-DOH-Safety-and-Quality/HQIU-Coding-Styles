# HQIU Python Coding Style

This document provides an outline of HQIU's coding style in Python.

## Purpose

This Python style guide helps contribute to the goal of the Healthcare Quality Intelligence unit (HQIU) in producing reproducible and transparent code. Adhering to rules outlined in this style guide helps to improve our ability to share, maintain, and develop analytical workflows in cases where Python is used. 

This is designed for those in the HQIU team or those interested in writing Python code that is clear and can be shared and maintained. The HQIU Python coding style guide takes inspiration from the HQIU R coding style guide.

## Principles

In accordance with the HQIU R style guide.

* We take a disciplined and practical approach to writing code.
* We regularly check-in code to Github
* We believe consistency in style is very important.
* We demonstrate intent explicitly in code, via clear structure and comments where needed.

## Rules

The basis of the style guide is a combination of principles from PEP 8 and the tidyverse style guide, which is a document that provides the guidelines and best practices on writing python code. Using PEP 8 helps to improve the readability of Python Code.

## General Practices

At the start / top of the Python script, you should document the name of the scipt, purpose of the script, and the developers involved. 

```python

##########################################
# Name: Cleaning large dataset
# Purpose: This script cleans a very large dataset before it is analysed
# Developers:
#   Jane Doe
#   John Doe
##########################################
```


### Naming 

For functions, should aim to use verbs. 

For example:

```python

# Good
def clean_data():
    print("Clean data")

def train_model():
    print("train model")


# Bad
def data_cleaning():
    print("data cleaning")

def model_training():
    print("model training")

```

### Naming variables

Use snake_case for variable and function names e.g. example_variable

- Be descriptive with the naming to enhance the readability and maintainability of the code
- when storing the results of counts or percentages for example, they should be added at the end of the variable name e.g. disease_count, disease_percentage
- Constants (variables that dont change value) should be defined at the start of a script. They should be written in all capital letters e.g. CONSTANT, VARIABLE

```python

# Constants should be created at start of script. Written in all capital letters
MAX_STUDENTS_IN_CLASS = 30

# Use snake_case when naming variables
name_of_school = "Python school"

# storing results of counts and percentages
boys_in_class_percentage = 50
boys_in_class_count = 15

```

### Consistency 

- Use consistent naming conventions throughout the code you are writing e.g. snake_case throughout entire script.
- When naming column names in data frames, use the same variable naming pattern as the rest of the code.

```python
# Standard library imports
import os

# importing third party libraries
import pandas as pd

# Importing application specifc / in house packages
import my_package

# Creating dictionary containing our example data
data_dictionary = {
    'example_column_1':[1,2,3],
    'example_column_2':[4,5,6],
    'example_column_3':[7,8,9]
}

# Converting dictionary into a pandas dataframe
example_dataframe = pd.DataFrame(data_dictionary)
```

### Commenting 

- Add comments to the code to explain what it does, unless the code is very self explanatory.
- Include the reasoning behind your code, especially for more complicated pieces of code and functions. For functions in particular, comments should be added to explain what the function does and how it is used. For functions and classes, this is known as a docstring. An example is provided below. 

```python
# This is an example comment.

def print_name(name,age):
    """
    Prints an individuals name and age

    Args:
        name (string): the individuals name
        age (string): the individuals age

    Returns:
        sentence (string): A sentence that includes the name and age of the individual

    """
    sentence = f"My name is {}. I am {age} years old"
    return(sentence)

```


### General programming principles

- Keep it simple
- Dont repeat yourself. Pieces of code should be implemented in just one place in the source code. Tasks that are repeated should be implemented as functions
- You are not going to need it. Do not implement something until it is necessary. 
- For more complicated applications or pieces of software, separation of concerns principles should be implemented. Code should be as independent as possible, making it easier to maintain, update, and reuse. 



## Notebook usage and best practice

Here are some general usage guidelines and best practices when using jupyter notebooks, databricks notebooks, or similar alternatives. 

- Give the notebook a header. Limit the scope of the notebook to a particular objective so that it does not becoming overwhelming. 
- Use markdown throughout the notebook. This includes using headings and subheadings where appropriate. Remember that you are documenting this for those that you work for both yourself in the future, and those that you work with. 
- importing packages and modules should be done at the begining of the notebook only. 
- Constants should also be defined only at the beginning of the notebook.
- Code from notebooks should be converted into modules as much as possible. This makes the notebook more reusable, and allows the functions or classes in the modules to be used elsewhere. 