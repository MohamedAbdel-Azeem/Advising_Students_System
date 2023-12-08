using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
            String faculty = Request.Form["facultyInput"];
            string alertScript = "alert('"+faculty+"');";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "ServerAlert", alertScript, true);
        }
    }

}