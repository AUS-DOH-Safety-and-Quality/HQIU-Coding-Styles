"""
Module that provides example utility functions
"""

def calculate_average(numbers):
    """
    Prints an individuals name and age

    Args:
        numbers (list): A list of numbers for which the average will be calculated

    Returns:
        average (int): the average of the numbers list

    """
    number_list_sum = 0
    for number in numbers:
        number_list_sum = number_list_sum + number
    return(number_list_sum / len(numbers))
