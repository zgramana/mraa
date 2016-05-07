%module (docstring="C# bindings for libmraa",imclassname="MraaNative") Mraa

%feature("autodoc", "3");

%rename("%(camelcase)s", %$isfunction) "";
%rename("%(camelcase)s", %$isvariable) "";

%include arrays_csharp.i

%include ../mraa.i
