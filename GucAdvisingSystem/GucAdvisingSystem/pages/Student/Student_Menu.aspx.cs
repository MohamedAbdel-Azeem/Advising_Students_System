using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


namespace GucAdvisingSystem.pages.Student
{
    public partial class Student_Menu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String id = Session["id"] + "";
            String query = $"Select * from Student where student_id = {id};";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.CommandType = CommandType.Text;

            conn.Open();
            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read()) {
                    fullName.InnerText = id+": "+ rdr["f_name"] + " " + rdr["l_name"];
                    major.InnerText = rdr["major"] + "";
                    email.InnerText = rdr["email"] + "";
                    gpa.InnerText = rdr["gpa"] + "";
                    faculty.InnerText = rdr["faculty"] + "";
                    semester.InnerText = rdr["semester"] + "";
                    currSem.InnerText = Session["SEM"] + "";
                }
            }
            conn.Close();

            String phoneQuery = $"Select phone_number from Student_Phone where student_id = {id};";
            SqlCommand phoneCmd = new SqlCommand(phoneQuery, conn);
            phoneCmd.CommandType = CommandType.Text;
            conn.Open();
            using (SqlDataReader rdr = phoneCmd.ExecuteReader())
            {
                while (rdr.Read())
                {
                    HtmlGenericControl phoneParagraph = new HtmlGenericControl("p");
                    phoneParagraph.InnerText = rdr["phone_number"].ToString();

                    // Add the <p> tag to the <div>
                    studentPhone.Controls.Add(phoneParagraph);
                }
            }
            conn.Close();


        }


    }
}