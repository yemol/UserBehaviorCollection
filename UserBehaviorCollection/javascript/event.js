var mouseRecord = function (startAccess) {
    this.startAccess = startAccess;
    this.align = 'middle';
    this.clicks = 0;
    this.href = window.location.href;
    var that = this;

    var mouseRecord = {
        windowWidth: function () {
            var a = document.documentElement;
            return self.innerWidth || a && a.clientWidth || document.body.clientWidth
        },
        fixZero: function () {
            zero = that.align === 'middle' ? -mouseRecord.windowWidth() / 2 : 0;
            return zero
        },
        getMosPos: function (e) {
            var scrollx,
                scrolly;
            if (typeof (window.pageXOffset) == 'number') {
                scrollx = window.pageXOffset;
                scrolly = window.pageYOffset;
            } else {
                scrollx = document.documentElement.scrollLeft;
                scrolly = document.documentElement.scrollTop;
            }
            return {
                x: e.clientX + scrollx,
                y: e.clientY + scrolly
            }
        },
        getMouseEl: function (x, y) {
            return document.elementFromPoint(x, y);
        },
        makeFocusData: function (event)
        {
            var e = eop.getEvent(event);
            var mousePos = mouseRecord.getMosPos(e);
            var el = mouseRecord.getMouseEl(mousePos.x, mousePos.y);
            return {
                'html': el.outerHTML,
                'behavior':'focus'
            }
        },
        makeBlurData: function (event)
        {
            var e = eop.getEvent(event);
            var mousePos = mouseRecord.getMosPos(e);
            var el = mouseRecord.getMouseEl(mousePos.x, mousePos.y);
            return {
                'html': el.outerHTML,
                'behavior': 'blur'
            }
        },
        makeMouseData: function (event)
        {
            var e = eop.getEvent(event);
            var mousePos = mouseRecord.getMosPos(e);
            var el = mouseRecord.getMouseEl(mousePos.x, mousePos.y);
            return {
                'html': el.outerHTML,
                'behavior': 'mousedown'
            }
        }
    }
    function addPageVisitData(data)
    {
        var pagesVisitData = getUserVisitData();
        var href = that.href;
        var flag = false;
        if (pagesVisitData.length == 0) {
            pagesVisitData.push({
                PagePath: that.href,
                StartAccess: that.startAccess,
                Actions: [data]
            });
        }
        else {
            pagesVisitData.forEach(function (element, index, array) {
                var me = element;
                if (me.PagePath == href) {
                    me.Actions.push(data);
                    flag = true;
                }
                if (!flag) {
                    pagesVisitData.push({
                        PagePath: that.href,
                        StartAccess: that.startAccess,
                        Actions: [data]
                    });
                }
            });
        }
        store.set('uservisit', pagesVisitData);
    }
    var zero = mouseRecord.fixZero();
    return {
        init: function () {
            var inputEls =toArray(document.getElementsByTagName('input')),
                aEls = toArray(document.getElementsByTagName('a'));
            var totalEls = inputEls.concat(aEls);
            totalEls.forEach(function (element, index, array) {
                eop.on(element, 'mousedown', function (event) {
                    //that.clicks += 1;
                    var data = mouseRecord.makeMouseData(event);
                    addPageVisitData(data);
                })
                //eop.on(element, 'focus', function (event) {
                //    //that.clicks += 1;
                //    var data = mouseRecord.makeFocusData(event);
                //    addPageVisitData(data);
                //})
                //eop.on(element, 'blur', function (event) {
                //    //that.clicks += 1;
                //    var data = mouseRecord.makeBlurData(event);
                //    addPageVisitData(data);
                //})
            });
        },
        getClickCount: function () {
            return that.clicks
        }
    }
};