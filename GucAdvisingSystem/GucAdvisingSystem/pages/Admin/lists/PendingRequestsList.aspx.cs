using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GucAdvisingSystem.pages.Admin.lists
{
    public partial class PendingRequestsList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            // create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM all_Pending_Requests", conn);
            cmd.CommandType = CommandType.Text;
            cmd.ExecuteNonQuery();

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();
            da.Fill(dt);
            PendingReqList.DataSource = dt;
            PendingReqList.DataBind();
            conn.Close();

        }
    }
}