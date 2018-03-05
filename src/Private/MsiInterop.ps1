#P/Invoke signature and type creation
$pinvokeSignature = @'
using System.Runtime.InteropServices;
using System.Text;
public class MsiInterop
{
    [DllImport("msi.dll", CharSet=CharSet.Unicode)]
    public static extern uint MsiEnumProducts(int iProductIndex, StringBuilder lpProductBuf);
        
    [DllImport("msi.dll", CharSet=CharSet.Unicode)]
    public static extern int MsiGetProductInfo(string product, string property, [Out] StringBuilder valueBuf, ref int len); 
}
'@

Add-Type -TypeDefinition $pinvokeSignature