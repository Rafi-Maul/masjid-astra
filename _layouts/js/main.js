var ieFlag, appHeadElm, modulElm, mainFrameElm, menuFrameElm, tabContentElm;
var chromeFlag, modTitleElm, contentMenuElm, tabIframeElm, actBarElm, processFormElm;
var topFormElm, contentElm, tblElm, tblTopElm, footContentElm, listContainerElm;
var mainReportElm;
var flagResize;
var colorOdd = '#FFFFFF', colorEven = '#F7FAFD';
var s4b_error = '';
var ieVersion = {version: 0};
var openerPopupWidth, openerPopupHeight;
var showExpired;

function init() {
	ieFlag = ((navigator.userAgent.toLowerCase().indexOf('msie') == -1) ? false : true );
	if (ieFlag) {
		if (navigator.userAgent.toLowerCase().indexOf('msie 6') > 0)
			ieVersion.version = 6;
		else
			ieVersion.version = 789;
	}
    chromeFlag = ((navigator.userAgent.toLowerCase().indexOf('chrome') == -1) ? false : true );
	if (typeof beforeInit != 'undefined') beforeInit();
	setInit();
	if (typeof afterInit != 'undefined') afterInit();
	if (s4b_error != '') {
		alert(s4b_error);
	}
	$('form#main-form').css('visibility', 'visible');	
	
	showExpired = true;
}

function setInit() {
	var popupWidth, popupHeight, ieHeighMagic;
	
	appHeadElm = $('div#app-head');
	modulElm = $('div#modul');
	mainFrameElm = $('iframe#main-frame');
	menuFrameElm = $('iframe#menu-frame');
	modTitleElm = $('div#mod-title');
	contentMenuElm = $('div#content-menu');		
	tabContentElm = $('div#tab-container');
	processFormElm = $('div#process-form');	
	listContainerElm = $('div#list-container');
	tabIframeElm = $('iframe#tab-iframe');	
	actBarElm = $('div#act-bar');
	topFormElm = $('div#top-form');
	contentElm = $('div#content');	
	tblElm = $('table#tbl');
	tblTopElm = $('table#tbl-top');
	footContentElm = $('div#foot-content');
	mainReportElm = $('div#report');
	
	if ((opener) && (!opener.top.flagResize)) {
		// Kalibrasi nilai/dimensi dari popup
		popupWidth = 0;
		popupHeight = 0;
			
		// Bila ada form di atas
		if ($(tblTopElm).size() > 0) {
			popupWidth = $(tblTopElm).outerWidth();			
				
			if ($(contentElm).size() == 0) {
				if (ieFlag) 
					popupHeight = $(tabContentElm).height() + $(processFormElm).height();
				else
					popupHeight = $(tabContentElm).outerHeight() + $(processFormElm).outerHeight();
			} else {
				popupWidth = $(contentElm).outerWidth();
				if (ieFlag)
					popupHeight = $(tabContentElm).height() + $(processFormElm).height() + $(contentElm).height();
				else
					popupHeight = $(tabContentElm).outerHeight() + $(processFormElm).outerHeight() + $(contentElm).outerHeight();
				$(contentElm).css('overflow', 'auto');				
			}
			
			$(processFormElm).css('overflow', 'auto');			
		
		}
		resizeTo(popupWidth, popupHeight);
		ieHeighMagic = 10;
		if ((popupHeight - $(window).height()) != 0)
			resizeBy(0, Math.abs(popupHeight - $(window).height() + ((ieFlag) ? (ieVersion.version == 789 ? ieHeighMagic : 0) : 0)));

		if ((popupHeight - $(window).height()) < (ieHeighMagic * (-1)))
			resizeTo(popupWidth, popupHeight + 65);		

		moveTo(((screen.availWidth / 2) - ($(window).width() / 2)), ((screen.availHeight / 2) - ($(window).height() / 2)));
		opener.top.flagResize = true;			
		
		$(document.body).css('background-color', '#A3BDE3');
		$('form#main-form').css('visibility', 'visible');		
	}	
	
	setEvent();
	setLayout();

	if ((actBarElm) && (topFormElm) && (contentElm) && (tblElm) && (chromeFlag)) {
		if ($(tblElm).height() < $(contentElm).height())
			$(contentElm).css('overflow-y', 'hidden');	
		top.setLayout();                                         
	}	
	
	setNumericInput();
	setCOAInput();
}

function setEvent() {
	$(window).bind('resize', function() {
		setLayout();
	});
	
	if ((modulElm) && (menuFrameElm)) {
		$('div#left-modul > a', modulElm).bind('click', menuModulClick);
	}
	
	if (contentMenuElm) {
		$('a.menu-item').bind('click', menuClick);
		$('div.sub-menu-items > a').bind('click', subMenuClick);
	}
	
	if (tabContentElm) {
		$('div#tab-container > div').bind('click', tabClick);
	}
}

