using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem
{
    public partial class registerPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Register(object sender, EventArgs e)
        {
            string type = Request.Form["role"];
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand reg;
            SqlParameter id;

            string pass = passwordInput.Text;
            string email = emailInput.Text;

            if (type == "student")
            {
                string fn = FnameInput.Text;
                string ln = LnameInput.Text;
                string major = majorInput.Text;
                int sem = Int16.Parse(semesterInput.Text);
                string faculty = Request.Form["facultyInput"];
                reg = new SqlCommand("dbo.Procedures_StudentRegistration", conn);
                reg.Parameters.AddWithValue("@first_name", fn);
                reg.Parameters.AddWithValue("@last_name", ln);
                reg.Parameters.AddWithValue("@faculty", faculty);
                reg.Parameters.AddWithValue("@major", major);
                reg.Parameters.AddWithValue("@Semester", sem);
                id = reg.Parameters.Add("@Student_id", SqlDbType.Int);
            }
            else // Advisor Registering
            {
                string An = AdvisornameInput.Text;
                string office = officeInput.Text;
                reg = new SqlCommand("dbo.Procedures_AdvisorRegistration", conn);
                reg.Parameters.AddWithValue("@advisor_name", An);
                reg.Parameters.AddWithValue("@office", office);
                id = reg.Parameters.Add("@Advisor_id", SqlDbType.Int);
            }

            reg.CommandType = CommandType.StoredProcedure;
            reg.Parameters.AddWithValue("@email", email);
            reg.Parameters.AddWithValue("@password", pass);
            id.Direction = ParameterDirection.Output;

            conn.Open();
            reg.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("LoginPage.aspx");

        }
    }

}