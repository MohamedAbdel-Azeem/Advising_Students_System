using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem.pages.Student.Slots
{
    public partial class ViewSlot : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            // Create a new connection to the database
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();  // Open the connection

            SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.FN_StudentViewSlot(@CourseID,@InstructorID)", conn);
            cmd.Parameters.AddWithValue("@CourseID", Session["course"]);
            cmd.Parameters.AddWithValue("@InstructorID", Session["instructor"]);
            using (cmd)
            {
                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();
                da.Fill(dt);

                // Now you can use the DataTable object to display the data.
                // For example, you can bind it to a GridView:
                GridView1.DataSource = dt;
                GridView1.DataBind();
                conn.Close();
                ApplyStylingForOddRows();
            }
        }
        protected void ApplyStylingForOddRows()
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    if (row.RowIndex % 2 == 1) // Odd row
                    {
                        row.CssClass = "myAltRowClass";
                    }
                }
            }
        }
    }
}