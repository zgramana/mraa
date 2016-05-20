%module (docstring="C# bindings for libmraa",imclassname="MraaNative") Mraa
%feature("autodoc", "3");

%rename("%(camelcase)s", %$isfunction) "";
%rename("%(camelcase)s", %$isvariable) "";

%include typemaps.i
%include arrays_csharp.i

// %typemap(ctype) int "int"
//%typemap(cstype) int length "int"
//%typemap(imtype) int length "int"

//%typemap(ctype) (const uint8_t *data, int length) "byte[]"
%typemap(cstype) (const uint8_t* data, int length) "byte[]"
%typemap(imtype, out="IntPtr") (const uint8_t* data, int length) "byte[]"
%typemap(csin) (const uint8_t* data, int length) "$csinput"

%typemap(in,numinputs=1) (const uint8_t* data, int length) {
//  $1 = JCALL2(GetByteArrayElements, jenv, $input, NULL);
    $1 = ($1_ltype)$input;
//  $2 = JCALL1(GetArrayLength, jenv, $input);
    $2 = sizeof($1)/sizeof($1[0]);
}

%apply (const uint8_t* data, int length) { (uint8_t* data, int length) }


// GOOD STUFF HERE
// %typemap(cstype) (const uint8_t* data, int length) "Byte[]"
// %typemap(imtype, out="IntPtr") (const uint8_t* data, int length) "Byte[]"
// %typemap(csin,
//     pre="    IntPtr temp$csinput = default(IntPtr);//Byte[]",
//     post="   Marshal.FreeHGlobal(temp$csinput);"
// ) (const uint8_t* data, int length) "this.getCPtrAndAddReference($csinput, out temp$csinput)"

// %typemap(in,numinputs=1) (const uint8_t* data, int length) {
// //  $1 = JCALL2(GetByteArrayElements, jenv, $input, NULL);
// //  $2 = JCALL1(GetArrayLength, jenv, $input);
// }

// %apply (const uint8_t* data, int length) { (uint8_t* data, int length) }




//%typemap(ctype) (uint8_t *data, int length) "byte[]"
//%typemap(cstype) (uint8_t *data, int length) "byte[]"
//%typemap(imtype) (uint8_t *data, int length) "byte[]"
//%typemap(csin,
//    pre="    IntPtr temp$csinput = default(IntPtr);",
//    post="   Marshal.FreeHGlobal(temp$csinput);"
//) (uint8_t *data, int length) "this.getCPtrAndAddReference($csinput, out temp$csinput)"

//%typemap(ctype) (uint8_t*, int) "IntPtr"
//%typemap(cstype) (uint8_t*, int) "byte[]"
//%typemap(imtype) (uint8_t*, int) "IntPtr"
//%typemap(csin,
//    pre="    IntPtr temp$csinput = default(IntPtr);",
//    post="   Marshal.FreeHGlobal(temp$csinput);"
//) (uint8_t*, int) "this.getCPtrAndAddReference($csinput, out temp$csinput)"

//%typemap(imtype) uint8_t * "IntPtr"
//%typemap(cstype) uint8_t * "byte[]"
//%typemap(ctype) uint8_t * "IntPtr"


// %typemap(csout, excode=SWIGEXCODE) uint8_t * {
//    $imcall;
//    $excode;
//    return txBuf;
// }

// %typemap(csin,
//     pre="    IntPtr temp$csinput = default(IntPtr);",
//     post="   Marshal.FreeHGlobal(temp$csinput);"
// ) uint8_t * "this.getCPtrAndAddReference($csinput, out temp$csinput)"

%include ../mraa.i
