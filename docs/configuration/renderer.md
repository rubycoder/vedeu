Sets the renderers for Vedeu. Each renderer added must have the class
method '.render' defined as this will be called when rendering
content.

    Vedeu.configure do
      renderer MyRenderer
      # ...
    end

    Vedeu.configure do
      renderers MyRenderer, MyOtherRenderer
      # ...
    end
