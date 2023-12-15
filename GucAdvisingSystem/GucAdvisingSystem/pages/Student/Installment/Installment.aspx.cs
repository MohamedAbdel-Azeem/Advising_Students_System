using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem.pages.Student.Installment
{
    public partial class Installment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();
            // Create a new connection to the database
            SqlConnection conn = new SqlConnection(connStr);


            conn.Open();  // Open the connection

            SqlCommand cmd = new SqlCommand("helperinstallment", conn);
            cmd.Parameters.Add(new SqlParameter("@stu", Session["id"]));
            using (cmd)

            {
                // Add parameters

                cmd.CommandType = CommandType.StoredProcedure;
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