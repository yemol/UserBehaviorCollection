using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.Entity;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UserBehaviorCollection.Report
{
    public partial class Display : System.Web.UI.Page
    {
        private sitestatisticsEntities db = new sitestatisticsEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bindReport();
            }
        }
        protected void GVReport_RowCommand(object sender, GridViewCommandEventArgs e)
        {
        }

        private void bindReport()
        {
            GVReport.DataSource = db.StatisticsHeaders.ToList();
            GVReport.DataBind();
        }
    }
}