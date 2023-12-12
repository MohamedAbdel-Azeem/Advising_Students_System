using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlTypes;

namespace GucAdvisingSystem.pages.Advisor
{
    public partial class AdvisorPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

       /*
        protected void Viewstudadv(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand View = new SqlCommand("Procedures_AdvisorViewAssignedStudents", conn);
            string major = Request.Form["majorInput"];
            View.Parameters.AddWithValue("@AdvisorID", Session["id"]);
            View.Parameters.AddWithValue("@major", major);
            DataTable dtTable = new DataTable();

            View.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter adp = new SqlDataAdapter(View);
            conn.Open();
            adp.Fill(dtTable);
            conn.Close();
            GridV.DataSource = dtTable;
            GridV.DataBind();




        }
        protected void Viewreq(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand View = new SqlCommand("Select * from FN_Advisors_Requests(@advisor_id)", conn);
            View.Parameters.AddWithValue("@advisor_id", Session["id"]);
            DataTable dtTable = new DataTable();
            SqlDataAdapter adp = new SqlDataAdapter(View);
            conn.Open();
            adp.Fill(dtTable);
            conn.Close();
            GridView1.DataSource = dtTable;
            GridView1.DataBind();




        }

        protected void Viewpendingreq(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand View = new SqlCommand("Procedures_AdvisorViewPendingRequests", conn);
            View.Parameters.AddWithValue("@Advisor_ID", Session["id"]);
            DataTable dtTable = new DataTable();
            SqlDataAdapter adp = new SqlDataAdapter(View);
            View.CommandType = CommandType.StoredProcedure;
            conn.Open();
            adp.Fill(dtTable);
            conn.Close();
            GridView2.DataSource = dtTable;
            GridView2.DataBind();




        }

        protected void Viewadvising(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string query = "Select * from  Student where advisor_id=(@value)";
            SqlCommand View = new SqlCommand(query, conn);
            View.Parameters.AddWithValue("@value", Session["id"]);
            SqlDataAdapter adp2 = new SqlDataAdapter(View);
            DataTable dtTable = new DataTable();
            conn.Open();
            adp2.Fill(dtTable);
            conn.Close();
            GridView3.DataSource = dtTable;
            GridView3.DataBind();




        }

        protected void Insertgradplan(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand View = new SqlCommand("Procedures_AdvisorCreateGP", conn);
            View.CommandType= CommandType.StoredProcedure;
            string semester_code = sem_code.Text;
            string graduation_date =grad_date.Text;
            int credit_hours = Int16.Parse(sem_credit_hours.Text);
            int student_Id = Int16.Parse(studentId.Text);
            View.Parameters.AddWithValue("@advisor_iD", Session["id"]);
            View.Parameters.AddWithValue("@expected_graduation_date", graduation_date);
            View.Parameters.AddWithValue("@sem_credit_hours", credit_hours);
            View.Parameters.AddWithValue("@student_id", student_Id);
            View.Parameters.AddWithValue("@Semester_code", semester_code);
            conn.Open();
            View.ExecuteNonQuery();
            conn.Close();


        }

        protected void Insertcourses(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand View = new SqlCommand("Procedures_AdvisorAddCourseGP", conn);
            View.CommandType = CommandType.StoredProcedure;
            string semester_code = sem_code1.Text;
            string Course_name = course_name.Text;
            int student_Id = Int16.Parse(studentId1.Text);
            View.Parameters.AddWithValue("@course_name", Course_name);
            View.Parameters.AddWithValue("@student_id", student_Id);
            View.Parameters.AddWithValue("@Semester_code", semester_code);
            conn.Open();
            View.ExecuteNonQuery();
            conn.Close();
            sem_code1.Text = string.Empty;
            course_name.Text = string.Empty;
            studentId1.Text = string.Empty;
        }

        protected void UpdateGP(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand View = new SqlCommand("Procedures_AdvisorUpdateGP", conn);
            View.CommandType = CommandType.StoredProcedure;
            string graduation_date = grad_date1.Text;
            int student_Id = Int16.Parse(studentId2.Text);
            View.Parameters.AddWithValue("@studentId", student_Id);
            View.Parameters.AddWithValue("@expected_grad_date", graduation_date);
            conn.Open();
            View.ExecuteNonQuery();
            conn.Close();
            grad_date1.Text = string.Empty;
            studentId2.Text = string.Empty;
        }

        protected void Deletecourses(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand View = new SqlCommand("Procedures_AdvisorDeleteFromGP", conn);
            View.CommandType = CommandType.StoredProcedure;
            string semester_code = sem_code2.Text;
            string Course_name = courseID.Text;
            int student_Id = Int16.Parse(studentId3.Text);
            View.Parameters.AddWithValue("@courseID", Course_name);
            View.Parameters.AddWithValue("@studentID", student_Id);
            View.Parameters.AddWithValue("@sem_code", semester_code);
            conn.Open();
            View.ExecuteNonQuery();
            conn.Close();
            sem_code2.Text = string.Empty;
            courseID.Text = string.Empty;
            studentId3.Text = string.Empty;
        }

        protected void Apprejreq(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand View = new SqlCommand("Procedures_AdvisorApproveRejectCHRequest", conn);
            View.CommandType = CommandType.StoredProcedure;
            int request_Id = Int16.Parse(RequestId.Text);
            View.Parameters.AddWithValue("@requestID", request_Id);
            View.Parameters.AddWithValue("@current_sem_code", Session["Cur_sem"]);
            conn.Open();
            View.ExecuteNonQuery();
            conn.Close();
            RequestId.Text = string.Empty;
        }

        protected void ApprejreqC(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand View = new SqlCommand("Procedures_AdvisorApproveRejectCourseRequest", conn);
            View.CommandType = CommandType.StoredProcedure;
            int request_Id = Int16.Parse(req.Text);
            View.Parameters.AddWithValue("@requestID", request_Id);
            View.Parameters.AddWithValue("@current_semester_code", Session["Cur_sem"]);
            conn.Open();
            View.ExecuteNonQuery();
            conn.Close();
            req.Text = string.Empty;
        }*/



    }
}