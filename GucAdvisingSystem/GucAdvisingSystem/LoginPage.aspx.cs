using System;
using System.Collections.Generic;
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
            String connStr = WebConfigurationManager.ConnectionStrings["GucAdvisingSystem"].ToString();
            // Create a new connection to the database
            SqlConnection conn = new SqlConnection(connStr);

            int username = Int16.Parse(UsernameInput.Text);
            String pass = PasswordInput.Text;
            string type = Request.Form["role"];
        }
    }
}