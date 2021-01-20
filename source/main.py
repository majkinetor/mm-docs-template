import time
import os
import json

def define_env(env):
    """
    This is the hook for the functions

    - variables: the dictionary that contains the variables
    - macro: a decorator function, to declare a macro.
    """
    with open('/docs/source/docs/revision.json') as json_file:
        env.variables['revisions'] = json.load(json_file)

    env.variables['baz'] = "John Doe"
    env.variables['time'] = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())


    @env.macro
    def bar(x):
        return (2.3 * x) + 7

    # If you wish, you can  declare a macro with a different name:
    def f(x):
        return x * x

    @env.macro
    def changedate():
        path = env.variables['page'].file.src_path
        revs = env.variables['revisions']
        if path in revs:
            return revs[path]['Date']

    env.macro(f, 'barbaz')

    # or to export some predefined function
    import math
    env.macro(math.floor) # will be exported as 'floor'

    # create a jinja2 filter
    @env.filter
    def reverse(x):
        "Reverse a string (and uppercase)"
        return x.upper()[::-1]