function setLayout() {
	var colNum, strHTML;
	
	if ((appHeadElm) && (modulElm) && (mainFrameElm) && (menuFrameElm) && (tabContentElm)) {
		$(mainFrameElm).height($(window).height() - ($(appHeadElm).outerHeight() + $(modulElm).outerHeight() + ((ieFlag) ? (ieVersion.version == 6 ? -12 : 0) : 0)));
		$(mainFrameElm).width($(window).width() - $(menuFrameElm).outerWidth() - ((ieFlag) ? 8 : 10));
		$(menuFrameElm).height($(window).height() - ($(appHeadElm).outerHeight() + $(modulElm).outerHeight() + ((ieFlag) ? (ieVersion.version == 6 ? 3 : 5) : 5)));
	}
	
	if ((modTitleElm) && (contentMenuElm)) {
		$(contentMenuElm).height($(window).height() - $(modTitleElm).outerHeight());
	}
	
	if ((listContainerElm) && (tabContentElm)) {
		$(tabIframeElm).height($(window).height() - $(tabContentElm).outerHeight() - ((ieFlag) ? 3 : 3));
		$(tabIframeElm).width($(window).width());		
	}	
	
	if (mainFrameElm.size() > 0) {
		try {
			mainFrameElm.get(0).contentWindow.setLayout();     
		} catch (oError) {
		
		}
	}
	
	if (menuFrameElm.size() > 0) {
		try {
			menuFrameElm.get(0).contentWindow.setLayout();
		} catch (oError) {
		
		}
	}
	
	if (tabIframeElm.size() > 0) {
		try {
			tabIframeElm.get(0).contentWindow.setLayout();
		} catch(oError) {
		
		}
	}
	
	if ((actBarElm) && (topFormElm) && (contentElm) && (tblElm)) {

		if ($('tbody tr', tblElm).size() == 0) {
			colNum = 0;
			$('tr:first-child > th', tblElm).each(function() {
				colNum += parseInt(($(this).attr('colspan') == undefined ? 1 : $(this).attr('colspan')));
			});

			strHTML = '';
			strHTML = "<tr>";
			for (var i = 0; i < colNum; i++) {
				strHTML += '<td>&nbsp;</td>';
			}
			strHTML += '</tr>';

			$('tbody', tblElm).append(strHTML);
		}

		if ($('tr#last-row', tblElm).size() == 0) {
			$('tbody', tblElm).append($('tbody tr:last-child', tblElm).clone().attr('id', 'last-row'));
			$('#last-row td').html('&nbsp;');
		}
		
		$('table#tbl tbody > tr:odd').css('background-color', colorOdd);
		$('table#tbl tbody > tr:even').css('background-color', colorEven);
		
		if (opener) {
			// Bentangkan...
			$(tblTopElm).attr('width', '100%');
		
			if (ieFlag)
				$(contentElm).height($(window).height() - ($(actBarElm).height() + $(topFormElm).height() + $(tabContentElm).height() + $(processFormElm).height() + $(footContentElm).height()));					
			else
				$(contentElm).height($(window).height() - ($(actBarElm).outerHeight() + $(topFormElm).outerHeight() + $(tabContentElm).outerHeight() + $(processFormElm).outerHeight() + $(footContentElm).outerHeight()));					
		} else
			$(contentElm).height($(window).height() - ($(actBarElm).outerHeight() + $(topFormElm).outerHeight() + $(tabContentElm).outerHeight() + $(processFormElm).outerHeight() + $(footContentElm).outerHeight()));		
		
		$('#last-row').hide();

		if ($(tblElm).height() < $(contentElm).height()) {	
			$(contentElm).css('overflow-y', 'hidden');
			$('#last-row').show();
			$('#last-row').height($('#last-row').height() + ($(contentElm).height() - $(tblElm).height()));
		} else
			$(contentElm).css('overflow-y', 'auto');            

		if ((opener) && ($(contentElm).height() == null)) {		
			if (ieFlag)
				$(processFormElm).height($(window).height() - $(tabContentElm).height());
			else
				$(processFormElm).height($(window).height() - $(tabContentElm).outerHeight());
		}

	}
	
	if ($(mainReportElm).size() > 0) {
		$(mainReportElm).height($(window).height());
	}
		
	$(document.body).css('visibility', 'visible');	
}

function menuModulClick() {
	setMenuFrameZero();
	setMainFrameZero();
	$('a', modulElm).each(function() {
		$(this).attr('class', 'a-modul');
	});
	$(this).attr('class', 'a-modul-on');
	$(menuFrameElm).css('visibility', 'visible');
}

function menuClick() {
	var myIndex;
	
	if (!$(this).hasClass('on')) {	
		myIndex = $('a.menu-item').index(this);
			
		$('a.menu-item').each(function() {	
			$(this).removeClass('on');
		});

		$('div.sub-menu-items').each(function() {
			$(this).removeClass('on');
			if (myIndex == $('div.sub-menu-items').index(this))
				$(this).toggleClass('on'); 
		});
		
		$('div.sub-menu-items > a.active').toggleClass('active');
		top.setMainFrameZero();
	
		$(this).toggleClass('on');	
	}
}

function subMenuClick() {
	if (!$(this).hasClass('active')) {
		$('div.sub-menu-items > a.active').toggleClass('active');
		top.setMainFrameZero();
		$(this).toggleClass('active');	
		$(top.mainFrameElm).css('visibility', 'visible');			
	}	
}

function tabClick() {
	if (!$(this).hasClass('active')) {
		$('div#tab-container > div').removeClass('active');
		$(this).toggleClass('active');
	}
}

function setMenuFrameZero() {
	$(menuFrameElm).attr('src', 'core/main/blank');	
}

function setMainFrameZero() {
	$(mainFrameElm).css('visibility', 'hidden');
	$(mainFrameElm).attr('src', 'core/main/blank');		
}

function dummy() {

}

function openPop(url, name, winWidth, winHeight) {
	var winName, leftPos, topPos;

	if (typeof(name) == 'undefined')
		winName = 'undefined';
	else
		winName = name;

	if (typeof(winWidth) == 'undefined')
		winWidth = screen.availWidth - 200;

	if (typeof(winHeight) == 'undefined')
		winHeight = screen.availHeight - 200;
		
	openerPopupWidth  = winWidth; 
	openerPopupHeight = winHeight;	
			
	leftPos = (screen.availWidth / 2) - (winWidth / 2);
	topPos  = (screen.availHeight / 2) - (winHeight / 2);
	
    top.flagResize = false;

	open(url, winName, "copyhistory=no, status=yes, resizable=yes, toolbar=no, location=no, width=" + winWidth + ",height=" + winHeight + ",left=" + leftPos + ",top=" + topPos);
}

