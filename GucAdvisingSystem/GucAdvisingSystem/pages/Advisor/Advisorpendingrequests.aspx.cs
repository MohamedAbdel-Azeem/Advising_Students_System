using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem.pages.Advisor
{
    public partial class Advisorpendingrequests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
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


    }
}