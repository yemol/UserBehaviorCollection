DomReady.ready(function () {
    var cn = 'userIdentity';
    var userIdentity = cookie.getCookie(cn);
    if (!userIdentity) {
        userIdentity = guid();
        cookie.setCookie(cn, userIdentity);
        store.clear();
        store.set('uservisit', []);
    }

    var url = 'http://10.10.73.4:8066/Listener/ListenerHandler.ashx';
    var startAccessTime = new Date().format("yyyy-MM-dd h:mm:ss");
    var data = getUserVisitData();
    var flag = false;
    data.forEach(function (element, index, array) {
        var me = element;
        if (me.PagePath == window.location.href) {
            flag = true;
        }
    });
    if (!flag || data.length == 0) {
        data.push({
            PagePath: window.location.href,
            StartAccess: startAccessTime,
            Actions: []
        });
    }
    store.set('uservisit', data);
    BrowserDetect.init();
    var c = new mouseRecord(startAccessTime);
    c.init();
    window.setInterval(function () {
        var pagesVisitData = getUserVisitData();
        var record = {
            UserVisit: {
                UserIdentity: userIdentity,
                Browser: BrowserDetect.browser,
                OS: BrowserDetect.OS
            },
            PageVisit: pagesVisitData
        };
        if (pagesVisitData.length != 0)
            pagesVisitData.forEach(function (element, index, array) {
                var me = element;
                me.LastActiveTime = new Date().format("yyyy-MM-dd h:mm:ss");
            });
        //store.clear();
        //var clearData = getUserVisitData();
        //clearData.forEach(function (element, index, array) {
        //    var me = element;
        //    me.Actions.length = 0;
        //});
        //var i = 0
        //clearData.forEach(function (element, index, array) {
        //    if (element.PagePath != window.location.href)
        //        i++;
        //});
        //var saveData = {
        //    PagePath: clearData[i].PagePath,
        //    StartAccess: startAccessTime,
        //    Actions: []
        //};
        store.set('uservisit', [{
            PagePath: window.location.href,
            StartAccess: startAccessTime,
            Actions: []
        }]);
        ajax.get(url+'?jsonData=' + encodeURIComponent(JSON.stringify(record)), {
            success: function (status, response) {
                store.clear();
            }
        });
    }, 30000);
});
