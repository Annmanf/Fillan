
/**
 * swichcall
 */
public class swichcall {

    public static boolean isSwishInstalled(Context context) {
        try {
            context.getPackageManager()
                    .getPackageInfo("se.bankgirot.swish", 0);
            return true;
        } catch (PackageManager.NameNotFoundException e) {
            // Swish app is not installed
            return false;
        }
    }
    
    public static boolean openSwishWithToken(Context context, String token, String callBackUrl) {
        if ( token == null
                || token.length() == 0
                || callBackUrl == null
                || callBackUrl.length() == 0
                || context == null) {
            return false;
        }
    
        // Construct the uri
        // Note that appendQueryParameter takes care of uri encoding
        // the parameters
        Uri url = new Uri.Builder()
                .scheme("swish")
                .authority("paymentrequest")
                .appendQueryParameter("token", token)
                .appendQueryParameter("callbackurl", callBackUrl)
                .build();
    
        Intent intent = new Intent(Intent.ACTION_VIEW, url);
        intent.setPackage("se.bankgirot.swish");
    
        try {
            context.startActivity(intent);
        } catch (Exception e){
            // Unable to start Swish
            return false;
        }
    
        return true;
    }
    
}