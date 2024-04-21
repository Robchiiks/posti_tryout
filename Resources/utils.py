import re

def get_only_number(value):

    number = re.search(r'\d{1,3}(?:,\d{3})*(?:\.\d+)?', value)
    if number:
        return number.group(0)
    return None