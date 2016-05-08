%module (docstring="C# bindings for libmraa",imclassname="MraaNative") Mraa
%feature("autodoc", "3");

%rename("%(camelcase)s", %$isfunction) "";
%rename("%(camelcase)s", %$isvariable) "";

%include typemaps.i
%include arrays_csharp.i

%typemap(imtype) uint8_t * "IntPtr"
%typemap(cstype) uint8_t * "byte[]"
%typemap(ctype) uint8_t *txbuf "IntPtr"

%typemap(csout, excode=SWIGEXCODE) uint8_t * {
   $imcall;
   $excode;
   return txBuf;
}

%typemap(csin,
    pre="    IntPtr temp$csinput = default(IntPtr);",
    post="   Marshal.FreeHGlobal(temp$csinput);"
) uint8_t * "this.getCPtrAndAddReference($csinput, out temp$csinput)"

%include ../mraa.i
