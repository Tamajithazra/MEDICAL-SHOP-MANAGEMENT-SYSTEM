package java_resource;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * Servlet implementation class PdfGenerator
 */
@WebServlet("/generatePdf")
public class PdfGenerator extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//String name=request.getParameter("name");
		//String medicineData=request.getParameter("medicines");
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition","attachment; filename=\"MEDICINE_SHOP_INVOICE.pdf\"");
		try(ServletOutputStream out=response.getOutputStream())
		{
			Document document=new Document();
			PdfWriter.getInstance(document, out);
			document.open();
			// Font
			Font tittleFont=new Font(Font.FontFamily.HELVETICA,18,Font.BOLD);
			Paragraph tittle=new Paragraph("Medical_Invoice",tittleFont);
			tittle.setAlignment(Element.ALIGN_CENTER);
			document.add(tittle);
			document.add(new Paragraph("\n"));
			
			
			//fetching from data
			String name=request.getParameter("name");
			String address=request.getParameter("address");
			String paymentMethod=request.getParameter("paymentMethod");
			String medicineData=request.getParameter("medicines");
			String totalAmount=request.getParameter("totalamount");
			
			// customer details
			document.add(new Paragraph("NAME :"+name));
			document.add(new Paragraph("Address :"+address));
			document.add(new Paragraph("PAYMENT METHOD :" +paymentMethod));
			document.add(new Paragraph("\n"));
			
			//medicine table
			PdfPTable table=new PdfPTable(3);
			table.setWidthPercentage(100);
			table.setSpacingBefore(10);
			table.setSpacingAfter(10);
			
			//table headers
			Font headerfont=new Font(Font.FontFamily.HELVETICA,12,Font.BOLD);
			PdfPCell h1=new PdfPCell(new Phrase("MEDICINE-NAME",headerfont));
			PdfPCell h2=new PdfPCell(new Phrase("Units",headerfont));
			PdfPCell h3=new PdfPCell(new Phrase("Amount",headerfont));
			
			h1.setBackgroundColor(BaseColor.LIGHT_GRAY);
			h2.setBackgroundColor(BaseColor.LIGHT_GRAY);
			h3.setBackgroundColor(BaseColor.LIGHT_GRAY);
			
			table.addCell(h1);
			table.addCell(h2);
			table.addCell(h3);
			
			//parse medicine list (using json)
			if (medicineData != null && !medicineData.isEmpty()) {
			    JsonArray medicines=JsonParser.parseString(medicineData).getAsJsonArray();
			    
			    // Iterate over medicines array
			    for (int i = 0; i < medicines.size(); i++) {
			        JsonObject med=medicines.get(0).getAsJsonObject();
			        table.addCell(med.get("name").getAsString());
			        table.addCell(String.valueOf(med.get("units").getAsInt()));
			        table.addCell("₹"+ med.get("amount").getAsInt());
			        
			    }
			}
			document.close();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