function sleep(milliseconds) {
  	var start = new Date().getTime();
  	for (var i = 0; i < 1e7; i++) {
    	if ((new Date().getTime() - start) > milliseconds) {
      		break;
    	}
  	}
}

function checkItAll(elm) {
	$('#tbl input:checkbox').each(function(i) {
		if (this != elm)
			this.checked = elm.checked;
	});
}

function paging(page) {
	$('form#paging-form  #s4b-page').val(page);
	$('form#paging-form').submit();
}

/*******************************************************************************
 * AJAX & SUBMIT FORM
 ******************************************************************************/ 

var submitElm, nextActionClosed;

function submitForm(elm, optional, fClose) {
	var oForm, params;	
	oForm = elm.form;
	fClose = (typeof(fClose) == 'undefined') ? false : fClose;
	nextActionClosed = fClose;
	if (!validate(oForm, optional)) return false;		
	if (confirm('Anda yakin untuk mengirimkan data-data ini ?')) {
		// Untuk keperluan indikator loading		
		$('form#main-form').css('visibility', 'hidden');
		elm.disabled = true;
		params = getRequestBody(oForm);
		sendXMLHttpRequest(oForm.action, responseSubmit, params)
		submitElm = elm;					
		return false;
	} else
		return false;
}

function validate(elm, strEx) {
    var oForm, oElmForm, retVal, rgx, resArr;
    var safeName, safeRgx;        
    
    oForm = elm;
    oElmForm = oForm.elements;
    
    strEx = strEx ? strEx : '';             
    
    retVal = true;
    for (var i = 0; i < oElmForm.length; i++) {
        if ((oElmForm[i].value == '') && (!oElmForm[i].disabled) && (oElmForm[i].name) && (oElmForm[i].type)) {
            if (strEx.length > 0) {
                safeRgx = /\[\]/g;
                safeName = oElmForm[i].name.toString().replace(safeRgx, "\\[\\]");
                rgx = eval('/' + safeName + '/i');
                resArr = strEx.toString().match(rgx);           
            } else
                resArr = null;
            if ((oElmForm[i].type != 'hidden') && (!resArr)) {
                oElmForm[i].style.background = 'red';
                oElmForm[i].style.color = 'white';
                retVal = false;               
            }
        } else if ((!oElmForm[i].disabled) && (oElmForm[i].name) && (oElmForm[i].type)) {
            if (oElmForm[i].type != 'checkbox') {
                oElmForm[i].style.background = 'white';
                oElmForm[i].style.color = 'black';                
            }
        }
    }
    if (!retVal)
        alert('Harap lengkapi data-data yang berwarna merah !');                                
    return retVal;
}

function submitReqForm(elm, fClose) {
	var oForm, params;	
	oForm = elm.form;
	fClose = (typeof(fClose) == 'undefined') ? false : fClose;
	nextActionClosed = fClose;
	if (!validateReqForm(oForm)) return false;		
	if (confirm('Anda yakin untuk mengirimkan data-data ini ?')) {
		// Untuk keperluan indikator loading		
		$('form#main-form').css('visibility', 'hidden');
		elm.disabled = true;
		params = getRequestBody(oForm);
		sendXMLHttpRequest(oForm.action, responseSubmit, params)	
		submitElm = elm;					
		return false;
	} else
		return false;
}

function submitReqFormNoReturn(elm, fClose) {
	var oForm, params;	
	oForm = elm.form;
	fClose = (typeof(fClose) == 'undefined') ? false : fClose;
	nextActionClosed = fClose;
	if (!validateReqForm(oForm)) return;		
	if (confirm('Anda yakin untuk mengirimkan data-data ini ?')) {
		// Untuk keperluan indikator loading		
		$('form#main-form').css('visibility', 'hidden');
		elm.disabled = true;
		params = getRequestBody(oForm);
		sendXMLHttpRequest(oForm.action, responseSubmit, params)	
		submitElm = elm;					
	}
}

function validateReqForm(elm) {
    var oForm, oElmForm, retVal, rgx, resArr;
    var safeName, safeRgx;        
    
    oForm = elm;
    oElmForm = oForm.elements;
      
    retVal = true;
    for (var i = 0; i < oElmForm.length; i++) {
        if ((oElmForm[i].value == '') && (!oElmForm[i].disabled) && (oElmForm[i].name) && (oElmForm[i].type) && ($(oElmForm[i]).hasClass('required'))) {
			retVal = false;
			break;
        } 
    }
    if (!retVal)
        alert('Harap lengkapi data-data yang berwarna kuning !');
    return retVal;
}

function getRequestBody(oForm) {
	var sParam; 
	var aParams = new Array(); 
	for (var i=0 ; i < oForm.elements.length; i++) { 				
		switch (oForm.elements[i].tagName.toString().toLowerCase()) {
			case "button" :
				continue;
				break;
			default :
		}
		
		if (oForm.elements[i].disabled) continue;
		
		if (oForm.elements[i].name == "") continue;
		
		if (oForm.elements[i].type) {
			if (oForm.elements[i].type.toString().toLowerCase() == 'file') {
				continue;
			}
		}
		
		sParam = encodeURIComponent(oForm.elements[i].name); 
		sParam += "="; 
		sParam += encodeURIComponent(oForm.elements[i].value); 
		aParams.push(sParam); 
	} 
	sParam = "submit=1";
	aParams.push(sParam);		
	
	return aParams.join("&"); 
}

