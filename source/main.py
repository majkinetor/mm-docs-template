from time import gmtime, strftime

def declare_variables(variables, macro):
    """
    This is the hook for the functions

    - variables: the dictionary that contains the variables
    - macro: a decorator function, to declare a macro.
    """

    variables['baz'] = "John Doe"
    variables['time'] = strftime("%Y-%m-%d %H:%M:%S", gmtime())

    @macro
    def bar(x):
        return (2.3 * x) + 7

    # If you wish, you can  declare a macro with a different name:
    def f(x):
        return x * x

    macro(f, 'barbaz')

    # or to export some predefined function
    import math
    macro(math.floor) # will be exported as 'floor'


# def define_env(env):
#     """
#     This is the hook for the functions

#     - variables: the dictionary that contains the variables
#     - macro: a decorator function, to declare a macro.
#     """
    
#     env.variables['baz'] = "John Doe"
#     env.variables['time'] = strftime("%Y-%m-%d %H:%M:%S", gmtime())

#     @macro
#     def bar(x):
#         return (2.3 * x) + 7

#     # If you wish, you can  declare a macro with a different name:
#     def f(x):
#         return x * x

#     env.macro(f, 'barbaz')

#     # or to export some predefined function
#     import math
#     env.macro(math.floor) # will be exported as 'floor'

#     # create a jinja2 filter
#     @env.filter
#     def reverse(x):
#         "Reverse a string (and uppercase)"
#         return x.upper()[::-1]
