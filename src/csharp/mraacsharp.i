%module (docstring="C# bindings for libmraa",imclassname="MraaNative") Mraa
%feature("autodoc", "3");

%rename("%(camelcase)s", %$isfunction) "";
%rename("%(camelcase)s", %$isvariable) "";

%include typemaps.i
%include arrays_csharp.i

%typemap(cstype) (const uint8_t* data, int length) "byte[]" 
%typemap(imtype, out="IntPtr") (const uint8_t* data, int length) "byte[]"
%typemap(csin) (const uint8_t* data, int length) "$csinput"

%typemap(in,numinputs=1) (const uint8_t* data, int length) {
//  $1 = JCALL2(GetByteArrayElements, jenv, $input, NULL);
    $1 = ($1_ltype)$input;
//  $2 = JCALL1(GetArrayLength, jenv, $input);
    $2 = sizeof($1)/sizeof($1[0]);
}

// Handle buffers as return values.
%typemap(csout, excode=SWIGEXCODE) uint8_t* {
    var ret = $imcall;
   $excode;
    var buffer = new byte[txBuf.Length];
    Marshal.Copy(ret, buffer, 0, txBuf.Length);
    return buffer;
}

%apply (const uint8_t* data, int length) { (uint8_t* txBuf, int length) }
%apply (const uint8_t* data, int length) { (uint16_t* txBuf, int length) }

// %typemap(out) uint8_t* "byte[]"
%typemap(cstype) uint8_t* write "byte[]" 

%typemap(cstype) (uint8_t* txbuf) "byte[]" 
//%typemap(imtype, out="byte[]") (uint8_t* txbuf) "byte[]"
%typemap(csin) (uint8_t* txbuf) "$csinput"

%typemap(cstype) (uint8_t* rxbuf) "byte[]" 
//%typemap(ctype) (uint8_t* rxbuf) "byte[]" 
//%typemap(imtype, out="byte[]") (uint8_t* rxbuf) "byte[]"
%typemap(csin) (uint8_t* rxbuf) "$csinput"

%typemap(cstype) (uint8_t* Write) "byte[]" 


//%apply int INPUT[] {uint8_t* txBuf}
//%apply int OUTPUT[] {uint8_t* rxBuf}
// %apply byte INPUT[] {uint8_t* txBuf}
// %apply byte OUTPUT[] {uint8_t* rxBuf}
// %apply ushort INPUT[] {uint16_t* txBug}
// %apply ushort OUTPUT[] {uint16_t* rxBuf}

// SPI Write Transfer
//%typemap(cstype) (uint8_t* data, uint8_t* rxbuf, int length) "byte[], byte[]"

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
