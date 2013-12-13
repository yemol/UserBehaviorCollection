using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json.Linq;
using UserBehaviorCollection.EntityModel;

namespace UserBehaviorCollection.Listener
{
    /// <summary>
    /// Summary description for ListenerHandler
    /// </summary>
    public class ListenerHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            bool isSaveSuccess = true;
            
            try
            {
                string json = context.Request["jsonData"].ToString();
                string s = "\\\"";
                string t = "#()#";
                json = json.Replace(s, t);
                
                UserBehaviorDataContext userBehaviorDataContext = new UserBehaviorDataContext();
                UserBehaviorEntity userBehavior = new UserBehaviorEntity();
                userBehavior = JsonConvert.DeserializeObject<UserBehaviorEntity>(json);
                UserVisit users = userBehaviorDataContext.UserVisits.SingleOrDefault(u => u.UserIdentity == userBehavior.UserVisit.UserIdentity);
                if (users == null)
                {
                    UserVisit userVisitTable = new UserVisit
                    {
                        UserIdentity = userBehavior.UserVisit.UserIdentity,
                        browser = userBehavior.UserVisit.Browser,
                        os = userBehavior.UserVisit.OS,
                        ip = context.Request.ServerVariables["REMOTE_ADDR"]
                    };
                    userBehaviorDataContext.UserVisits.InsertOnSubmit(userVisitTable);
                }
                foreach (PageVisitEntity pageVisitEntity in userBehavior.PageVisit)
                {                    
                    string actionArryStr = "[";
                    foreach (var actions in pageVisitEntity.Actions)
                    {
                        actionArryStr += "{\"HTML\":\"" + actions.HTML + "\",\"Behavior\":\"" + actions.Behavior + "\"},";
                    }
                    actionArryStr = actionArryStr.EndsWith(",") ? actionArryStr.Substring(0, actionArryStr.Length - 1) : actionArryStr;
                    actionArryStr += "]";

                    PageVisit page = userBehaviorDataContext.PageVisits.SingleOrDefault(p => (p.UserIdentity == userBehavior.UserVisit.UserIdentity && p.PagePath.ToLower() == pageVisitEntity.PagePath.ToLower()));
                    //insert when don't find the same page with the same user
                    //otherwise update page actions
                    if (page == null)
                    {                        
                        PageVisit pageVistTable = new PageVisit
                        {
                            PageIdentity = Guid.NewGuid(),
                            UserIdentity = userBehavior.UserVisit.UserIdentity,
                            PagePath = pageVisitEntity.PagePath,
                            StartAccess = pageVisitEntity.StartAccess,
                            LastActiveTime = pageVisitEntity.LastActiveTime,
                            Actions = actionArryStr
                        };
                        userBehaviorDataContext.PageVisits.InsertOnSubmit(pageVistTable);
                    }
                    else
                    {
                        JArray actionArray = null;
                        JArray actionOldArray = null;
                        //Deserialize Json
                        try
                        {
                            actionArray = (JArray)JsonConvert.DeserializeObject(actionArryStr);
                        }
                        catch
                        {
                            actionArray = (JArray)JsonConvert.DeserializeObject("[]");                        
                        }

                        try
                        {
                            actionOldArray = (!string.IsNullOrEmpty(page.Actions)) ? (JArray)JsonConvert.DeserializeObject(page.Actions) : (JArray)JsonConvert.DeserializeObject("[]");
                        }
                        catch
                        {
                            actionOldArray = (JArray)JsonConvert.DeserializeObject("[]");
                        }

                        foreach (var action in actionArray)
                        {
                            JObject addAction = new JObject{
                                new JProperty("HTML",action["HTML"]),
                                new JProperty("Behavior",action["Behavior"])
                            };
                            actionOldArray.Add(addAction);
                        }                     
                        //Update 
                        page.LastActiveTime = pageVisitEntity.LastActiveTime;
                        page.Actions = JsonConvert.SerializeObject(actionOldArray).ToString();                        
                    }
                    
                }

                userBehaviorDataContext.SubmitChanges();
            }
            catch
            {
                isSaveSuccess = false;
            }
            context.Response.Write(isSaveSuccess);
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