function sendXMLHttpRequest(url, func, params, asyncOption) {
	var reqObj = null;
	reqObj = createXMLHttp();
	if (!reqObj) {
		alert("XML HTTP tidak dapat dibuat !");
		reqObj = null;
	} else {
		reqObj.onreadystatechange = function() {
			if (reqObj.readyState == 4) {
				if (reqObj.status == 200) {
					func(reqObj);
				} else {
					alert("Tidak berhasil mengambil/mengirim data dengan XML HTTP !");
					// Untuk keperluan indikator loading
					$('form#main-form').css('visibility', 'visible');	
					submitElm.disabled = false;					
					returnVal = "";
				}
			}		
		}
		reqObj.open("POST", url, asyncOption);		
		reqObj.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");		
		reqObj.setRequestHeader("Cache-Control", "no-cache");
		/*if (typeof params == 'undefined') 
			params = null;
		else 
			reqObj.setRequestHeader("Content-Length", params.length);*/				
		reqObj.send(params);		
	}	
}

function createXMLHttp() {
	var aVersions = [ "MSXML2.XMLHttp.5.0", "MSXML2.XMLHttp.4.0", "MSXML2.XMLHttp.3.0", "MSXML2.XMLHttp", "Microsoft.XMLHttp"];
	var xmlObj; 

	if (window.XMLHttpRequest) {
		xmlObj = new XMLHttpRequest();
		return xmlObj;
	} else {
		for (var i = 0; i < aVersions.length; i++) { 
			try { 
				xmlObj = new ActiveXObject(aVersions[i]); 
				return xmlObj; 
			} catch (oError) { 
				// Do nothing		 
			}
		}
	}

	return false;	
}

function responseSubmit(resObj) {
	var rgx = /\s*[0-9a-zA-Z]+\s*/g;
	var strError;

	// Untuk keperluan indikator loading
	$('form#main-form').css('visibility', 'visible');
		
	if (resObj.responseText.toString().match(rgx)) {
		strError = resObj.responseText.toString();
		alert(strError);
	} else {
		if (opener) {
			opener.location.replace(opener.location.href);
			if (nextActionClosed) 
				close();
			else
				refreshPage();
		} else refreshPage();
	}
	submitElm.disabled = false;		
}

function refreshPage() {
	var winWidth, winHeight, leftPos, topPos;
	
	$('form#main-form').css('visibility', 'hidden');
	/*
	winWidth = screen.availWidth - 200;
	winHeight = screen.availHeight - 200;
	*/
	/*
	winWidth  = opener.openerPopupWidth;
	winHeight = opener.openerPopupHeight;
	
	leftPos = (screen.availWidth / 2) - (winWidth / 2);
	topPos = (screen.availHeight / 2) - (winHeight / 2);
	
	resizeTo(winWidth, winHeight);
	
	resizeBy((winWidth - $(window).width()), (winHeight - $(window).height()));
	moveTo(leftPos, topPos);
	
	opener.top.flagResize = false;					
    */
	location.replace(location.href);
}

function delForm(formID, strAction) {
	if (confirm('Anda yakin untuk menghapus data-data ini ?')) {
		$('form#' + formID).attr('action', strAction);
		$('form#' + formID).submit();
	}
}

/*****************************************************************************/
// SELECT AJAX
/*****************************************************************************/

var selectElm, lastOption;

function changeOptions(elm, objElm, table, show, value, extra, lastOpt, asyncOpt=true) {
	var params;
	
	lastOption = typeof lastOpt == 'undefined' ? false : lastOpt;
	selectElm = objElm;
	if (elm.value != '') {		
		// Untuk keperluan indikator loading
		$('form#main-form').css('visibility', 'hidden');

		// Kirim data
		params = 'table=' + encodeURIComponent(table) + '&show=' + encodeURIComponent(show) + '&value=' + encodeURIComponent(value) + '&' + encodeURIComponent(elm.name) + '=' + encodeURIComponent(elm.value) + '&opt=' + encodeURIComponent(extra);

		sendXMLHttpRequest("core/service/select", selectOptions, params, asyncOpt);								
	} else
		removeOptions(selectElm, '');	
}

function selectOptions(obj) {
	var rgxLine, rgxCol, arrLine, arrCol, count;
	
	if (typeof selectElm != 'object') {
		$('form#main-form').css('visibility', 'visible');
		return;
	} else
		removeOptions(selectElm, '');
	
	rgxLine = /~/;
	rgxCol = /\^/;
	arrLine = obj.responseText.toString().split(rgxLine);
	count = 0;
	for (var i = 0; i < arrLine.length; i++) {
		arrCol = arrLine[i].toString().split(rgxCol);
		if (encodeURIComponent(arrCol[0]) == '%09%0D%0A') 
			continue;
		else if (typeof(arrCol[1]) == 'undefined')
			continue;
		addOption(selectElm, arrCol[0], arrCol[1]);
		count++;
	}
	if (lastOption) {
		if (count == 0)
			addOption(selectElm, 'Pertama', 1);
		else
			addOption(selectElm, 'Terakhir', -1);
	}
	
	if ((opener) && (contentElm)) {
		/*
		moveBy(parseInt((document.body.clientWidth - contentElm.getElementsByTagName('table')[0].offsetWidth) / 2), 0);	
		resizeBy(contentElm.getElementsByTagName('table')[0].offsetWidth - document.body.clientWidth, 0);
		*/	
	}
	
	// Untuk keperluan indikator loading
	$('form#main-form').css('visibility', 'visible');
}

function addOption(parentElm, strText, strValue) {
	$(parentElm).append('<option value=\'' + strValue + '\'>' + strText + '</option>');
}

