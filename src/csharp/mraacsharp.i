%module (docstring="C# bindings for libmraa",imclassname="MraaNative") Mraa

%feature("autodoc", "3");

%typemap(cscode) mraa::Spi %{
    public global::System.IntPtr getCPtrAndAddReference(byte[] buffer, out IntPtr buffPtr)
    {
        buffPtr = Marshal.AllocHGlobal(Marshal.SizeOf(buffer));
        Marshal.Copy(buffer, 0, buffPtr, buffer.Length);
        return buffPtr;
    }
%}

%typemap(cscode) mraa::I2c %{
    public global::System.IntPtr getCPtrAndAddReference(byte[] buffer, out IntPtr buffPtr)
    {
        buffPtr = Marshal.AllocHGlobal(Marshal.SizeOf(buffer));
        Marshal.Copy(buffer, 0, buffPtr, buffer.Length);
        return buffPtr;
    }
%}

%rename("%(camelcase)s", %$isfunction) "";
%rename("%(camelcase)s", %$isvariable) "";

%include typemaps.i
%include arrays_csharp.i

%typemap(imtype) uint8_t * "IntPtr"
%typemap(cstype) uint8_t * "byte[]"
%typemap(ctype) uint8_t *txbuf "IntPtr"

%typemap(csout) uint8_t * {
   $imcall;
   $excode;
   return txBuf;
}

%typemap(csin,
    pre="IntPtr temp$csinput = default(IntPtr);",
    post="   Marshal.FreeHGlobal(temp$csinput);"
) uint8_t * "getCPtrAndAddReference($csinput, out temp$csinput)"


%include ../mraa.i
