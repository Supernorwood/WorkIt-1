package controllers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ErrorController {

	@RequestMapping(path="/errors", method = RequestMethod.GET)
	public Map<String,String> errorMsg(HttpServletRequest req, HttpServletResponse res) {
		Map<String, String> response = new HashMap<>();
		
		int httpErrorCode = (Integer) req.getAttribute("javax.servlet.error.status_code");
		System.out.println(httpErrorCode);
		
		switch (httpErrorCode) {
			case 400 : {
				res.setStatus(400);
				response.put("error", "400 : Bad Request");
				break;
			}
			case 404 : {
				res.setStatus(404);
				response.put("error", "404 : Not Found");
				break;
			}
			case 500 : {
				res.setStatus(500);
				response.put("error", "500 : Internal Server Error");
				break;
			}
			default : {
				res.setStatus(500);
				response.put("error", "Something has gone awry");
			}
		}
		
		return response;
	}
}