function removeOptions(parentElm, exceptVal) {
	$('option[value!=\'' + exceptVal + '\']', parentElm).remove();
}

/*****************************************************************************/
// NUMERIC INPUT
/*****************************************************************************/

function setNumericInput() {
	$('form :text').each(function() {
		if ($(this).hasClass('number')) {
			$(this).keypress(function(evt) {
				var charCode;
				charCode = (evt.charCode) ? evt.charCode : 
					((evt.which) ? evt.which : evt.keyCode);
				/*
				if ((charCode > 57) || ((charCode < 48) && (charCode != 45) && 
					(charCode != 44) && (charCode != 35) && (charCode != 36) && 
					(charCode != 37) && (charCode != 39) && (charCode != 8) && 
					(charCode != 46) && (charCode != 9)))
					evt.preventDefault();
				*/

				if (((charCode > 57) && ((charCode < 96) || (charCode > 105))) || 
				   ((charCode < 48) && (charCode != 45) && 
				   (charCode != 44) && (charCode != 35) && (charCode != 36) && 
				   (charCode != 37) && (charCode != 39) && (charCode != 8) && 
				   (charCode != 46) && (charCode != 9)))
				   evt.preventDefault();
   
			});
			$(this).keyup(function(evt) {
				var charCode, value;
				var rgxNol, rgxDot, rgxDoubleDelim, rgxNegative, rgxFormat;
				var arrSegment, stripIE;
			
				rgxNol = /^(-?)0+([0-9]+)$/
				rgxDot = /\./g
				rgxDoubleDelim = /(.*),(.*),(.*)/
				rgxNegative = /(.+)-(.*)/
				rgxFormat = /(-?\d+)(\d{3})/
				
				stripIE = (ieFlag) ? 189 : 109;
			
				charCode = (evt.charCode) ? evt.charCode : 
					((evt.which) ? evt.which : evt.keyCode);
				/*
				if (((charCode < 58) && (charCode > 43) && (charCode != 47)) 
					|| (charCode == 46) || (charCode == 8) || (charCode == 188) 
					|| (charCode == stripIE) || (charCode == 190)) {
				*/
				if (((charCode < 58) && (charCode > 43) && (charCode != 47)) 
				   || (charCode == 46) || (charCode == 8) || (charCode == 188) 
				   || (charCode == stripIE) || (charCode == 190) 
				   || ((charCode > 95) && (charCode < 106))) {				
					value = $(this).val().toString().replace(rgxDot, '');
	
					while (rgxDoubleDelim.test(value)) 
						value = value.replace(rgxDoubleDelim, '$1$2,$3');
	
					while (rgxNegative.test(value))
						value = value.replace(rgxNegative, '$1$2');
	
					arrSegment = value.split(',');
	
					value = arrSegment[0];
	
					while (rgxNol.test(value)) 
						value = value.replace(rgxNol, '$1$2');
	
					while (rgxFormat.test(value))
						value = value.replace(rgxFormat, '$1.$2');
	
					if (arrSegment.length > 1)
						value += ',' + arrSegment[1].toString().substring(0, 2);
	
					$(this).val(value);
				}

			});
		}
	});
}

function getFormatNum(value) {
	var arrSegments;
	var rgxNum = /(-?\d+)(\d{3})/
	var intValue;

	if (value.toString().replace(/^\s+|\s+$/g, '') == '')
		return '0,00';
	else {
		arrSegments = value.toString().split('.');

		if (arrSegments[0].toString().replace(/^\s+|\s+$/g, '') == '')
			arrSegments[0] = '0';

		intValue = arrSegments[0];

		while (rgxNum.test(intValue))
			intValue = intValue.replace(rgxNum, '$1.$2');

		if (arrSegments.length > 1)
			value = intValue + ',' + arrSegments[1];
		else
			value = intValue;

		return value;
	}
}

function roundNumber(number, decimals) {	
	var result = Math.round(number*Math.pow(10,decimals))/Math.pow(10,decimals);
	return result;
}

/*****************************************************************************/

function setCOAInput() {
	$('form:text').each(function() {
		if ($(this).hasClass('coa-number')) {
			$(this).keypress(function(evt) {
				var charCode;

				charCode = (evt.charCode) ? evt.charCode : 
					((evt.which) ? evt.which : evt.keyCode);
	
				if ((charCode > 57) || ((charCode < 48) && (charCode != 45) && 
					(charCode != 35) && (charCode != 36) && (charCode != 37) && 
					(charCode != 39) && (charCode != 8) && (charCode != 46) && 
					(charCode != 9)))
					evt.preventDefault();
			});
			
			$(this).keyup(function(evt) {

				var elem, charCode, value;
				var rgxNol, rgxDot, rgxDoubleDelim, rgxNegative, rgxFormat;
				var arrSegment, stripIE;
			
				rgxNol = /^(-?)0+([0-9]+)$/
				rgxDot = /\./g
				rgxDoubleDelim = /(.*),(.*),(.*)/
				rgxNegative = /(.+)-(.*)/
				rgxFormat = /(-?\d+)(\d{3})/
			
				stripIE = (ieFlag) ? 189 : 109;
			
				charCode = (evt.charCode) ? evt.charCode : 
					((evt.which) ? evt.which : evt.keyCode);
	
				if (((charCode < 58) && (charCode > 43) && (charCode != 47)) 
					|| (charCode == 46) || (charCode == 8) || (charCode == 188) 
					|| (charCode == stripIE) || (charCode == 190)) {
					value = elem.value.toString().replace(rgxDot, '');
	
					while (rgxDoubleDelim.test(value)) 
						value = value.replace(rgxDoubleDelim, '$1$2,$3');
	
					while (rgxNegative.test(value))
						value = value.replace(rgxNegative, '$1$2');
	
					arrSegment = value.split(',');
	
					value = arrSegment[0];
					/*
					while (rgxNol.test(value)) 
						value = value.replace(rgxNol, '$1$2');
					*/
					while (rgxFormat.test(value))
						value = value.replace(rgxFormat, '$1.$2');
	
					if (arrSegment.length > 1)
						value += ',' + arrSegment[1];
	
					elem.value = value;
				}
			
			});
		} 
	});
}

