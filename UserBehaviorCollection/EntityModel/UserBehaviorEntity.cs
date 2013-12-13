using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace UserBehaviorCollection.EntityModel
{
    public class UserBehaviorEntity
    {
        public UserVisitEntity UserVisit { get; set; }
        public List<PageVisitEntity> PageVisit { get; set; }    
    }

    public class UserVisitEntity
    {
        public Guid UserIdentity { get; set; }
        public string Browser { get; set; }
        public string OS { get; set; }
        public string IP { get; set; }
        public string OtherUserInfo { get; set; }
    }

    public class PageVisitEntity
    {
        public Guid? PageIdentity { get; set; }
        public Guid UserIdentity { get; set; }
        public string PagePath { get; set; }
        [JsonProperty(ItemConverterType = typeof(JavaScriptDateTimeConverter))]
        public DateTime? StartAccess { get; set; }
        [JsonProperty(ItemConverterType = typeof(JavaScriptDateTimeConverter))]
        public DateTime? LastActiveTime { get; set; }
        public List<ActionEntity> Actions { get; set; }

        public PageVisitEntity()
        {
            this.StartAccess = null;
            this.LastActiveTime = null;
        }
    }

    public class ActionEntity
    {
        public string HTML { get; set; }
        public string Behavior { get; set; }
    }
}