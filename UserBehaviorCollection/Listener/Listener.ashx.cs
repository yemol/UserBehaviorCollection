using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UserBehaviorCollection.Listener
{
    /// <summary>
    /// Summary description for Listener
    /// </summary>
    public class Listener : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("Hello World");
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}