/*****************************************************************************/
// DATE
/*****************************************************************************/

function setToday(d ,m ,y, toDay) {
	d = document.getElementById(d);
	m = document.getElementById(m);
	y = document.getElementById(y);

	var now = new Date(); 
	var nowY = (now.getYear() % 100) + (((now.getYear() % 100) < 39) ? 2000 : 1900);

	//if the relevant year exists in the box, select it
	for (var x = 0; x < y.options.length; x++) { 
		if ((y.options[x].value == '' + nowY + '') && (toDay)) { 
			y.options[x].selected = true; 
			if (window.opera && document.importNode) { 
				if (y.id) window.setTimeout('document.getElementById(\'' + y.id + '\').options[' + x + '].selected = true;', 0); 
			} 
		}
	}
	
	//select the correct month, redo the days list to get the correct number, then select the relevant day
	if (toDay)
		m.options[now.getMonth()].selected = true; 

	dateChange(d.id, m.id, y.id);

	if (toDay) {
		d.options[now.getDate() - 1].selected = true;
		if (window.opera && document.importNode) { 
			if (d.name) window.setTimeout('document.getElementById(\'' + d.name + '\').options[' + (now.getDate() - 1) + '].selected = true;', 0); 
		}
	}
}

function dateChange(d, m, y) {
	d = document.getElementById(d);
	m = document.getElementById(m);
	y = document.getElementById(y);

	//work out if it is a leap year
	var IsLeap = parseInt(y.options[y.selectedIndex].value);
	IsLeap = !(IsLeap % 4) && ((IsLeap % 100) || !(IsLeap % 400));

	//find the number of days in that month
	IsLeap = [31, (IsLeap ? 29:28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][m.selectedIndex];

	//store the current day - reduce it if the new month does not have enough days
	var storedDate = (d.selectedIndex > IsLeap - 1) ? (IsLeap - 1) : d.selectedIndex;

	//empty days box then refill with correct number of days
	while (d.options.length) { 
		d.options[0] = null; 
	} 

	var tempFormat;

	for (var x = 0; x < IsLeap; x++) { 
		tempFormat = x + 1;
		tempFormat = (tempFormat < 10) ? '0' + tempFormat : tempFormat;
		d.options[x] = new Option(tempFormat, (x + 1)); 
	}

	d.options[storedDate].selected = true; //select the number that was selected before
	if (window.opera && document.importNode) { 
		if (d.id) window.setTimeout('document.getElementById(\'' + d.id + '\').options[' + storedDate + '].selected = true;', 0); 
	}
}

function setDate(id) {
	var d, m, y, selectedDate, oDFormat, oMFormat;

	d = document.getElementById(id + 'Day');
	m = document.getElementById(id + 'Month');
	y = document.getElementById(id + 'Year');
	selectedDate = document.getElementById(id);

	oDFormat = new ToFmt(d.value);
	oMFormat = new ToFmt(m.value);

	selectedDate.value = y.value + '-' + oMFormat.fmt00() + '-' + oDFormat.fmt00();
}

/*****************************************************************************/
// FORMATING
/*****************************************************************************/

// JS Object: ToFmt 
// Author: David Mosley, E-mail: David.Mosley@fundp.ac.be or davmos@fcmail.com
// August 1998.
// Contains a limited set of formatting routines for
// use in JavaScript scripts.
// Feel free to use this code in your scripts. I would be grateful if you
// could keep this header intact. 
// Please let me know if you find the code useful.
// Please report any bugs you find or improvements you make to the script. 
// The code has been tested, but no guarantee can be made of it functioning
// correctly. Use is entirely at your own risk.
// 
// Summary of methods
// fmt00(): Tags leading zero onto numbers 0 - 9.
// Particularly useful for displaying results from Date methods.
//
// fmtF(w,d): formats in a style similar to Fortran's Fw.d, where w is the
// width of the field and d is the number of figures after the decimal
// point. 
// The result is aligned to the right of the field.  The default
// padding character is a space " ". This can be modified using the 
// setSpacer(string) method of ToFmt. 
// If the result will not fit in the field , the field will be returned
// containing w asterisks.
//
// fmtE(w,d): formats in a style similar to Fortran's Ew.d, where w is the
// width of the field and d is the number of figures after the decimal
// point. 
// The result is aligned to the right of the field.  The default
// padding character is a space " ". This can be modified using the 
// setSpacer(string) method of ToFmt. 
// If the result will not fit in the field , the field will be returned
// containing w asterisks.
//
// fmtI(w): formats in a style similar to Fortran's Iw, where w is the
// width of the field.
// Floating point values are truncated (rounded down) for integer
// representation.
// The result is aligned to the right of the field.  The default
// padding character is a space " ". This can be modified using the 
// setSpacer(string) method of ToFmt. 
// If the result will not fit in the field , the field will be returned
// containing w asterisks.

function ToFmt(x) {
	this.x = x;
	this.fmt00 = fmt00;
	this.fmtF = fmtF;
	this.fmtE = fmtE;
	this.fmtI = fmtI;
	this.spacer = " ";
	this.setSpacer = setSpacer;
}

function fmt00() {
	// fmt00: Tags leading zero onto numbers 0 - 9.
	// Particularly useful for displaying results from Date methods.
	//
	if (parseInt(this.x) < 0) var neg = true;
	if (Math.abs(parseInt(this.x)) < 10) {
		this.x = "0"+ Math.abs(this.x);
	}
	
	if (neg) 
		this.x = "-" + this.x;
	return this.x;
}

function fmtF(w, d) {

	// fmtF: formats in a style similar to Fortran's Fw.d, where w is the
	// width of the field and d is the number of figures after the decimal
	// point. 
	// The result is aligned to the right of the field.  The default
	// padding character is a space " ". This can be modified using the 
	// setSpacer(string) method of ToFmt. 
	// If the result will not fit in the field , the field will be returned
	// containing w asterisks.
	
	var width = w;
	var dpls = d;
	var lt1 = false;
	var len = this.x.toString().length;
	var junk;
	var res = "";
	// First check for valid format request
	if (width < (dpls + 2)) {
		window.alert("Illegal format specified : w = " + d + " w = " + d + "\nUsage: [ToFmt].fmtF(w,d)" + "\nWidth (w) of field must be greater or equal to the number " + "\nof digits to the right of the decimal point (d) + 2");
		junk = filljunk(width);
		return junk;
	}
	
	// Work with absolute value
	var absx = Math.abs(this.x);
	// Nasty fix to deal with numbers < 1 and problems with leading zeros!
	if ((absx < 1) && (absx > 0)) {
		lt1 = true;
		absx += 10;
	}
	// Get postion of decimal point
	var pt_pos = absx.toString().indexOf(".");
	if (pt_pos == -1) {
		res += absx;
		res += ".";
		for (var i = 0; i < dpls; i++) {
			res += 0;
		}  
	} else {
		res = Math.round(absx * Math.pow(10, dpls));
		res = res.toString();
		if (res.length == Math.round(Math.floor(absx * Math.pow(10, dpls))).toString().length) { 
			res = res.substring(0, pt_pos) + "." + res.substring(pt_pos, res.length);
		} else {
			pt_pos++;
			res = res.substring(0, pt_pos) + "." + res.substring(pt_pos, res.length);
		} 

		// Remove leading 1 from  numbers < 1 (Nasty fix!)
		if (lt1) {
			res = res.substring(1, res.length);
		}
	}
 
	// Final formatting statements
	// Reinsert - sign for negative numbers
	if (this.x < 0) 
		res = "-" + res;
	// Check whether the result fits in the width of the field specified
	if (res.length > width) {
		res = filljunk(width);
	} else if (res.length < width) { // If necessary, pad from the left with the spacer string
		var res_bl = "";
		for (var i = 0; i < (width - res.length); i++) {
			res_bl += this.spacer;
		} 
		res = res_bl + res;
	}
	return res;
}

function fmtE(w, d) {

	// fmtE: formats in a style similar to Fortran's Ew.d, where w is the
	// width of the field and d is the number of figures after the decimal
	// point. 
	// The result is aligned to the right of the field.  The default
	// padding character is a space " ". This can be modified using the 
	// setSpacer(string) method of ToFmt. 
	// If the result will not fit in the field , the field will be returned
	// containing w asterisks.
	//
	var width = w;
	var dpls = d;
	var e = "E+";
	var len = this.x.toString().length;
	var pow10;
	var xp10;
	var junk;
	var res = "";
	// First check for valid format request
	if (width < (dpls + 5)) {
		window.alert("Illegal format specified : w = " + d + " w = " + d + "\nUsage: [ToFmt].fmtE(w,d)" + "\nWidth (w) of field must be greater or equal to the number " + "\nof digits to the right of the decimal point (d) + 6");
		junk = filljunk(w);
		return junk;
	}
	// Work with absolute value
	var absx = Math.abs(this.x);
	// Get postion of decimal point
	var pt_pos = absx.toString().indexOf(".");
	// For x=0
	if (absx == 0) {
		res += "0.";
		for (var i=0; i < dpls; i++) {
			res += "0";
		}
		res += "E+00";
	} else if (absx >= 1.0) { // For abs(x) >= 1 
		pow10 = 1;
		xp10 = absx;
		while (xp10 >= 1.) {
			pow10++;
			xp10 /= 10;
		}
		
		res = Math.round(xp10 * Math.pow(10, dpls));
		res = res.toString();
		if (res.length == Math.round(Math.floor(xp10 * Math.pow(10, dpls))).toString().length) {
			pow10--;
		}
		res = "0." + res.substring(0, dpls) + e + (new ToFmt(pow10)).fmt00();
	} else if (absx < 1.0) { // For abs(x) < 1
		pow10 = 1;
		xp10 = absx;
		while (xp10 < 1.) {
			pow10--;
			xp10 *= 10;
		}
		res = Math.round(xp10/10 * Math.pow(10, dpls));
		res = res.toString();
		if (res.length != Math.round(Math.floor(xp10/10 * Math.pow(10, dpls))).toString().length) {
			pow10++;
		}
		if (pow10 < 0) e = "E-";
		res = "0." + res.substring(0, dpls) + e + (new ToFmt(Math.abs(pow10))).fmt00();
	}
 
	if (this.x < 0) res = "-" + res;
	if (res.length > width) {
		res = filljunk(width);
	} else if (res.length < width) {
		var res_bl = "";
		for (var i = 0; i < (width - res.length); i++) {
			res_bl += this.spacer;
		} 
		res = res_bl + res;
	}
	return res;
}

function fmtI(w) {

	// fmtI: formats in a style similar to Fortran's Iw, where w is the
	// width of the field.
	// Floating point values are truncated (rounded down) for integer
	// representation.
	// The result is aligned to the right of the field.  The default
	// padding character is a space " ". This can be modified using the 
	// setSpacer(string) method of ToFmt. 
	// If the result will not fit in the field , the field will be returned
	// containing w asterisks.
	
	var width = w;
	var lt0 = false;
	var len = this.x.toString().length;
	var junk;
	var res = "";
	// Work with absolute value
	var absx = Math.abs(this.x);

	// Test for < 0
	if (parseInt(this.x) < 0) {
		lt0 = true;
	}
	res = Math.round(Math.floor((absx))).toString();
	if (lt0) {
		res = "-" + res;
	}
	if (res.length > width) {
		res = filljunk(width);
	} else if (res.length < width) {
		var res_bl = "";
		for (var i = 0; i < (width - res.length); i++) {
			res_bl += this.spacer ;
		} 
		res = res_bl + res;
	}
	return res;
}

function filljunk(lenf) {
	// Fills field of length lenf with asterisks
	var str = "";
	for (var i = 0; i < lenf; i++) {
		str += "*";
	}
	return str;
}

function setSpacer(spc) {
	var spc;
	this.spacer = spc;
	return this.spacer;
}


/*****************************************************************************/
// DateFormat, Showdate
/*****************************************************************************/

//-----------------------------------------------------------------------
//	--- Datetime.js
//	--- Copyright (c) 1997-2003, Draf Designs
//	--- http://drafdesigns.com	info@drafdesigns.com
//	--- Author: Demetrius Francis
//	--- EULA:	Freeware - ALL COPYRIGHT LINES MUST ACCOMPANY THE SCRIPT.
//	--- Revised: October 7, 2003
//-----------------------------------------------------------------------

/*

Javascript Function :: Showdate()

Syntax :

Showdate ( [date object|string], [day string], [month string], [date string], [year string], [delimeter string] )

Date	: - Javascript date object in the form new Date(), new Date(1982,06,30).

Day		: - Day string in the form "dddd" or "ddd".

Month	: - Month string in the form "mmmm", "mmm", "mm".

Date	: - Date string in the form "dddd", "ddd", "dd", "d".

Year	: - Year string in the form "yyyy", "yy".

Example 	Results
Showdate(new Date(), 'dddd', 'mmm', 'dd', 'yyyy', '-') 				Monday, May-05-2008
Showdate(new Date(), 'dd', 'mm', 'dd', 'yyyy', '.') 				0505.05.2008
Showdate(new Date(2001,11,25), 'dddd', 'mmm', 'dd', 'yy', ' ') 		Tuesday, Dec 25 01

*/

var aDay = new Array("Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jum'at", "Sabtu");
var aMonth	= new Array("Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember");

function DateFormat(xdate, x) {
	/*	
		Date Format function to be used in internally by the Showdate function.
		Returns either: d, dd, ddd, dddd, m, mm, mmm, mmmm, y, yy, yyy, yyyy.
		eg. Sun Sep 28 09:22:08 EDT 2003  returns  28, 28, Sun., Sunday, 9, 09, Sep., September, 03, 03, 03, 2003
			Sun Sep 28 09:22:08 EDT 2003 = 28 28 Sun. Sunday, 9 09 Sep. September, 03 03 03 2003   
	*/
	x = x.toLowerCase();
	return (((x == "d")  ? xdate.getDate() : ((x == "dd") ? ((xdate.getDate() <= 9) ? "0" + xdate.getDate() : xdate.getDate()) : ((x == "ddd") ? aDay[xdate.getDay()].substring(0, 3) + ". " : ((x == "dddd") ? aDay[xdate.getDay()] + ", " : ((x == "m")  ? xdate.getMonth() + 1 : ((x == "mm") ? (((xdate.getMonth() + 1) <= 9) ? "0" + (xdate.getMonth() + 1) : xdate.getMonth() + 1) : ((x == "mmm") ? aMonth[xdate.getMonth()].substring(0, 3) : ((x == "mmmm") ? aMonth[xdate.getMonth()] : ((x == "y" || x == "yy" || x == "yyy") ? xdate.getFullYear().toString().substring(2, 4) : ((x == "yyyy") ? xdate.getFullYear().toString() : "")))))))))));
}

function Showdate(_date, _var1, _var2, _var3, _var4, _del) {
	// ----------------------------------------------------------------------------------------
	// Title:	Showdate()
	// Author:	Draf Designs  draf@angelfire.com
	// Legal:	� 1998-2000, Draf Designs
	// EULA:	Open Source - These lines must always accompany this script 
	// ----------------------------------------------------------------------------------------
	// Content:	Date formatter where _month = month, _day = day of week spelled out, yyyy = four digit year. 
	// The script will only display a day spelled out if the parameter is ddd, or dddd. dd or d means do not display the day.
	//
	//	Syntax: document.writeln(Showdate(date object, "ddd", "mmm", "dd", "yyyy", "-"));
	//		where date can be a field variable = rs("Datecreated"); constant= new Date(yyyy,m,dd); 
	//
	//	Results in: Thursday, January-01-1970  NOTE that the numeric month in Javascript is from 0-11
	//
	// timerID=setInterval("if (_ie){++nd; if (nd > xStyle.length) nd=0; document.all.md.innerHTML=Showdate(null, "mmm", "ddd", "yy" , "-");}",3000)
	// timerOn=true
	// ----------------------------------------------------------------------------------------

	var today = (_date == null) ? new Date() : new Date(_date);
	_del = ((_del == null) ? " " : _del);
	return (DateFormat(today, _var1) + DateFormat(today, _var2) + ((_var2 != "")? _del : "") + DateFormat(today, _var3) + ((_var3 != "") ? _del : "") + DateFormat(today, _var4));
}
