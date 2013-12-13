DomReady.ready(function () {
    var cn = 'userIdentity';
    var userIdentity = cookie.getCookie(cn);
    if (!userIdentity) {
        userIdentity = guid();
        cookie.setCookie(cn, userIdentity);
        store.clear();
        store.set('uservisit', []);
    }

    var url = '/Listener/ListenerHandler.ashx';
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
        ajax.post(url, {
            body: 'jsonData=' + JSON.stringify(record),
            success: function (status, response) {
                store.clear();
            }
        });
    }, 10000);
});