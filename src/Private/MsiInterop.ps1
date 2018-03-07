#P/Invoke signature and type creation
$pinvokeSignature = @'
using System.Runtime.InteropServices;
using System.Text;
using System;
public class MsiInterop
{
    [DllImport("msi.dll", CharSet=CharSet.Unicode)]
    public static extern uint MsiEnumProducts(int iProductIndex, StringBuilder lpProductBuf);
        
    [DllImport("msi.dll", CharSet=CharSet.Unicode)]
    public static extern int MsiGetProductInfo(string product, string property, [Out] StringBuilder valueBuf, ref int len); 
        
    [DllImport("msi.dll", CharSet=CharSet.Unicode)]
    public static extern int MsiInstallProduct(string product, string cmd); 

    [DllImport("msi.dll", CharSet=CharSet.Unicode)]
    public static extern int MsiSetInternalUI(int installUILevel, ref IntPtr hwnd);
}
'@

Add-Type -TypeDefinition $pinvokeSignature