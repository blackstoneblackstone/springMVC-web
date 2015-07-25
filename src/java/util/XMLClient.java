package util;

        import java.io.IOException;
        import org.apache.http.HttpResponse;
        import org.apache.http.client.ClientProtocolException;
        import org.apache.http.client.methods.HttpPost;
        import org.apache.http.entity.StringEntity;
        import org.apache.http.impl.client.DefaultHttpClient;
/**
 * HTTP Client, to send data of XML type to Server. This is a demonstration of
 * how to use HTTP Client API
 *
 * @author Lv Pin
 *
 */
public class XMLClient {
    /**
     * HTTP Client Object,used HttpClient Class before(version 3.x),but now the
     * HttpClient is an interface
     */
    private DefaultHttpClient client;
    /**
     * Get XML String
     *
     * @return XML-Formed string
     */
    public String getXMLString() {
// A StringBuffer Object
        StringBuffer sb = new StringBuffer();
        sb.append(IClient.XML_HEADER);
        sb.append("<xml>\n" +
                "        <ToUserName><![CDATA[gh_ca62a1cf16c2]]></ToUserName>\n" +
                "        <FromUserName><![CDATA[oOyW3s3fGu-XRhEnK0wx32Q9mi6Y]]></FromUserName>\n" +
                "        <CreateTime>1348831860</CreateTime>\n" +
                "        <MsgType><![CDATA[text]]></MsgType>\n" +
                "        <Content><![CDATA[hhhhfasfjkbaksfbjksk]]></Content>\n" +
                "        <MsgId>1234567890123456</MsgId>\n" +
                "        </xml>");
        return sb.toString();
    }
    /**
     * Send a XML-Formed string to HTTP Server by post method
     *
     * @param url
     *            the request URL string
     * @param xmlData
     *            XML-Formed string ,will not check whether this string is
     *            XML-Formed or not
     * @return the HTTP response status code ,like 200 represents OK,404 not
     *         found
     * @throws IOException
     * @throws ClientProtocolException
     */
    public Integer sendXMLDataByPost(String url, String xmlData)
            throws ClientProtocolException, IOException {
        Integer statusCode = -1;
        if (client == null) {
            // Create HttpClient Object
            client = new DefaultHttpClient();
        }
// Send data by post method in HTTP protocol,use HttpPost instead of
        // PostMethod which was occurred in former version
        HttpPost post = new HttpPost(url);
// Construct a string entity
        StringEntity entity = new StringEntity(xmlData);
        // Set XML entity
        post.setEntity(entity);
        // Set content type of request header
        post.setHeader("Content-Type", "text/xml;charset=ISO-8859-1");
// Execute request and get the response
        HttpResponse response = client.execute(post);
        // Response Header - StatusLine - status code
        statusCode = response.getStatusLine().getStatusCode();
        return statusCode;
    }

    /**
     * Main method
     * @param args
     * @throws IOException
     * @throws ClientProtocolException
     */
    public static void main(String[] args) throws ClientProtocolException, IOException {

        while (true) {
            XMLClient client = new XMLClient();
            Integer statusCode = client.sendXMLDataByPost("http://lihb/index.php/api/kshsth1436346812", client.getXMLString());
            if (statusCode == 200) {
                System.out.println("Request Success,Response Success!!!");
            } else {
                System.out.println("Response Code :" + statusCode);
            }
        }
    }
}