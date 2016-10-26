# this file is a 'module' for Rails to includes with other classes for our app
# the method in this file can be use across this app's all files
module ApplicationHelper
    # def method 'form_group_tag', it takes two arguments (array for errors)(a bloc)
    # '&' truns the block into a 'Proc', which can be reused like a variable
    def form_group_tag(errors, &block)
        css_class = 'form-group'
        css_class << 'has-error' if errors.any?
        # call 'content_tag helper method'
        # it will build the HTML & CSS for display form element and any associated errors
        # this kind of helpers are written in Ruby and return a HTML.
        # 'content_tag' take a 'symbol argument'(block), and an 'option hash'. It will create the symbol-specified HTML tag with the block contents, and the options are for specified
        content_tag :div, capture(&block), class: css_class
    end
end
