using System;
using System.Runtime.InteropServices;

namespace Mraa
{
    public static class Extensions
    {
        public static global::System.IntPtr getCPtrAndAddReference(this Object obj, byte[] buffer, out IntPtr buffPtr)
        {
            buffPtr = Marshal.AllocHGlobal(Marshal.SizeOf(buffer));
            Marshal.Copy(buffer, 0, buffPtr, buffer.Length);
            return buffPtr;
        }        
    }
}