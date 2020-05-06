package com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class Payment {

	private Connection connect() {
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");

			// Provide the correct details: DBServer/DBName, username, password
			// con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/payment",
			// "root", "");

			con = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/payment?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
					"root", "");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}

	public String readPayment() {
		String output = "";
		try {
			Connection con = connect();
			if (con == null) {
				return "Error while connecting to the database for reading.";
			}
			// Prepare the html table to be displayed
			output = "<table border='1'><tr><th>PatientID</th><th>DoctorID</th>" + "<th>Card Number</th>"
					+ "<th>CVV</th>" + "<th>Card type</th" + "><th>Expiry</th>" + "<th>Amount</th></tr>";

			String query = "select * from payment";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			// iterate through the rows in the result set
			while (rs.next()) {
				String payID = Integer.toString(rs.getInt("payID"));
				String patientID = rs.getString("patientID");
				String docID = rs.getString("docID");
				String card_no = rs.getString("card_no");
				String cvv = rs.getString("cvv");
				String card_type = rs.getString("card_type");
				String exp_date = rs.getString("exp_date");
				String amount = Double.toString(rs.getDouble("amount"));

				// Add into the html table
				// output += "<tr><td><input id='hidPayIDUpdate'";

				output += "<tr><td><input id='hidPayIDUpdate'" + "name='hidLabTestIDUpdate'" + "type='hidden' value='"
						+ payID + "'>" + patientID + "</td>";

				// output += "<td>" + patientID + "</td>";
				output += "<td>" + docID + "</td>";
				output += "<td>" + card_no + "</td>";
				output += "<td>" + cvv + "</td>";
				output += "<td>" + card_type + "</td>";
				output += "<td>" + exp_date + "</td>";
				output += "<td>" + amount + "</td>";

				// buttons

				output += "<td><input name='btnUpdate'" + " type='button' value='Update'"
						+ " class='btnUpdate btn btn-secondary'></td>" + "<td><input name='btnRemove'"
						+ " type='button' value='Remove'" + " class='btnRemove btn btn-danger'" + " data-payID='"
						+ payID + "'>" + "</td></tr>";
			}
			con.close();
			// Complete the html table
			output += "</table>";
		} catch (Exception e) {
			output = "Error while reading payment details.";
			System.err.println(e.getMessage());
		}
		return output;
	}

	public String insertPayment(String patientID, String docID, String card_no, String cvv, String card_type,
			String exp_date, String amount) {
		String output = "";
		try {
			Connection con = connect();
			if (con == null) {
				return "Error while connecting to the database for inserting.";
			}
			// create a prepared statement
			// create a prepared statement
			String query = " insert into payment('payID',`patientID`,`docID`,`card_no`,`cvv`,`card_type`,`exp_date`,`amount` )"
					+ " values (?, ?, ?, ?, ?, ?, ?,?)";
			PreparedStatement preparedStmt = con.prepareStatement(query);
			// binding values
			preparedStmt.setInt(1, 0);
			preparedStmt.setString(2, patientID);
			preparedStmt.setString(3, docID);
			preparedStmt.setString(4, card_no);
			preparedStmt.setString(5, cvv);
			preparedStmt.setString(6, card_type);
			preparedStmt.setString(7, exp_date);
			preparedStmt.setDouble(8, Double.parseDouble(amount));
			// execute the statement
			preparedStmt.execute();
			con.close();
			String newPayment = readPayment();
			output = "{\"status\":\"success\", \"data\": \"" + newPayment + "\"}";
		} catch (Exception e) {
			output = "{\"status\":\"error\", \"data\": \"Error while inserting the payment.\"}";
			System.err.println(e.getMessage());
		}
		return output;
	}

	public String updatePayment(String payID, String patientID, String docID, String card_no, String cvv,
			String card_type, String exp_date, String amount) {
		String output = "";
		try {
			Connection con = connect();
			if (con == null) {
				return "Error while connecting to the database for updating.";
			}
			// create a prepared statement
			// create a prepared statement
			String query = " UPDATE payment SET patientID=? ,docID=?,card_no=?,cvv=?,card_type=?,exp_date=?,amount=? WHERE payID=?";
			PreparedStatement preparedStmt = con.prepareStatement(query);
			// binding values

			preparedStmt.setString(1, patientID);
			preparedStmt.setString(2, docID);
			preparedStmt.setString(3, card_no);
			preparedStmt.setString(4, cvv);
			preparedStmt.setString(5, card_type);
			preparedStmt.setString(6, exp_date);
			preparedStmt.setDouble(7, Double.parseDouble(amount));
			preparedStmt.setInt(8, Integer.parseInt(payID));
			// execute the statement
			preparedStmt.execute();
			con.close();
			String newPayment = readPayment();
			output = "{\"status\":\"success\", \"data\": \"" + newPayment + "\"}";
		} catch (Exception e) {
			output = "{\"status\":\"error\", \"data\":\"Error while updating payment details.\"}";
			System.err.println(e.getMessage());
		}
		return output;
	}

	public String deletePayment(String payID) {
		String output = "";
		try {
			Connection con = connect();
			if (con == null) {
				return "Error while connecting to the database for deleting.";
			}

			// create a prepared statement
			String query = "delete from payment where payID=?";
			PreparedStatement preparedStmt = con.prepareStatement(query);
			// binding values
			preparedStmt.setInt(1, Integer.parseInt(payID));
			// execute the statement
			preparedStmt.execute();
			con.close();
			String newPayment = readPayment();
			output = "{\"status\":\"success\", \"data\": \"" + newPayment + "\"}";
		} catch (Exception e) {
			output = "{\"status\":\"error\", \"data\":\"Error while deleting payment record.\"}";
			System.err.println(e.getMessage());
		}
		return output;
	}

}
