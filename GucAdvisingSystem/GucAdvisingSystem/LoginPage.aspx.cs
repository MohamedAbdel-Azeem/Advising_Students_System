using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing.Printing;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void login(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            // Create a new connection to the database
            SqlConnection conn = new SqlConnection(connStr);
            try
            {
                Int16.Parse(UsernameInput.Text);
            } catch (Exception)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error!', 'User ID must be a number!', 'error');", true);
                return;
            }

            int username = Int16.Parse(UsernameInput.Text);
            String pass = PasswordInput.Text;
            String type = "Student";
            type = Request.Form["role"];
            SqlCommand log = new SqlCommand();

        if (type == "Student")
        {
            log = new SqlCommand("Select dbo.FN_StudentLogin(@Student_Id, @password)", conn);
            log.Parameters.AddWithValue("@Student_Id", username);
            log.CommandType = CommandType.Text;
            log.Parameters.AddWithValue("@password", pass);

            conn.Open();
            bool result = (bool)log.ExecuteScalar();
            conn.Close();
            if (result == true)
            {
                // Re-Direct to Student Page
                Response.Write("<script>console.log('success')</script>");
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error!', 'User ID or Password are Incorrect!', 'error');", true);
            } 
        }
        else
        {
            if (type == "Advisor")
            {
                log = new SqlCommand("Select dbo.FN_AdvisorLogin(@advisor_Id, @password)", conn);
                log.Parameters.AddWithValue("@advisor_Id", username);
                log.CommandType = CommandType.Text;
                log.Parameters.AddWithValue("@password", pass);

                conn.Open();
                bool result = (bool)log.ExecuteScalar();
                conn.Close();
                if (result == true)
                {
                    //Re-Direct to Advisor Page
                    Response.Write("<script>console.log('success')</script>");
                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error!', 'User ID or Password are Incorrect!', 'error');", true);
                }
            } else // admin code
                {
                    if (username == 2004 && pass == "password")
                    {
                        Response.Redirect("AdminPage.aspx");
                    }
                    else
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error!', 'Go Away!', 'error');", true);
                    }
                }
        }
        }
    }
}