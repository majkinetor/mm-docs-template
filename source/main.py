from time import gmtime, strftime
import os
import re

def define_env(env):
    """
    This is the hook for the functions

    - variables: the dictionary that contains the variables
    - macro: a decorator function, to declare a macro.
    """
    revision = open('/docs/source/docs/revision.csv', "r")
    env.variables['revisions'] = revision.read()
    revision.close()

    env.variables['baz'] = "John Doe"
    env.variables['time'] = strftime("%Y-%m-%d %H:%M:%S", gmtime())


    @env.macro
    def bar(x):
        return (2.3 * x) + 7

    # If you wish, you can  declare a macro with a different name:
    def f(x):
        return x * x

    @env.macro
    def changedate(page):
        m = re.match('%s","(.+?)"' % (page.file.src_path), env.variables['revisions'])
        if m:
            return m.group(1)
        return "none"

    env.macro(f, 'barbaz')

    # or to export some predefined function
    import math
    env.macro(math.floor) # will be exported as 'floor'

    # create a jinja2 filter
    @env.filter
    def reverse(x):
        "Reverse a string (and uppercase)"
        return x.upper()[::-1]
