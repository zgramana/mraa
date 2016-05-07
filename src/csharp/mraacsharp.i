%module (docstring="C# bindings for libmraa",imclassname="MraaNative") Mraa

%feature("autodoc", "3");

%include arrays_csharp.i

//%apply byte INOUT[] { uint8_t *txBuf, int length }

// %apply byte FIXED[] { uint8_t *txBuf, int length }
// %csmethodmodifiers myArrayCopy "public unsafe";
 
//%typemap(imtype) (uint8_t *txBuf, int length) "byte[]"
//%typemap(cstype) (uint8_t *txBuf, int length) "byte[]"
//%typemap(ctype) (uint8_t *txBuf, int length) "byte[]"
//%typemap(csin) (uint8_t *txBuf, int length) "$csinput"

//%typemap(in,numinputs=1) (uint8_t *txBuf, int length) {
//  $1 = JCALL2(GetByteArrayElements, jenv, $input, NULL);
//  $2 = JCALL1(GetArrayLength, jenv, $input);
//}



//%apply byte INOUT[] { uint8_t *data, int length }
// %apply byte FIXED[] { uint8_t *txBuf, int length }
// %csmethodmodifiers myArrayCopy "public unsafe";
 
//%typemap(imtype) (uint8_t *data, int length) "byte[]"
//%typemap(cstype) (uint8_t *data, int length) "byte[]"
//%typemap(ctype) (uint8_t *data, int length) "byte[]"
//%typemap(csin) (uint8_t *data, int length) "$csinput"

//%typemap(in,numinputs=1) (uint8_t *data, int length) {
//  $1 = JCALL2(GetByteArrayElements, jenv, $input, NULL);
//  $2 = JCALL1(GetArrayLength, jenv, $input);
//}

//%typemap(argout) (uint8_t *data, int length) {
//  JCALL3(ReleaseByteArrayElements, jenv, $input, $1, JNI_COMMIT);
//}

// %apply byte INOUT[] { const uint8_t *data, int length }

//%typemap(imtype) (const uint8_t *data, int length) "byte[]"
//%typemap(cstype) (const uint8_t *data, int length) "byte[]"
//%typemap(ctype) (const uint8_t *data, int length) "byte[]"
//%typemap(csin) (const uint8_t *data, int length) "$csinput"
// %typemap(in) (const uint8_t *data, int length) {
//   $1 = JCALL2(GetByteArrayElements, jenv, $input, NULL);
//   $2 = JCALL1(GetArrayLength, jenv, $input);
// }

// %apply byte INOUT[] { uint8_t * }
//%typemap(imtype) uint8_t * "byte[]"
//%typemap(cstype) uint8_t * "byte[]"
//%typemap(ctype) uint8_t * "byte[]"
//%typemap(csout) uint8_t * {
//   return $imcall;
//}

// %typemap(imtype) jobject runnable "csharp.lang.Runnable"
// %typemap(cstype) jobject runnable "csharp.lang.Runnable"

// namespace Mraa {
// class Spi;
// %typemap(out) uint8_t*
// {
//   /* need to loop over length */
//   $result = JCALL1(NewByteArray, jenv, arg3);
//   JCALL4(SetByteArrayRegion, jenv, $result, 0, arg3, (jbyte *) $1);
//   free($1);
// }
// }

// %ignore write(const char* data, int length);
// %ignore read(char* data, int length);
// %ignore globVM;
// %ignore env_key;
// %ignore mraa_csharp_isr_callback;

%include ../mraa.i

// %wrapper %{
//     JavaVM *globVM;

//     jint JNI_OnLoad(JavaVM *vm, void *reserved) {
//         /* initialize mraa */
//         globVM = vm;
//         mraa_init();
//         return JNI_VERSION_1_6;
//     }
// %}

// %pragma(csharp) imclasscode=%{
//     static {
//         try {
//             System.loadLibrary("mraacsharp");
//         } catch (UnsatisfiedLinkError e) {
//             System.err.println("Native code library failed to load. \n" + e);
//             System.exit(1);
//         }
//     }
// %}
