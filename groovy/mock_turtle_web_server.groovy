/**
* Usage:
 groovy webServer.groovy [-Pport=80]
*
* Or with gradle, place in src/main/groovy, and place assets in src/main/webapp
* and use as the mainClassName.
*/
import com.sun.net.httpserver.*

def port = System.properties.port?.toInteger() ?: 8680
def server = HttpServer.create(new InetSocketAddress(port), 0)
server.createContext("/", { HttpExchange exchange ->
 try {
	 print exchange.requestMethod
	 print ": "
	 println exchange.requestURI.path

	 print "   Headers: "
	 println exchange.requestHeaders

	 print "  Request Body: "
	 println exchange.requestBody.text

	 exchange.sendResponseHeaders(200, 0)
	 exchange.responseBody << ""
	 exchange.close()

 } catch(e) {
	 e.printStackTrace()
 }
} as HttpHandler)
server.start()
println "started simple web server on port ${port}"
