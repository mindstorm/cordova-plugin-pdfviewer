/* global require, module */

var exec = require("cordova/exec");

var PDFViewer = function () {
	var me = this;

	me.name = "PDFViewer";
	me.version = "1.1.0";
};

// openPDF
PDFViewer.prototype.openPDF = function (onSuccess, onError, options) {
	exec(onSuccess, onError, "PDFViewer", "openPDF", [options]);
};

module.exports = new PDFViewer();