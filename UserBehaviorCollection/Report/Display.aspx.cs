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
        private UserBehaviorDataContext db = new UserBehaviorDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bindReport();
            }
        }
     

        private void bindReport()
        {
            GVUsers.DataSource = db.UserVisits.ToList();
            GVUsers.DataBind();
        }

        protected void GVUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void GVUsers_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                GridView GVPages = (GridView)e.Row.FindControl("GVPages");
                if (GVPages != null)
                {
                    string userIdentity = GVUsers.DataKeys[e.Row.RowIndex].Value.ToString();
                    List<PageVisit> pageVisits = db.PageVisits.Where(p => p.UserIdentity.ToString().Equals(userIdentity)).ToList();
                    if (pageVisits.Count > 1)
                    {
                        GVPages.Columns[0].HeaderText = "Steps";
                    }
                    GVPages.DataSource = pageVisits;
                    GVPages.DataBind();
                }
            }
        }

        public string nullDesri(object str, string returnValue)
        {
            if (str != null && !string.IsNullOrEmpty(str.ToString()))
            {
                returnValue = str.ToString();
            }
            else
            {
                returnValue = "<span style=\"color:red;\">" + returnValue.ToString() + "</span>";
            }
            return returnValue;
        }

        public string timeSpan(object beginTime, object endTime)
        {
            string returnvValue = "";
            if (beginTime != null && endTime != null)
            {
                TimeSpan ts = new TimeSpan();
                ts = (DateTime)endTime - (DateTime)beginTime; //获取时间间隔 
                int tsSecnond = Convert.ToInt32(ts.TotalSeconds); //转换时间间隔为 秒
                int day = tsSecnond / (3600 * 24);
                int hour = tsSecnond % (3600 * 24) / 3600;
                int min = tsSecnond % 3600 / 60;
                int sec = tsSecnond % 60;
                if (day > 0)
                {
                    if (day > 1)
                    {
                        returnvValue += day + "Days";
                    }
                    else
                    {
                        returnvValue += day + "Day";
                    }
                }
                if (hour > 0)
                {
                    if (hour > 1)
                    {
                        returnvValue += day + "Hours";
                    }
                    else
                    {
                        returnvValue += hour + "Hour";
                    }
                }
                if (min > 0)
                {
                    if (day > 1)
                    {
                        returnvValue += min + "Minutes";
                    }
                    else
                    {
                        returnvValue += min + "Minute";
                    }
                }
                if (sec > 0)
                {
                    if (day > 1)
                    {
                        returnvValue += sec + "Seconds";
                    }
                    else
                    {
                        returnvValue += sec + "Second";
                    }
                }
            }
            else
            {
                returnvValue = "0";
            }
            return returnvValue;
        }

    }
}