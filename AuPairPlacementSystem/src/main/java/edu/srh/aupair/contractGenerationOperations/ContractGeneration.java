package edu.srh.aupair.contractGenerationOperations;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import ar.com.fdvs.dj.core.DynamicJasperHelper;
import ar.com.fdvs.dj.core.layout.ClassicLayoutManager;
import ar.com.fdvs.dj.domain.DynamicReport;
import ar.com.fdvs.dj.domain.builders.FastReportBuilder;
import net.sf.jasperreports.engine.JRResultSetDataSource;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.view.JasperViewer;

public class ContractGeneration {

	public static void main(String[] args) throws Exception {
		try {
			
			ResultSet rs = null;
			
			Connection conn = edu.srh.aupair.utilities.utilities.getConnectionString();
			//Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/AU_PAIR_MANAGEMENT?useSSL=false", "root",
				//	"Pass123$$");
    	   
			String query  = "SELECT * FROM proposals INNER JOIN active_interviews ON \r\n" + 
					"proposals.ACTIVE_INTERVIEW_ID =active_interviews.ACTIVE_INTERVIEW_ID INNER JOIN hostuser \r\n" + 
					"ON active_interviews.HOST_ID=hostuser.HOST_ID INNER JOIN interview_availability ON \r\n" + 
					"interview_availability.INTERVIEW_ID=active_interviews.INTERVIEW_ID INNER JOIN au_pair ON \r\n" + 
					" AU_PAIR.AU_PAIR_ID=interview_availability.AU_PAIR_ID;";
			 
			CallableStatement stmt = conn.prepareCall(query);
			rs = stmt.executeQuery(query);
			
			//rs = (ResultSet) conn.prepareStatement("select Student_Name, Student_Address, Student_Contact,MatriculationNo from student");
			
			FastReportBuilder drb = new FastReportBuilder();
			
			//String TRAVEL_COSTS = null;
			DynamicReport dr = drb.addColumn("Tasks", "TASKS_FOR_AU_PAIR", String.class.getName(), 30)
					.addColumn("Working hours", "WORKING_HOURS_PROPOSED", String.class.getName(), 30)
					.addColumn("Remuneration", "REMUNERATIONS_PROPOSED", String.class.getName(), 50)
					.addColumn("Holidays", "HOLIDAYS_PROPOSED", String.class.getName(), 50)
					.addColumn("Travel cost", "TRAVEL_COSTS", String.class.getName(), 50)					
					//.addField("TRAVEL_COSTS", "TRAVEL_COSTS")
					.addWatermark("CONTRACT")
					.setTitle("Contract between Host family and Au-Pair").setSubtitle("Below are the features agreed upon by the host family and au-pair")
					.setPrintBackgroundOnOddRows(true).setUseFullPageWidth(true).build();
			
			JRResultSetDataSource resultsetdatasource = new JRResultSetDataSource(rs); 
			
			JasperPrint jp = DynamicJasperHelper.generateJasperPrint(dr, new ClassicLayoutManager(),
					resultsetdatasource);
			JasperViewer.viewReport(jp); 
			
			String currentUsersHomeDir = System.getProperty("user.home");
			
			JasperExportManager.exportReportToPdfFile(jp, currentUsersHomeDir + "/ContractForHostAndAuPair.pdf");
			
//			File f = new File();
//			f.	
					
			
		} catch (Exception ex) {
			System.out.println(ex);
		}
	}

	

}
