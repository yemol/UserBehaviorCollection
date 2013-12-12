var mouseRecord = function (startAccess) {
    this.startAccess = startAccess;
    this.align = align || 'left';
    this.clicks = 0;
    this.href = window.location.href;
    var that = this;

    var elementRel = {
        windowWidth: function () {
            var a = document.documentElement;
            return self.innerWidth || a && a.clientWidth || document.body.clientWidth
        },
        fixZero: function () {
            zero = that.align === 'middle' ? -mouseRel.windowWidth() / 2 : 0;
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
        makeMouseData: function (event) {
            var e = eop.getEvent(event);
            var mousePos = mouseRel.getMosPos(e);
            var el = mouseRel.getMouseEl(mousePos.x, mousePos.y);
            var message = 'You click at X:' + mousePos.x + ',Y:' + mousePos.y;
            return {
               // 'className': el.className,
               // 'nodeName': el.nodeName,
               // 'parentNode': el.parentNode,
               // 'nextSibling': el.nextSibling,
                'html': el.innerHTML,
                'positionX': mousePos.x + zero,
                'positionY': mousePos.y,
                'message': message,
                'percentageX': mousePos.x / mouseRel.windowWidth()
            }
        },
        makeFocusData: function (event)
        {
            var e = eop.getEvent(event);
            var el = mouseRel.getMouseEl(mousePos.x, mousePos.y);
            return {
                'html': el.innerHTML
            }
        }
    }
    function addPageVisitData(data)
    {
        var pagesVisitData = store.get('uservisit');
        var href = that.href;
        var flag = false;
        pagesVisitData.forEach(function (element, index, array) {
            var me = element;
            if (me.PagePath == href) {
                me.Actions.push(data);
                flag = true;
            }
            if (!flag)
                pagesVisitData.push({
                    PagePath: that.href,
                    StartAccess: that.startAccess,
                    Actions: [data]
                });
        });
    }
    var zero = mouseRel.fixZero();
    return {
        init: function () {
            eop.on(document, 'mousedown', function (event) {
                that.clicks += 1;
                var data = mouseRel.makeMouseData(event);
                addPageVisitData(data);
            })
        },
        getClickCount: function () {
            return that.clicks
        }
    }
};