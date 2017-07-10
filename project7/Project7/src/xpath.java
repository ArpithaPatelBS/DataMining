
import java.net.URL;
import java.net.URLEncoder;
import java.util.Scanner;


import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.*;


import org.w3c.dom.*;

class xpath{

    static void print ( Node e ) {
		if (e instanceof Text)
		    System.out.print(((Text) e).getData());
		else {
		    NodeList c = e.getChildNodes();
		    System.out.print("<"+e.getNodeName());
		    NamedNodeMap attributes = e.getAttributes();
		    for (int i = 0; i < attributes.getLength(); i++)
			System.out.print(" "+attributes.item(i).getNodeName()
					 +"=\""+attributes.item(i).getNodeValue()+"\"");
		    System.out.print(">");
		    for (int k = 0; k < c.getLength(); k++)
			print(c.item(k));
		    System.out.print("</"+e.getNodeName()+">");
		}
    }

    static void eval (String query, String keyword) throws Exception {
    	
    	DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
    	DocumentBuilder db = dbf.newDocumentBuilder();
    	Document doc = db.parse((new URL("http://sandbox.api.shopping.com/publisher/3.0/rest/GeneralSearch?apiKey=78b0db8a-0ee1-4939-a2f9-d3cd95ec0fcc&visitorUserAgent&visitorIPAddress&trackingId=7000610&categoryId=72&keyword="+URLEncoder.encode(keyword, "UTF-8"))).openStream());
    	XPathFactory xpathFactory = XPathFactory.newInstance();
		XPath xpath = xpathFactory.newXPath();
    	
    	
		
		NodeList result = (NodeList) xpath.compile(query).evaluate(doc,XPathConstants.NODESET);
		System.out.println("Result : Count : " + result.getLength());
		System.out.println("XPath query: "+query);
		for (int i = 0; i < result.getLength(); i++)
		    print(result.item(i));
		System.out.println();
    }

    public static void main ( String[] args ) throws Exception {
    	System.out.println("Enter the keyword for search : ");
    	
    	Scanner in = new Scanner(System.in);
        String keyword = in.nextLine();
        in.close();    
    	System.out.println("*************************");
    	String queryRating = "//product[rating/rating>4.5]/fullDescription";
    	eval(queryRating, keyword);
    	System.out.println("*************************");
    	String queryNameMinPrice = "//product/name[contains(.,'Sony')] | //product[contains(name,'Sony')]/minPrice";
    	eval(queryNameMinPrice, keyword);
    	System.out.println("*************************");
    	String query = "//product[contains(name,'Sony') and minPrice>=1000 and minPrice<=2000]/name";
    	eval(query, keyword);
    	System.out.println("*************************");
    }
}