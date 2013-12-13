DomReady.ready(function () {
    var cn = 'userIdentity';
    var userIdentity = cookie.getCookie(cn);
    if (!userIdentity)
    {
        userIdentity = guid();
        cookie.setCookie(cn, userIdentity);
        store.clear();
        store.set('uservisit', []);
    }
    var url = '';
    var startAccessTime = new Date().format("yyyy-MM-dd h:mm:ss");
    BrowserDetect.init();
    var c = new mouseRecord(startAccessTime);
    c.init();
    window.setInterval(function () {
        var pagesVisitData = getUserVisitData();
        var record = {
            UserIdentity: userIdentity,
            Browser: BrowserDetect.browser,
            OS: BrowserDetect.OS,
            PagesVisit: pagesVisitData
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