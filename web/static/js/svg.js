"use strict";
window.jscolor || (window.jscolor = function () {
    var n = {
        register: function () {
            n.attachDOMReadyEvent(n.init), n.attachEvent(document, "mousedown", n.onDocumentMouseDown), n.attachEvent(document, "touchstart", n.onDocumentTouchStart), n.attachEvent(window, "resize", n.onWindowResize)
        },
        init: function () {
            n.jscolor.lookupClass && n.jscolor.installByClassName(n.jscolor.lookupClass)
        },
        tryInstallOnElements: function (t, i) {
            for (var h = new RegExp("(^|\\s)(" + i + ")(\\s*(\\{[^}]*\\})|\\s|$)", "i"), f, o, r = 0; r < t.length; r += 1) if ((t[r].type === undefined || t[r].type.toLowerCase() != "color" || !n.isColorAttrSupported) && !t[r].jscolor && t[r].className && (f = t[r].className.match(h))) {
                var e = t[r], u = null, s = n.getDataAttr(e, "jscolor");
                if (s !== null ? u = s : f[4] && (u = f[4]), o = {}, u) try {
                    o = new Function("return (" + u + ")")()
                } catch (c) {
                    n.warn("Error parsing jscolor options: " + c + ":\n" + u)
                }
                e.jscolor = new n.jscolor(e, o)
            }
        },
        isColorAttrSupported: function () {
            var n = document.createElement("input");
            return n.setAttribute && (n.setAttribute("type", "color"), n.type.toLowerCase() == "color") ? !0 : !1
        }(),
        isCanvasSupported: function () {
            var n = document.createElement("canvas");
            return !!(n.getContext && n.getContext("2d"))
        }(),
        fetchElement: function (n) {
            return typeof n == "string" ? document.getElementById(n) : n
        },
        isElementType: function (n, t) {
            return n.nodeName.toLowerCase() === t.toLowerCase()
        },
        getDataAttr: function (n, t) {
            var r = "data-" + t, i = n.getAttribute(r);
            return i !== null ? i : null
        },
        attachEvent: function (n, t, i) {
            n.addEventListener ? n.addEventListener(t, i, !1) : n.attachEvent && n.attachEvent("on" + t, i)
        },
        detachEvent: function (n, t, i) {
            n.removeEventListener ? n.removeEventListener(t, i, !1) : n.detachEvent && n.detachEvent("on" + t, i)
        },
        _attachedGroupEvents: {},
        attachGroupEvent: function (t, i, r, u) {
            n._attachedGroupEvents.hasOwnProperty(t) || (n._attachedGroupEvents[t] = []), n._attachedGroupEvents[t].push([i, r, u]), n.attachEvent(i, r, u)
        },
        detachGroupEvents: function (t) {
            var i, r;
            if (n._attachedGroupEvents.hasOwnProperty(t)) {
                for (i = 0; i < n._attachedGroupEvents[t].length; i += 1) r = n._attachedGroupEvents[t][i], n.detachEvent(r[0], r[1], r[2]);
                delete n._attachedGroupEvents[t]
            }
        },
        attachDOMReadyEvent: function (n) {
            var r = !1, t = function () {
                r || (r = !0, n())
            }, i;
            if (document.readyState === "complete") {
                setTimeout(t, 1);
                return
            }
            document.addEventListener ? (document.addEventListener("DOMContentLoaded", t, !1), window.addEventListener("load", t, !1)) : document.attachEvent && (document.attachEvent("onreadystatechange", function () {
                document.readyState === "complete" && (document.detachEvent("onreadystatechange", arguments.callee), t())
            }), window.attachEvent("onload", t), document.documentElement.doScroll && window == window.top && (i = function () {
                if (document.body) try {
                    document.documentElement.doScroll("left"), t()
                } catch (n) {
                    setTimeout(i, 1)
                }
            }, i()))
        },
        warn: function (n) {
            window.console && window.console.warn && window.console.warn(n)
        },
        preventDefault: function (n) {
            n.preventDefault && n.preventDefault(), n.returnValue = !1
        },
        captureTarget: function (t) {
            t.setCapture && (n._capturedTarget = t, n._capturedTarget.setCapture())
        },
        releaseTarget: function () {
            n._capturedTarget && (n._capturedTarget.releaseCapture(), n._capturedTarget = null)
        },
        fireEvent: function (n, t) {
            var i;
            n && (document.createEvent ? (i = document.createEvent("HTMLEvents"), i.initEvent(t, !0, !0), n.dispatchEvent(i)) : document.createEventObject ? (i = document.createEventObject(), n.fireEvent("on" + t, i)) : n["on" + t] && n["on" + t]())
        },
        classNameToList: function (n) {
            return n.replace(/^\s+|\s+$/g, "").split(/\s+/)
        },
        hasClass: function (n, t) {
            return t ? -1 != (" " + n.className.replace(/\s+/g, " ") + " ").indexOf(" " + t + " ") : !1
        },
        setClass: function (t, i) {
            for (var u = n.classNameToList(i), r = 0; r < u.length; r += 1) n.hasClass(t, u[r]) || (t.className += (t.className ? " " : "") + u[r])
        },
        unsetClass: function (t, i) {
            for (var u = n.classNameToList(i), f, r = 0; r < u.length; r += 1) f = new RegExp("^\\s*" + u[r] + "\\s*|\\s*" + u[r] + "\\s*$|\\s+" + u[r] + "(\\s+)", "g"), t.className = t.className.replace(f, "$1")
        },
        getStyle: function (n) {
            return window.getComputedStyle ? window.getComputedStyle(n) : n.currentStyle
        },
        setStyle: function () {
            var t = document.createElement("div"), n = function (n) {
                for (var i = 0; i < n.length; i += 1) if (n[i] in t.style) return n[i]
            }, i = {
                borderRadius: n(["borderRadius", "MozBorderRadius", "webkitBorderRadius"]),
                boxShadow: n(["boxShadow", "MozBoxShadow", "webkitBoxShadow"])
            };
            return function (n, t, r) {
                switch (t.toLowerCase()) {
                    case"opacity":
                        var u = Math.round(parseFloat(r) * 100);
                        n.style.opacity = r, n.style.filter = "alpha(opacity=" + u + ")";
                        break;
                    default:
                        n.style[i[t]] = r
                }
            }
        }(),
        setBorderRadius: function (t, i) {
            n.setStyle(t, "borderRadius", i || "0")
        },
        setBoxShadow: function (t, i) {
            n.setStyle(t, "boxShadow", i || "none")
        },
        getElementPos: function (t, i) {
            var r = 0, u = 0, e = t.getBoundingClientRect(), f;
            return r = e.left, u = e.top, i || (f = n.getViewPos(), r += f[0], u += f[1]), [r, u]
        },
        getElementSize: function (n) {
            return [n.offsetWidth, n.offsetHeight]
        },
        getAbsPointerPos: function (n) {
            n || (n = window.event);
            var t = 0, i = 0;
            return typeof n.changedTouches != "undefined" && n.changedTouches.length ? (t = n.changedTouches[0].clientX, i = n.changedTouches[0].clientY) : typeof n.clientX == "number" && (t = n.clientX, i = n.clientY), {
                x: t,
                y: i
            }
        },
        getRelPointerPos: function (n) {
            n || (n = window.event);
            var e = n.target || n.srcElement, r = e.getBoundingClientRect(), u = 0, f = 0, t = 0, i = 0;
            return typeof n.changedTouches != "undefined" && n.changedTouches.length ? (t = n.changedTouches[0].clientX, i = n.changedTouches[0].clientY) : typeof n.clientX == "number" && (t = n.clientX, i = n.clientY), u = t - r.left, f = i - r.top, {
                x: u,
                y: f
            }
        },
        getViewPos: function () {
            var n = document.documentElement;
            return [(window.pageXOffset || n.scrollLeft) - (n.clientLeft || 0), (window.pageYOffset || n.scrollTop) - (n.clientTop || 0)]
        },
        getViewSize: function () {
            var n = document.documentElement;
            return [window.innerWidth || n.clientWidth, window.innerHeight || n.clientHeight,]
        },
        redrawPosition: function () {
            var o, r, c, u, h;
            if (n.picker && n.picker.owner) {
                o = n.picker.owner, o.fixed ? (r = n.getElementPos(o.targetElement, !0), c = [0, 0]) : (r = n.getElementPos(o.targetElement), c = n.getViewPos());
                var f = n.getElementSize(o.targetElement), l = n.getViewSize(), s = n.getPickerOuterDims(o), i, t, e;
                switch (o.position.toLowerCase()) {
                    case"left":
                        i = 1, t = 0, e = -1;
                        break;
                    case"right":
                        i = 1, t = 0, e = 1;
                        break;
                    case"top":
                        i = 0, t = 1, e = -1;
                        break;
                    default:
                        i = 0, t = 1, e = 1
                }
                u = (f[t] + s[t]) / 2, h = o.smartPosition ? [-c[i] + r[i] + s[i] > l[i] ? -c[i] + r[i] + f[i] / 2 > l[i] / 2 && r[i] + f[i] - s[i] >= 0 ? r[i] + f[i] - s[i] : r[i] : r[i], -c[t] + r[t] + f[t] + s[t] - u + u * e > l[t] ? -c[t] + r[t] + f[t] / 2 > l[t] / 2 && r[t] + f[t] - u - u * e >= 0 ? r[t] + f[t] - u - u * e : r[t] + f[t] - u + u * e : r[t] + f[t] - u + u * e >= 0 ? r[t] + f[t] - u + u * e : r[t] + f[t] - u - u * e] : [r[i], r[t] + f[t] - u + u * e];
                var a = h[i], v = h[t], y = o.fixed ? "fixed" : "absolute",
                    p = (h[0] + s[0] > r[0] || h[0] < r[0] + f[0]) && h[1] + s[1] < r[1] + f[1];
                n._drawPosition(o, a, v, y, p)
            }
        },
        _drawPosition: function (t, i, r, u, f) {
            var e = f ? 0 : t.shadowBlur;
            n.picker.wrap.style.position = u, n.picker.wrap.style.left = i + "px", n.picker.wrap.style.top = r + "px", n.setBoxShadow(n.picker.boxS, t.shadow ? new n.BoxShadow(0, e, t.shadowBlur, 0, t.shadowColor) : null)
        },
        getPickerDims: function (t) {
            var i = !!n.getSliderComponent(t);
            return [2 * t.insetWidth + 2 * t.padding + t.width + (i ? 2 * t.insetWidth + n.getPadToSliderPadding(t) + t.sliderSize : 0), 2 * t.insetWidth + 2 * t.padding + t.height + (t.closable ? 2 * t.insetWidth + t.padding + t.buttonHeight : 0)]
        },
        getPickerOuterDims: function (t) {
            var i = n.getPickerDims(t);
            return [i[0] + 2 * t.borderWidth, i[1] + 2 * t.borderWidth]
        },
        getPadToSliderPadding: function (n) {
            return Math.max(n.padding, 1.5 * (2 * n.pointerBorderWidth + n.pointerThickness))
        },
        getPadYComponent: function (n) {
            switch (n.mode.charAt(1).toLowerCase()) {
                case"v":
                    return "v"
            }
            return "s"
        },
        getSliderComponent: function (n) {
            if (n.mode.length > 2) switch (n.mode.charAt(2).toLowerCase()) {
                case"s":
                    return "s";
                case"v":
                    return "v"
            }
            return null
        },
        onDocumentMouseDown: function (t) {
            t || (t = window.event);
            var i = t.target || t.srcElement;
            if (i._jscLinkedInstance) i._jscLinkedInstance.showOnClick && i._jscLinkedInstance.show(); else if (i._jscControlName) n.onControlPointerStart(t, i, i._jscControlName, "mouse"); else n.picker && n.picker.owner && n.picker.owner.hide()
        },
        onDocumentTouchStart: function (t) {
            t || (t = window.event);
            var i = t.target || t.srcElement;
            if (i._jscLinkedInstance) i._jscLinkedInstance.showOnClick && i._jscLinkedInstance.show(); else if (i._jscControlName) n.onControlPointerStart(t, i, i._jscControlName, "touch"); else n.picker && n.picker.owner && n.picker.owner.hide()
        },
        onWindowResize: function () {
            n.redrawPosition()
        },
        onParentScroll: function () {
            n.picker && n.picker.owner && n.picker.owner.hide()
        },
        _pointerMoveEvent: {mouse: "mousemove", touch: "touchmove"},
        _pointerEndEvent: {mouse: "mouseup", touch: "touchend"},
        _pointerOrigin: null,
        _capturedTarget: null,
        onControlPointerStart: function (t, i, r, u) {
            var f = i._jscInstance, e, o, c, s, h;
            n.preventDefault(t), n.captureTarget(i), e = function (f, e) {
                n.attachGroupEvent("drag", f, n._pointerMoveEvent[u], n.onDocumentPointerMove(t, i, r, u, e)), n.attachGroupEvent("drag", f, n._pointerEndEvent[u], n.onDocumentPointerEnd(t, i, r, u))
            }, e(document, [0, 0]), window.parent && window.frameElement && (o = window.frameElement.getBoundingClientRect(), c = [-o.left, -o.top], e(window.parent.window.document, c)), s = n.getAbsPointerPos(t), h = n.getRelPointerPos(t), n._pointerOrigin = {
                x: s.x - h.x,
                y: s.y - h.y
            };
            switch (r) {
                case"pad":
                    switch (n.getSliderComponent(f)) {
                        case"s":
                            f.hsv[1] === 0 && f.fromHSV(null, 100, null);
                            break;
                        case"v":
                            f.hsv[2] === 0 && f.fromHSV(null, null, 100)
                    }
                    n.setPad(f, t, 0, 0);
                    break;
                case"sld":
                    n.setSld(f, t, 0)
            }
            n.dispatchFineChange(f)
        },
        onDocumentPointerMove: function (t, i, r, u, f) {
            return function (t) {
                var u = i._jscInstance;
                switch (r) {
                    case"pad":
                        t || (t = window.event), n.setPad(u, t, f[0], f[1]), n.dispatchFineChange(u);
                        break;
                    case"sld":
                        t || (t = window.event), n.setSld(u, t, f[1]), n.dispatchFineChange(u)
                }
            }
        },
        onDocumentPointerEnd: function (t, i) {
            return function () {
                var r = i._jscInstance;
                n.detachGroupEvents("drag"), n.releaseTarget(), n.dispatchChange(r)
            }
        },
        dispatchChange: function (t) {
            t.valueElement && n.isElementType(t.valueElement, "input") && n.fireEvent(t.valueElement, "change")
        },
        dispatchFineChange: function (n) {
            if (n.onFineChange) {
                var t;
                t = typeof n.onFineChange == "string" ? new Function(n.onFineChange) : n.onFineChange, t.call(n)
            }
        },
        setPad: function (t, i, r, u) {
            var f = n.getAbsPointerPos(i), s = r + f.x - n._pointerOrigin.x - t.padding - t.insetWidth,
                h = u + f.y - n._pointerOrigin.y - t.padding - t.insetWidth, e = s * (360 / (t.width - 1)),
                o = 100 - h * (100 / (t.height - 1));
            switch (n.getPadYComponent(t)) {
                case"s":
                    t.fromHSV(e, o, null, n.leaveSld);
                    break;
                case"v":
                    t.fromHSV(e, null, o, n.leaveSld)
            }
        },
        setSld: function (t, i, r) {
            var f = n.getAbsPointerPos(i), e = r + f.y - n._pointerOrigin.y - t.padding - t.insetWidth,
                u = 100 - e * (100 / (t.height - 1));
            switch (n.getSliderComponent(t)) {
                case"s":
                    t.fromHSV(null, u, null, n.leavePad);
                    break;
                case"v":
                    t.fromHSV(null, null, u, n.leavePad)
            }
        },
        _vmlNS: "jsc_vml_",
        _vmlCSS: "jsc_vml_css_",
        _vmlReady: !1,
        initVML: function () {
            var t, r, u, i;
            if (!n._vmlReady) {
                if (t = document, t.namespaces[n._vmlNS] || t.namespaces.add(n._vmlNS, "urn:schemas-microsoft-com:vml"), !t.styleSheets[n._vmlCSS]) for (r = ["shape", "shapetype", "group", "background", "path", "formulas", "handles", "fill", "stroke", "shadow", "textbox", "textpath", "imagedata", "line", "polyline", "curve", "rect", "roundrect", "oval", "arc", "image"], u = t.createStyleSheet(), u.owningElement.id = n._vmlCSS, i = 0; i < r.length; i += 1) u.addRule(n._vmlNS + "\\:" + r[i], "behavior:url(#default#VML);");
                n._vmlReady = !0
            }
        },
        createPalette: function () {
            var s = {elm: null, draw: null}, f, e, r, i, u, h;
            if (n.isCanvasSupported) {
                var t = document.createElement("canvas"), o = t.getContext("2d"), h = function (n, i, r) {
                    var u, f;
                    t.width = n, t.height = i, o.clearRect(0, 0, t.width, t.height), u = o.createLinearGradient(0, 0, t.width, 0), u.addColorStop(0, "#F00"), u.addColorStop(1 / 6, "#FF0"), u.addColorStop(2 / 6, "#0F0"), u.addColorStop(3 / 6, "#0FF"), u.addColorStop(4 / 6, "#00F"), u.addColorStop(5 / 6, "#F0F"), u.addColorStop(1, "#F00"), o.fillStyle = u, o.fillRect(0, 0, t.width, t.height), f = o.createLinearGradient(0, 0, 0, t.height);
                    switch (r.toLowerCase()) {
                        case"s":
                            f.addColorStop(0, "rgba(255,255,255,0)"), f.addColorStop(1, "rgba(255,255,255,1)");
                            break;
                        case"v":
                            f.addColorStop(0, "rgba(0,0,0,0)"), f.addColorStop(1, "rgba(0,0,0,1)")
                    }
                    o.fillStyle = f, o.fillRect(0, 0, t.width, t.height)
                };
                s.elm = t, s.draw = h
            } else n.initVML(), f = document.createElement("div"), f.style.position = "relative", f.style.overflow = "hidden", e = document.createElement(n._vmlNS + ":fill"), e.type = "gradient", e.method = "linear", e.angle = "90", e.colors = "16.67% #F0F, 33.33% #00F, 50% #0FF, 66.67% #0F0, 83.33% #FF0", r = document.createElement(n._vmlNS + ":rect"), r.style.position = "absolute", r.style.left = "-1px", r.style.top = "-1px", r.stroked = !1, r.appendChild(e), f.appendChild(r), i = document.createElement(n._vmlNS + ":fill"), i.type = "gradient", i.method = "linear", i.angle = "180", i.opacity = "0", u = document.createElement(n._vmlNS + ":rect"), u.style.position = "absolute", u.style.left = "-1px", u.style.top = "-1px", u.stroked = !1, u.appendChild(i), f.appendChild(u), h = function (n, t, o) {
                f.style.width = n + "px", f.style.height = t + "px", r.style.width = u.style.width = n + 1 + "px", r.style.height = u.style.height = t + 1 + "px", e.color = "#F00", e.color2 = "#F00";
                switch (o.toLowerCase()) {
                    case"s":
                        i.color = i.color2 = "#FFF";
                        break;
                    case"v":
                        i.color = i.color2 = "#000"
                }
            }, s.elm = f, s.draw = h;
            return s
        },
        createSliderGradient: function () {
            var f = {elm: null, draw: null}, r, u, i, o;
            if (n.isCanvasSupported) {
                var t = document.createElement("canvas"), e = t.getContext("2d"), o = function (n, i, r, u) {
                    t.width = n, t.height = i, e.clearRect(0, 0, t.width, t.height);
                    var f = e.createLinearGradient(0, 0, 0, t.height);
                    f.addColorStop(0, r), f.addColorStop(1, u), e.fillStyle = f, e.fillRect(0, 0, t.width, t.height)
                };
                f.elm = t, f.draw = o
            } else n.initVML(), r = document.createElement("div"), r.style.position = "relative", r.style.overflow = "hidden", u = document.createElement(n._vmlNS + ":fill"), u.type = "gradient", u.method = "linear", u.angle = "180", i = document.createElement(n._vmlNS + ":rect"), i.style.position = "absolute", i.style.left = "-1px", i.style.top = "-1px", i.stroked = !1, i.appendChild(u), r.appendChild(i), o = function (n, t, f, e) {
                r.style.width = n + "px", r.style.height = t + "px", i.style.width = n + 1 + "px", i.style.height = t + 1 + "px", u.color = f, u.color2 = e
            }, f.elm = r, f.draw = o;
            return f
        },
        leaveValue: 1,
        leaveStyle: 2,
        leavePad: 4,
        leaveSld: 8,
        BoxShadow: function () {
            var n = function (n, t, i, r, u, f) {
                this.hShadow = n, this.vShadow = t, this.blur = i, this.spread = r, this.color = u, this.inset = !!f
            };
            return n.prototype.toString = function () {
                var n = [Math.round(this.hShadow) + "px", Math.round(this.vShadow) + "px", Math.round(this.blur) + "px", Math.round(this.spread) + "px", this.color];
                return this.inset && n.push("inset"), n.join(" ")
            }, n
        }(),
        jscolor: function (t, i) {
            function w(n, t, i) {
                var e;
                n /= 255, t /= 255, i /= 255;
                var f = Math.min(Math.min(n, t), i), u = Math.max(Math.max(n, t), i), r = u - f;
                return r === 0 ? [null, 0, 100 * u] : (e = n === f ? 3 + (i - t) / r : t === f ? 5 + (n - i) / r : 1 + (t - n) / r, [60 * (e === 6 ? 0 : e), 100 * (r / u), 100 * u])
            }

            function u(n, t, i) {
                var r = 255 * (i / 100);
                if (n === null) return [r, r, r];
                n /= 60, t /= 100;
                var e = Math.floor(n), o = e % 2 ? n - e : 1 - (n - e), u = r * (1 - t), f = r * (1 - t * o);
                switch (e) {
                    case 6:
                    case 0:
                        return [r, f, u];
                    case 1:
                        return [f, r, u];
                    case 2:
                        return [u, r, f];
                    case 3:
                        return [u, f, r];
                    case 4:
                        return [f, u, r];
                    case 5:
                        return [r, u, f]
                }
            }

            function b() {
                n.unsetClass(r.targetElement, r.activeClass), n.picker.wrap.parentNode.removeChild(n.picker.wrap), delete n.picker.owner
            }

            function l() {
                function c() {
                    var n = r.insetColor.split(/\s+/),
                        i = n.length < 2 ? n[0] : n[1] + " " + n[0] + " " + n[0] + " " + n[1];
                    t.btn.style.borderColor = i
                }

                r._processParentElementsInDOM(), n.picker || (n.picker = {
                    owner: null,
                    wrap: document.createElement("div"),
                    box: document.createElement("div"),
                    boxS: document.createElement("div"),
                    boxB: document.createElement("div"),
                    pad: document.createElement("div"),
                    padB: document.createElement("div"),
                    padM: document.createElement("div"),
                    padPal: n.createPalette(),
                    cross: document.createElement("div"),
                    crossBY: document.createElement("div"),
                    crossBX: document.createElement("div"),
                    crossLY: document.createElement("div"),
                    crossLX: document.createElement("div"),
                    sld: document.createElement("div"),
                    sldB: document.createElement("div"),
                    sldM: document.createElement("div"),
                    sldGrad: n.createSliderGradient(),
                    sldPtrS: document.createElement("div"),
                    sldPtrIB: document.createElement("div"),
                    sldPtrMB: document.createElement("div"),
                    sldPtrOB: document.createElement("div"),
                    btn: document.createElement("div"),
                    btnT: document.createElement("span")
                }, n.picker.pad.appendChild(n.picker.padPal.elm), n.picker.padB.appendChild(n.picker.pad), n.picker.cross.appendChild(n.picker.crossBY), n.picker.cross.appendChild(n.picker.crossBX), n.picker.cross.appendChild(n.picker.crossLY), n.picker.cross.appendChild(n.picker.crossLX), n.picker.padB.appendChild(n.picker.cross), n.picker.box.appendChild(n.picker.padB), n.picker.box.appendChild(n.picker.padM), n.picker.sld.appendChild(n.picker.sldGrad.elm), n.picker.sldB.appendChild(n.picker.sld), n.picker.sldB.appendChild(n.picker.sldPtrOB), n.picker.sldPtrOB.appendChild(n.picker.sldPtrMB), n.picker.sldPtrMB.appendChild(n.picker.sldPtrIB), n.picker.sldPtrIB.appendChild(n.picker.sldPtrS), n.picker.box.appendChild(n.picker.sldB), n.picker.box.appendChild(n.picker.sldM), n.picker.btn.appendChild(n.picker.btnT), n.picker.box.appendChild(n.picker.btn), n.picker.boxB.appendChild(n.picker.box), n.picker.wrap.appendChild(n.picker.boxS), n.picker.wrap.appendChild(n.picker.boxB));
                var t = n.picker, f = !!n.getSliderComponent(r), i = n.getPickerDims(r),
                    u = 2 * r.pointerBorderWidth + r.pointerThickness + 2 * r.crossSize, e = n.getPadToSliderPadding(r),
                    o = Math.min(r.borderRadius, Math.round(r.padding * Math.PI)), s = "crosshair";
                t.wrap.style.clear = "both", t.wrap.style.width = i[0] + 2 * r.borderWidth + "px", t.wrap.style.height = i[1] + 2 * r.borderWidth + "px", t.wrap.style.zIndex = r.zIndex, t.box.style.width = i[0] + "px", t.box.style.height = i[1] + "px", t.boxS.style.position = "absolute", t.boxS.style.left = "0", t.boxS.style.top = "0", t.boxS.style.width = "100%", t.boxS.style.height = "100%", n.setBorderRadius(t.boxS, o + "px"), t.boxB.style.position = "relative", t.boxB.style.border = r.borderWidth + "px solid", t.boxB.style.borderColor = r.borderColor, t.boxB.style.background = r.backgroundColor, n.setBorderRadius(t.boxB, o + "px"), t.padM.style.background = t.sldM.style.background = "#FFF", n.setStyle(t.padM, "opacity", "0"), n.setStyle(t.sldM, "opacity", "0"), t.pad.style.position = "relative", t.pad.style.width = r.width + "px", t.pad.style.height = r.height + "px", t.padPal.draw(r.width, r.height, n.getPadYComponent(r)), t.padB.style.position = "absolute", t.padB.style.left = r.padding + "px", t.padB.style.top = r.padding + "px", t.padB.style.border = r.insetWidth + "px solid", t.padB.style.borderColor = r.insetColor, t.padM._jscInstance = r, t.padM._jscControlName = "pad", t.padM.style.position = "absolute", t.padM.style.left = "0", t.padM.style.top = "0", t.padM.style.width = r.padding + 2 * r.insetWidth + r.width + e / 2 + "px", t.padM.style.height = i[1] + "px", t.padM.style.cursor = s, t.cross.style.position = "absolute", t.cross.style.left = t.cross.style.top = "0", t.cross.style.width = t.cross.style.height = u + "px", t.crossBY.style.position = t.crossBX.style.position = "absolute", t.crossBY.style.background = t.crossBX.style.background = r.pointerBorderColor, t.crossBY.style.width = t.crossBX.style.height = 2 * r.pointerBorderWidth + r.pointerThickness + "px", t.crossBY.style.height = t.crossBX.style.width = u + "px", t.crossBY.style.left = t.crossBX.style.top = Math.floor(u / 2) - Math.floor(r.pointerThickness / 2) - r.pointerBorderWidth + "px", t.crossBY.style.top = t.crossBX.style.left = "0", t.crossLY.style.position = t.crossLX.style.position = "absolute", t.crossLY.style.background = t.crossLX.style.background = r.pointerColor, t.crossLY.style.height = t.crossLX.style.width = u - 2 * r.pointerBorderWidth + "px", t.crossLY.style.width = t.crossLX.style.height = r.pointerThickness + "px", t.crossLY.style.left = t.crossLX.style.top = Math.floor(u / 2) - Math.floor(r.pointerThickness / 2) + "px", t.crossLY.style.top = t.crossLX.style.left = r.pointerBorderWidth + "px", t.sld.style.overflow = "hidden", t.sld.style.width = r.sliderSize + "px", t.sld.style.height = r.height + "px", t.sldGrad.draw(r.sliderSize, r.height, "#000", "#000"), t.sldB.style.display = f ? "block" : "none", t.sldB.style.position = "absolute", t.sldB.style.right = r.padding + "px", t.sldB.style.top = r.padding + "px", t.sldB.style.border = r.insetWidth + "px solid", t.sldB.style.borderColor = r.insetColor, t.sldM._jscInstance = r, t.sldM._jscControlName = "sld", t.sldM.style.display = f ? "block" : "none", t.sldM.style.position = "absolute", t.sldM.style.right = "0", t.sldM.style.top = "0", t.sldM.style.width = r.sliderSize + e / 2 + r.padding + 2 * r.insetWidth + "px", t.sldM.style.height = i[1] + "px", t.sldM.style.cursor = "default", t.sldPtrIB.style.border = t.sldPtrOB.style.border = r.pointerBorderWidth + "px solid " + r.pointerBorderColor, t.sldPtrOB.style.position = "absolute", t.sldPtrOB.style.left = -(2 * r.pointerBorderWidth + r.pointerThickness) + "px", t.sldPtrOB.style.top = "0", t.sldPtrMB.style.border = r.pointerThickness + "px solid " + r.pointerColor, t.sldPtrS.style.width = r.sliderSize + "px", t.sldPtrS.style.height = y + "px", t.btn.style.display = r.closable ? "block" : "none", t.btn.style.position = "absolute", t.btn.style.left = r.padding + "px", t.btn.style.bottom = r.padding + "px", t.btn.style.padding = "0 15px", t.btn.style.height = r.buttonHeight + "px", t.btn.style.border = r.insetWidth + "px solid", c(), t.btn.style.color = r.buttonColor, t.btn.style.font = "12px sans-serif", t.btn.style.textAlign = "center";
                try {
                    t.btn.style.cursor = "pointer"
                } catch (l) {
                    t.btn.style.cursor = "hand"
                }
                t.btn.onmousedown = function () {
                    r.hide()
                }, t.btnT.style.lineHeight = r.buttonHeight + "px", t.btnT.innerHTML = "", t.btnT.appendChild(document.createTextNode(r.closeText)), a(), v(), n.picker.owner && n.picker.owner !== r && n.unsetClass(n.picker.owner.targetElement, r.activeClass), n.picker.owner = r, n.isElementType(h, "body") ? n.redrawPosition() : n._drawPosition(r, 0, 0, "relative", !1), t.wrap.parentNode != h && h.appendChild(t.wrap), n.setClass(r.targetElement, r.activeClass)
            }

            function a() {
                var t;
                switch (n.getPadYComponent(r)) {
                    case"s":
                        t = 1;
                        break;
                    case"v":
                        t = 2
                }
                var c = Math.round(r.hsv[0] / 360 * (r.width - 1)),
                    l = Math.round((1 - r.hsv[t] / 100) * (r.height - 1)),
                    a = 2 * r.pointerBorderWidth + r.pointerThickness + 2 * r.crossSize, o = -Math.floor(a / 2);
                n.picker.cross.style.left = c + o + "px", n.picker.cross.style.top = l + o + "px";
                switch (n.getSliderComponent(r)) {
                    case"s":
                        var i = u(r.hsv[0], 100, r.hsv[2]), f = u(r.hsv[0], 0, r.hsv[2]),
                            s = "rgb(" + Math.round(i[0]) + "," + Math.round(i[1]) + "," + Math.round(i[2]) + ")",
                            h = "rgb(" + Math.round(f[0]) + "," + Math.round(f[1]) + "," + Math.round(f[2]) + ")";
                        n.picker.sldGrad.draw(r.sliderSize, r.height, s, h);
                        break;
                    case"v":
                        var e = u(r.hsv[0], r.hsv[1], 100),
                            s = "rgb(" + Math.round(e[0]) + "," + Math.round(e[1]) + "," + Math.round(e[2]) + ")",
                            h = "#000";
                        n.picker.sldGrad.draw(r.sliderSize, r.height, s, h)
                }
            }

            function v() {
                var i = n.getSliderComponent(r), t, u;
                if (i) {
                    switch (i) {
                        case"s":
                            t = 1;
                            break;
                        case"v":
                            t = 2
                    }
                    u = Math.round((1 - r.hsv[t] / 100) * (r.height - 1)), n.picker.sldPtrOB.style.top = u - (2 * r.pointerBorderWidth + r.pointerThickness) - Math.floor(y / 2) + "px"
                }
            }

            function e() {
                return n.picker && n.picker.owner === r
            }

            function k() {
                r.importColor()
            }

            var f, o, s, p, c;
            this.value = null, this.valueElement = t, this.styleElement = t, this.required = !0, this.refine = !0, this.hash = !0, this.uppercase = !0, this.onFineChange = null, this.activeClass = "jscolor-active", this.minS = 0, this.maxS = 100, this.minV = 0, this.maxV = 100, this.hsv = [0, 0, 100], this.rgb = [255, 255, 255], this.width = 181, this.height = 101, this.showOnClick = !0, this.mode = "HSV", this.position = "bottom", this.smartPosition = !0, this.sliderSize = 16, this.crossSize = 8, this.closable = !1, this.closeText = "Close", this.buttonColor = "#000000", this.buttonHeight = 18, this.padding = 12, this.backgroundColor = "#333", this.borderWidth = 0, this.borderColor = "#FFF", this.borderRadius = 3, this.insetWidth = 0, this.insetColor = "#FFF", this.shadow = !0, this.shadowBlur = 15, this.shadowColor = "rgba(0,0,0,0.2)", this.pointerColor = "#4C4C4C", this.pointerBorderColor = "#FFFFFF", this.pointerBorderWidth = 1, this.pointerThickness = 2, this.zIndex = 1e3, this.container = null;
            for (f in i) i.hasOwnProperty(f) && (this[f] = i[f]);
            if (this.hide = function () {
                e() && b()
            }, this.show = function () {
                l()
            }, this.redraw = function () {
                e() && l()
            }, this.importColor = function () {
                this.valueElement ? n.isElementType(this.valueElement, "input") ? this.refine ? !this.required && /^\s*$/.test(this.valueElement.value) ? (this.valueElement.value = "", this.styleElement && (this.styleElement.style.backgroundImage = this.styleElement._jscOrigStyle.backgroundImage, this.styleElement.style.backgroundColor = this.styleElement._jscOrigStyle.backgroundColor, this.styleElement.style.color = this.styleElement._jscOrigStyle.color), this.exportColor(n.leaveValue | n.leaveStyle)) : this.fromString(this.valueElement.value) || this.exportColor() : this.fromString(this.valueElement.value, n.leaveValue) || (this.styleElement && (this.styleElement.style.backgroundImage = this.styleElement._jscOrigStyle.backgroundImage, this.styleElement.style.backgroundColor = this.styleElement._jscOrigStyle.backgroundColor, this.styleElement.style.color = this.styleElement._jscOrigStyle.color), this.exportColor(n.leaveValue | n.leaveStyle)) : this.exportColor() : this.exportColor()
            }, this.exportColor = function (t) {
                if (!(t & n.leaveValue) && this.valueElement) {
                    var i = this.toString();
                    this.uppercase && (i = i.toUpperCase()), this.hash && (i = "#" + i), n.isElementType(this.valueElement, "input") ? this.valueElement.value = i : this.valueElement.innerHTML = i
                }
                t & n.leaveStyle || this.styleElement && (this.styleElement.style.backgroundImage = "none", this.styleElement.style.backgroundColor = "#" + this.toString(), this.styleElement.style.color = this.isLight() ? "rgba(0,0,0,0.4)" : "rgba(255,255,255,0.4)"), t & n.leavePad || !e() || a(), t & n.leaveSld || !e() || v()
            }, this.fromHSV = function (n, t, i, r) {
                if (n !== null) {
                    if (isNaN(n)) return !1;
                    n = Math.max(0, Math.min(360, n))
                }
                if (t !== null) {
                    if (isNaN(t)) return !1;
                    t = Math.max(0, Math.min(100, this.maxS, t), this.minS)
                }
                if (i !== null) {
                    if (isNaN(i)) return !1;
                    i = Math.max(0, Math.min(100, this.maxV, i), this.minV)
                }
                this.rgb = u(n === null ? this.hsv[0] : this.hsv[0] = n, t === null ? this.hsv[1] : this.hsv[1] = t, i === null ? this.hsv[2] : this.hsv[2] = i), this.exportColor(r)
            }, this.fromRGB = function (n, t, i, r) {
                var f, e;
                if (n !== null) {
                    if (isNaN(n)) return !1;
                    n = Math.max(0, Math.min(255, n))
                }
                if (t !== null) {
                    if (isNaN(t)) return !1;
                    t = Math.max(0, Math.min(255, t))
                }
                if (i !== null) {
                    if (isNaN(i)) return !1;
                    i = Math.max(0, Math.min(255, i))
                }
                f = w(n === null ? this.rgb[0] : n, t === null ? this.rgb[1] : t, i === null ? this.rgb[2] : i), f[0] !== null && (this.hsv[0] = Math.max(0, Math.min(360, f[0]))), f[2] !== 0 && (this.hsv[1] = f[1] === null ? null : Math.max(0, this.minS, Math.min(100, this.maxS, f[1]))), this.hsv[2] = f[2] === null ? null : Math.max(0, this.minV, Math.min(100, this.maxV, f[2])), e = u(this.hsv[0], this.hsv[1], this.hsv[2]), this.rgb[0] = e[0], this.rgb[1] = e[1], this.rgb[2] = e[2], this.exportColor(r)
            }, this.fromString = function (n, t) {
                var i, r, u, f, e, o;
                if (i = n.match(/^\W*([0-9A-F]{3}([0-9A-F]{3})?)\W*$/i)) return i[1].length === 6 ? this.fromRGB(parseInt(i[1].substr(0, 2), 16), parseInt(i[1].substr(2, 2), 16), parseInt(i[1].substr(4, 2), 16), t) : this.fromRGB(parseInt(i[1].charAt(0) + i[1].charAt(0), 16), parseInt(i[1].charAt(1) + i[1].charAt(1), 16), parseInt(i[1].charAt(2) + i[1].charAt(2), 16), t), !0;
                if ((i = n.match(/^\W*rgba?\(([^)]*)\)\W*$/i)) && (r = i[1].split(","), u = /^\s*(\d*)(\.\d+)?\s*$/, r.length >= 3 && (f = r[0].match(u)) && (e = r[1].match(u)) && (o = r[2].match(u)))) {
                    var s = parseFloat((f[1] || "0") + (f[2] || "")), h = parseFloat((e[1] || "0") + (e[2] || "")),
                        c = parseFloat((o[1] || "0") + (o[2] || ""));
                    return this.fromRGB(s, h, c, t), !0
                }
                return !1
            }, this.toString = function () {
                return (256 | Math.round(this.rgb[0])).toString(16).substr(1) + (256 | Math.round(this.rgb[1])).toString(16).substr(1) + (256 | Math.round(this.rgb[2])).toString(16).substr(1)
            }, this.toHEXString = function () {
                return "#" + this.toString().toUpperCase()
            }, this.toRGBString = function () {
                return "rgb(" + Math.round(this.rgb[0]) + "," + Math.round(this.rgb[1]) + "," + Math.round(this.rgb[2]) + ")"
            }, this.isLight = function () {
                return .213 * this.rgb[0] + .715 * this.rgb[1] + .072 * this.rgb[2] > 255 / 2
            }, this._processParentElementsInDOM = function () {
                var t, i;
                if (!this._linkedElementsProcessed) {
                    this._linkedElementsProcessed = !0, t = this.targetElement;
                    do i = n.getStyle(t), i && i.position.toLowerCase() === "fixed" && (this.fixed = !0), t !== this.targetElement && (t._jscEventsAttached || (n.attachEvent(t, "scroll", n.onParentScroll), t._jscEventsAttached = !0)); while ((t = t.parentNode) && !n.isElementType(t, "body"))
                }
            }, typeof t == "string" ? (o = t, s = document.getElementById(o), s ? this.targetElement = s : n.warn("Could not find target element with ID '" + o + "'")) : t ? this.targetElement = t : n.warn("Invalid target element: '" + t + "'"), this.targetElement._jscLinkedInstance) {
                n.warn("Cannot link jscolor twice to the same element. Skipping.");
                return
            }
            this.targetElement._jscLinkedInstance = this, this.valueElement = n.fetchElement(this.valueElement), this.styleElement = n.fetchElement(this.styleElement);
            var r = this,
                h = this.container ? n.fetchElement(this.container) : document.getElementsByTagName("body")[0], y = 3;
            n.isElementType(this.targetElement, "button") && (this.targetElement.onclick ? (p = this.targetElement.onclick, this.targetElement.onclick = function (n) {
                return p.call(this, n), !1
            }) : this.targetElement.onclick = function () {
                return !1
            }), this.valueElement && n.isElementType(this.valueElement, "input") && (c = function () {
                r.fromString(r.valueElement.value, n.leaveValue), n.dispatchFineChange(r)
            }, n.attachEvent(this.valueElement, "keyup", c), n.attachEvent(this.valueElement, "input", c), n.attachEvent(this.valueElement, "blur", k), this.valueElement.setAttribute("autocomplete", "off")), this.styleElement && (this.styleElement._jscOrigStyle = {
                backgroundImage: this.styleElement.style.backgroundImage,
                backgroundColor: this.styleElement.style.backgroundColor,
                color: this.styleElement.style.color
            }), this.value ? this.fromString(this.value) || this.exportColor() : this.importColor()
        }
    };
    return n.jscolor.lookupClass = "jscolor", n.jscolor.installByClassName = function (t) {
        var i = document.getElementsByTagName("input"), r = document.getElementsByTagName("button");
        n.tryInstallOnElements(i, t), n.tryInstallOnElements(r, t)
    }, n.register(), n.jscolor
}());
var saveAs = saveAs || function (n) {
    if (typeof n != "undefined" && (typeof navigator == "undefined" || !/MSIE [1-9]\./.test(navigator.userAgent))) {
        var s = n.document, r = function () {
                return n.URL || n.webkitURL || n
            }, i = s.createElementNS("http://www.w3.org/1999/xhtml", "a"), h = "download" in i, c = function (n) {
                var t = new MouseEvent("click");
                n.dispatchEvent(t)
            }, l = /constructor/i.test(n.HTMLElement) || n.safari, u = /CriOS\/[\d]+/.test(navigator.userAgent),
            a = function (t) {
                (n.setImmediate || n.setTimeout)(function () {
                    throw t;
                }, 0)
            }, v = "application/octet-stream", y = 4e4, f = function (n) {
                var t = function () {
                    typeof n == "string" ? r().revokeObjectURL(n) : n.remove()
                };
                setTimeout(t, y)
            }, p = function (n, t, i) {
                var r, u;
                for (t = [].concat(t), r = t.length; r--;) if (u = n["on" + t[r]], typeof u == "function") try {
                    u.call(n, i || n)
                } catch (f) {
                    a(f)
                }
            }, e = function (n) {
                return /^\s*(?:text\/\S*|application\/xml|\S*\/\S*\+xml)\s*;.*charset\s*=\s*utf-8/i.test(n.type) ? new Blob([String.fromCharCode(65279), n], {type: n.type}) : n
            }, o = function (t, o, s) {
                s || (t = e(t));
                var a = this, k = t.type, b = k === v, y, w = function () {
                    p(a, "writestart progress write writeend".split(" "))
                }, d = function () {
                    var i, e;
                    if ((u || b && l) && n.FileReader) {
                        i = new FileReader, i.onloadend = function () {
                            var t = u ? i.result : i.result.replace(/^data:[^;]*;/, "data:attachment/file;"),
                                r = n.open(t, "_blank");
                            r || (n.location.href = t), t = undefined, a.readyState = a.DONE, w()
                        }, i.readAsDataURL(t), a.readyState = a.INIT;
                        return
                    }
                    y || (y = r().createObjectURL(t)), b ? n.location.href = y : (e = n.open(y, "_blank"), e || (n.location.href = y)), a.readyState = a.DONE, w(), f(y)
                };
                if (a.readyState = a.INIT, h) {
                    y = r().createObjectURL(t), setTimeout(function () {
                        i.href = y, i.download = o, c(i), w(), f(y), a.readyState = a.DONE
                    });
                    return
                }
                d()
            }, t = o.prototype, w = function (n, t, i) {
                return new o(n, t || n.name || "download", i)
            };
        return typeof navigator != "undefined" && navigator.msSaveOrOpenBlob ? function (n, t, i) {
            return t = t || n.name || "download", i || (n = e(n)), navigator.msSaveOrOpenBlob(n, t)
        } : (t.abort = function () {
        }, t.readyState = t.INIT = 0, t.WRITING = 1, t.DONE = 2, t.error = t.onwritestart = t.onprogress = t.onwrite = t.onabort = t.onerror = t.onwriteend = null, w)
    }
}(typeof self != "undefined" && self || typeof window != "undefined" && window || this);
typeof module != "undefined" && module.exports ? module.exports.saveAs = saveAs : typeof define != "undefined" && define !== null && define.amd !== null && define("FileSaver.js", function () {
    return saveAs
}), $(document).ready(function () {
    function s(n) {
        return n instanceof HTMLElement || n instanceof SVGElement
    }

    function n(n) {
        if (!s(n)) throw new Error("an HTMLElement or SVGElement is required; got " + n);
    }

    function h(n) {
        return n && n.lastIndexOf("http", 0) == 0 && n.lastIndexOf(window.location.host) == -1
    }

    function c(t, i) {
        var f;
        n(t);
        var e = t.querySelectorAll("image"), r = e.length, u = function () {
            r === 0 && i()
        };
        for (u(), f = 0; f < e.length; f++) (function (n) {
            var f = document.createElement("canvas"), e = f.getContext("2d"), i = new Image, t;
            i.crossOrigin = "anonymous", t = n.getAttributeNS("http://www.w3.org/1999/xlink", "href"), t = t || n.getAttribute("href"), h(t) && (t += (t.indexOf("?") === -1 ? "?" : "&") + "t=" + (new Date).valueOf()), t ? (i.src = t, i.onload = function () {
                f.width = i.width, f.height = i.height, e.drawImage(i, 0, 0), n.setAttributeNS("http://www.w3.org/1999/xlink", "href", f.toDataURL("image/png")), r--, u()
            }, i.onerror = function () {
                console.log("Could not load " + t), r--, u()
            }) : (r--, u())
        })(e[f])
    }

    function l(n, t, i) {
        function g(n) {
            for (var r = {
                woff2: "font/woff2",
                woff: "font/woff",
                otf: "application/x-font-opentype",
                ttf: "application/x-font-ttf",
                eot: "application/vnd.ms-fontobject",
                sfnt: "application/font-sfnt",
                svg: "image/svg+xml"
            }, u = Object.keys(r), i, t = 0; t < u.length; ++t) if (i = u[t], n.indexOf("." + i) > 0) return r[i];
            return console.error("Unknown font format for " + n + "; Fonts may not be working correctly"), "application/octet-stream"
        }

        function a(n) {
            function r(t) {
                function u() {
                    var n = i.response, r = nt(n);
                    f(t, r)
                }

                function r(i) {
                    console.warn("Failed to load font from: " + t.url), console.warn(i), e += t.text + "\n", a(n)
                }

                function f(t, i) {
                    var r = 'url("data:' + t.format + ";base64," + i + '")';
                    e += t.text.replace(t.fontUrlRegexp, r) + "\n", setTimeout(function () {
                        a(n)
                    }, 0)
                }

                var i = new XMLHttpRequest;
                i.addEventListener("load", u), i.addEventListener("error", r), i.addEventListener("abort", r), i.open("GET", t.url), i.responseType = "arraybuffer", i.send()
            }

            if (n.length > 0) {
                var t = n.pop();
                r(t)
            } else i(e)
        }

        function nt(n) {
            for (var i = "", r = new Uint8Array(n), u = r.byteLength, t = 0; t < u; t++) i += String.fromCharCode(r[t]);
            return window.btoa(i)
        }

        for (var v = t.selectorRemap, y = t.modifyStyle, k = t.modifyCss || function (n, t) {
            var n = v ? v(n) : n, i = y ? y(t) : t;
            return n + " { " + i + " }\n"
        }, e = "", p = [], o = document.styleSheets, h, c, l, u, s, f = 0; f < o.length; f++) {
            try {
                h = o[f].cssRules
            } catch (tt) {
                console.warn("Stylesheet could not be loaded: " + o[f].href);
                continue
            }
            if (h != null) for (c = 0; c < h.length; c++, l = null) if (u = h[c], typeof u.style != "undefined") {
                try {
                    s = u.selectorText
                } catch (it) {
                    console.warn('The following CSS rule has an invalid selector: "' + u + '"', it)
                }
                try {
                    s && (l = n.querySelector(s) || n.parentNode && n.parentNode.querySelector(s))
                } catch (it) {
                    console.warn('Invalid CSS selector "' + s + '"', it)
                }
                if (l) e += k(u.selectorText, u.style.cssText); else if (u.cssText.match(/^@font-face/)) {
                    var w = /url\(["']?(.+?)["']?\)/, b = u.cssText.match(w), r = b && b[1] || "",
                        d = r.match(/^data:/);
                    d && (r = ""), r === "about:blank" && (r = ""), r ? (r.startsWith("../") ? r = o[f].href + "/../" + r : r.startsWith("./") && (r = o[f].href + "/." + r), p.push({
                        text: u.cssText,
                        fontUrlRegexp: w,
                        format: g(r),
                        url: r
                    })) : e += u.cssText + "\n"
                }
            }
        }
        a(p)
    }

    function t(n, t, i) {
        var r = n.viewBox && n.viewBox.baseVal && n.viewBox.baseVal[i] || t.getAttribute(i) !== null && !t.getAttribute(i).match(/%$/) && parseInt(t.getAttribute(i)) || n.getBoundingClientRect()[i] || parseInt(t.style[i]) || parseInt(window.getComputedStyle(n).getPropertyValue(i));
        return typeof r == "undefined" || r === null || isNaN(parseFloat(r)) ? 0 : r
    }

    function a(n) {
        return n = encodeURIComponent(n), n = n.replace(/%([0-9A-F]{2})/g, function (n, t) {
            var i = String.fromCharCode("0x" + t);
            return i === "%" ? "%25" : i
        }), decodeURIComponent(n)
    }

    function i(i, r, u) {
        n(i), r = r || {}, r.scale = r.scale || 1, r.responsive = r.responsive || !1;
        var f = "http://www.w3.org/2000/xmlns/";
        c(i, function () {
            function y(t) {
                var r = document.createElement("style"), f, i;
                r.setAttribute("type", "text/css"), r.innerHTML = "<![CDATA[\n" + t + "\n]\]>", f = document.createElement("defs"), f.appendChild(r), n.insertBefore(f, n.firstChild), u && (i = v.innerHTML, i = i.replace(/NS\d+:href/gi, 'xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href'), u(i, e, o))
            }

            var v = document.createElement("div"), n = i.cloneNode(!0), e, o, s, a, c, h;
            if (i.tagName == "svg") e = r.width || t(i, n, "width"), o = r.height || t(i, n, "height"); else if (i.getBBox) s = i.getBBox(), e = s.x + s.width, o = s.y + s.height, n.setAttribute("transform", n.getAttribute("transform").replace(/translate\(.*?\)/, "")), a = document.createElementNS("http://www.w3.org/2000/svg", "svg"), a.appendChild(n), n = a; else {
                console.error("Attempted to render non-SVG element", i);
                return
            }
            for (n.setAttribute("version", "1.1"), n.getAttribute("xmlns") || n.setAttributeNS(f, "xmlns", "http://www.w3.org/2000/svg"), n.getAttribute("xmlns:xlink") || n.setAttributeNS(f, "xmlns:xlink", "http://www.w3.org/1999/xlink"), r.responsive ? (n.removeAttribute("width"), n.removeAttribute("height"), n.setAttribute("preserveAspectRatio", "xMinYMin meet")) : (n.setAttribute("width", e * r.scale), n.setAttribute("height", o * r.scale)), n.setAttribute("viewBox", [r.left || 0, r.top || 0, e, o].join(" ")), c = n.querySelectorAll("foreignObject > *"), h = 0; h < c.length; h++) c[h].getAttribute("xmlns") || c[h].setAttributeNS(f, "xmlns", "http://www.w3.org/1999/xhtml");
            v.appendChild(n), l(i, r, y)
        })
    }

    function r(n, t, r) {
        i(n, t, function (n) {
            var t = "data:image/svg+xml;base64," + window.btoa(a(o + n));
            r && r(t)
        })
    }

    function v(t, u, f) {
        n(t), u = u || {}, u.encoderType = u.encoderType || "image/png", u.encoderOptions = u.encoderOptions || .8;
        var e = function (n, t, i) {
            var r = document.createElement("canvas"), e = r.getContext("2d"), o, s;
            r.width = t, r.height = i, o = window.devicePixelRatio || 1, r.style.width = r.width + "px", r.style.height = r.height + "px", r.width *= o, r.height *= o, e.setTransform(o, 0, 0, o, 0, 0), u.canvg ? u.canvg(r, n) : e.drawImage(n, 0, 0), u.backgroundColor && (e.globalCompositeOperation = "destination-over", e.fillStyle = u.backgroundColor, e.fillRect(0, 0, r.width, r.height));
            try {
                s = r.toDataURL(u.encoderType, u.encoderOptions)
            } catch (h) {
                if (typeof SecurityError != "undefined" && h instanceof SecurityError || h.name == "SecurityError") {
                    console.error("Rendered SVG images cannot be downloaded in this browser.");
                    return
                }
                throw h;
            }
            f(s)
        };
        u.canvg ? i(t, u, e) : r(t, u, function (n) {
            var t = new Image;
            t.onload = function () {
                e(t, t.width, t.height)
            }, t.onerror = function () {
                console.error("There was an error loading the data URI as an image on the following SVG\n", window.atob(n.slice(26)), "\n", "Open the following link to see browser's diagnosis\n", n)
            }, t.src = n
        })
    }

    function u(n, t) {
        var i, u, r;
        if (navigator.msSaveOrOpenBlob) navigator.msSaveOrOpenBlob(f(t), n); else if (i = document.createElement("a"), "download" in i) {
            i.download = n, i.style.display = "none", document.body.appendChild(i);
            try {
                u = f(t), r = URL.createObjectURL(u), i.href = r, i.onclick = function () {
                    requestAnimationFrame(function () {
                        URL.revokeObjectURL(r)
                    })
                }
            } catch (e) {
                console.warn("This browser does not support object URLs. Falling back to string URL."), i.href = t
            }
            i.click(), document.body.removeChild(i)
        } else window.open(t, "_temp", "menubar=no,toolbar=no,status=no")
    }

    function f(n) {
        for (var i = window.atob(n.split(",")[1]), u = n.split(",")[0].split(":")[1].split(";")[0], r = new ArrayBuffer(i.length), f = new Uint8Array(r), t = 0; t < i.length; t++) f[t] = i.charCodeAt(t);
        return new Blob([r], {type: u})
    }

    function y(t, i, r) {
        n(t), r = r || {}, v(t, r, function (n) {
            u(i, n)
        })
    }

    var e = typeof exports != "undefined" && exports || typeof define != "undefined" && {} || this,
        o = '<?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd" [<!ENTITY nbsp "&#160;">]>';
    typeof define != "undefined" && define(function () {
        return e
    });
    $(document).on("click", ".btn-down-png", function () {
        var n = $(this).attr("id");
        $.axse({oper: "downchahua", id: n}, function (n) {
            if (n == "login") showlogin(); else if (n == "pay") addPop(), $(".with-line").html("开通插画VIP，工作领先一步，低至0.07元/天！"), $(".black-overlay,.framebox.downconfirm").show(), $(".pop_container").addClass("pop_show"), $(".a_downconfirm").attr("href", "/vip/chahua").text("立即开通").show(), $(".paytip").html(""); else if (n == "true") {
                var t = $(".modalLg__title").text(), i = $(".modalLg__media svg");
                y(i[0], t, {scale: 3})
            } else error(n)
        })
    })
}), document.onkeydown = document.onkeyup = document.onkeypress = function (n) {
    var t = n || window.event || arguments.callee.caller.arguments[0];
    if (t && t.keyCode == 123) return t.returnValue = !1, !1
}, $(document).ready(function () {
    isIE() && (window.document.oncontextmenu = function () {
        return !1
    }), $(".svgUrl").each(function () {
        var n = $(this), t = n.attr("id");
        $.ajax({
            type: "post", data: {id: t}, url: "/svg/GetSvg", async: !0, dataType: "html", success: function (t) {
                n.html(t)
            }
        })
    }), $(".svgUrl svg").hover(function () {
        $(this).css("transform", "scale(1.2);")
    });
    $(document).on("click", ".modal__header__close", function () {
        $(".popup-overlay").remove()
    });
    $(".gridItem").click(function () {
        var t = $(this).attr("id"), i = $(this).children(".gridItem__title").text(),
            r = $(this).children(".svgUrl").html(), n = "";
        n += "<div class='popup-overlay ' style='position: fixed; top: 0px; bottom: 0px; left: 0px; right: 0px; background: rgba(0, 0, 0, 0.5); display: flex; z-index: 999;'>", n += "    <div class='popup-content ' style='position: relative; background: rgb(255, 255, 255); width: 50%; margin: auto; border: 1px solid rgb(187, 187, 187); padding: 5px;'>", n += "        <div>", n += "            <div class='modal__header'>", n += "                <div class='modal__header__close'>", n += "                    <i class='icon icon-cuowu'><\/i>", n += "                <\/div>", n += "            <\/div>", n += "            <div class='modal__mobile'>", n += "                <div class='modal__mobile__title'>", n += "                " + i, n += "                <\/div>", n += "                " + r, n += "            <\/div>", n += "            <div class='modalLg'>", n += "                <div class='modalLg__media'>", n += "                     " + r, n += "                <\/div>", n += "                <div class='modalLg__content'>", n += "                    <h2 class='modalLg__title'>" + i + "<\/h2>", n += "                    <button class='modalLg__button modalLg__button__primary btn-down-svg' id='" + t + "'>下载Svg<\/button>", n += "                    <button class='modalLg__button btn-down-png' id='" + t + "'>下载高清Png<\/button>", n += "                <\/div>", n += "            <\/div>", n += "        <\/div>", n += "    <\/div>", n += "<\/div>", $("body").append(n)
    });
    $("#nColor").on("change", function () {
        $(".svgUrl").each(function () {
            var n = $(this), t = n.html(), i = t.replace(new RegExp($("#dColor").val(), "g"), $("#nColor").val());
            n.html(i)
        }), $("#dColor").val($("#nColor").val())
    });
    $(document).on("click", ".btn-down-svg", function () {
        var n = $(this).attr("id");
        $.axse({oper: "downchahua", id: n}, function (n) {
            if (n == "login") showlogin(); else if (n == "pay") addPop(), $(".with-line").html("开通插画VIP，工作领先一步，低至0.07元/天！"), $(".black-overlay,.framebox.downconfirm").show(), $(".pop_container").addClass("pop_show"), $(".a_downconfirm").attr("href", "/vip/chahua").text("立即开通").show(), $(".paytip").html(""); else if (n == "true") {
                var t = $(".modalLg__title").text(),
                    i = new Blob([$(".modalLg__media").html()], {type: "image/svg+xml;charset=utf-8"});
                saveAs(i, t + ".svg")
            } else error(n)
        })
    })
})