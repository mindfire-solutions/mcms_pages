/*
 *   @File Name                 : pageFormAdmin.js
 *   @Company Name              : Mindfire Solutions Private Limited
 *   @Creator Name              : Vikram Kumar Mishra
 *   @Date Created              : 2012-06-08
 *   @Date Modified             : 2012-06-14
 *   @Last Modification Details : '' removed from css selectors
 *   @Purpose                   : To handle client side work for page form used by admin
 */

//bind the events to elts of the document when it is ready
$(document).ready(function(){

    //assigning DOM element in a variable
    var treeElement = $('.pages-tree .page-toggle');
    var textBox = $('#page_link_url');

    /*
     * @params   : None
     * @return   : None
     * @purpose  : initializing the functions call to bind events with DOM element
     */
    var initialize = function(){

        //function call to add tab
        showCurrentTab();

        //function call to toggle tree element on click event
        treeElement.live('click', toggleTree);

        //function call to find first and last li of tree
        findFirstLastLi();

        //function call to check length of value of textbox
        textBox.blur(validateValue);

    } // end initialize function


    /*
     * @params   : None
     * @return   : None
     * @purpose  : adding tab functionality like jquery tabs
     */
    var showCurrentTab = function(){

        //hiding all divs and then showing first div of tab content div
        $('.page-tabs div').hide();
        $('.page-tabs #page-part-form').show();
        $('.page-tabs #page-part-form #page-part-fields-0').show();
        $('.page-tabs #page-part-form #page-part-fields-0 div').show();
        $('.page-tabs ul li:first a').addClass('active');
        $('.page-tabs ul li:first').addClass('ui-tabs-selected');

        //assigning the DOM element in a variable
        var tabElt = $('.page-tabs ul li a');

        //function call to show/hide tab content for click event
        tabElt.click(toggleTab);

    } // end addTab function

    /*
     * @params   : None
     * @return   : None
     * @purpose  : function to show the tab content corresponding to the clicked link and hide others
     */
    var toggleTab = function(){

        //making all links inactive by removng the class attribute "active"
        $('.page-tabs ul li a').removeClass('active');
        $('.page-tabs ul li').removeClass('ui-tabs-selected');

        //activating the currently clicked link
        $(this).addClass('active');
		 $(this).parent('li').addClass('ui-tabs-selected');

        //finding the href of current link to identify the target div
        //because ID of target div is the href for the link
        var currentTabDiv = $(this).attr('id');

        //hide all child divs
        $('.page-tabs div').hide();

        //showing the specific div to display the target tab element
        $(currentTabDiv).parent().show();
        $(currentTabDiv).show();
        $(currentTabDiv+' div').show();

    } // end toggleTab function

    /*
     * @params   : Object
     * @return   : None
     * @purpose  : function to show and hide pages tree
     */
    var toggleTree = function(e){

        //If this method is called,
        //the default action of the event will not be triggered.
        e.preventDefault();

        //assigning the first li DOM element in a variable
        var liElt   = $(this).parents('li:first');

        //assigning the DOM element with classes page-icon, page-toggle in a variable
        var iconElt = liElt.find('.page-icon.page-toggle');

        //assigning the DOM element with classes page-nested in a variable
        var nestedElt = liElt.find('.page-nested');

        // if node with child is expanded, i.e. node with child is having
        // the class  'page-expanded'
        if (iconElt.hasClass('page-expanded')) {

            //remove the class page-expanded
            iconElt.removeClass('page-expanded');

            //and slide up the child nodes, i.e. hide child nodes
            nestedElt.slideUp();

        } // end if block

        // if node with child is not expanded, i.e. node with child is not having
        // the class  'page-expanded'
        else {

          //asign the data-ajax-content url to a variable to retrieve the data
          var contentUrl = nestedElt.attr('data-ajax-content');

          //add the class page-loading to show the loading image
          liElt.addClass('page-loading');

          //retrieve child pages through ajax call from content url
          nestedElt.load(contentUrl, function() {

             //find last li of child element and add the class page-branch-end
             //nestedElt.find('li:last').addClass('pages-tree-end');
             $('#pages-records.pages-tree #page-sortable-list li:last-child').addClass('pages-tree-end');

             nestedElt.find('li:last').addClass('pages-tree-end');

             //check of ul have more than one li as siblings
             if(nestedElt.find('li:first').next().prop('tagName') != 'LI')
             {
                 //if not then add class pages-tree-end to first li element of nested element of tree
                 nestedElt.find('li:first').addClass('pages-tree-end');

             } // end if

             //add class page-expanded to span with class page-icon and page-toggle
             iconElt.addClass('page-expanded');

             //show the child elements by sliding down
             nestedElt.slideDown();

             //remove the loading class as the content is loaded
             liElt.removeClass('page-loading');

          }); // end load method

        } //end else block

    } // end toggleTree function

    /*
     * @params   : None
     * @return   : None
     * @purpose  : function to find first and last li element and add class pages-tree-start to it
     */
    var findFirstLastLi = function(){

        //adding class pages-tree-start to first li element of tree
        $('#pages-records.pages-tree #page-sortable-list').find('li:first').addClass('pages-tree-start');

        //adding class pages-tree-end to last li element of tree
        $('#pages-records.pages-tree #page-sortable-list li:last-child').addClass('pages-tree-end');

        //assigning the DOM element with classes page-nested in a variable
        var nestedElt = $('#pages-records.pages-tree #page-sortable-list li .page-nested');

        //check of ul have more than one li as siblings
        if(nestedElt.find('li').next().prop('tagName') != 'LI')
        {

            //if not then add class pages-tree-end to first li element of nested element of tree
            nestedElt.find('li:first').addClass('pages-tree-end');

        } // end if

        //adding class pages-tree-end to last li element of nested element of tree
        $('.page-nested').find('li:last').addClass('pages-tree-end');

    } // end findFirstLi function

    /*
     * @params   : None
     * @return   : None
     * @purpose  : function to validate link_url value
     */
    var validateValue = function(e){

        // if user has something in text box then test it
        if($(this).val().length > 0){

            // if entered value matches the pattern of regular expression
            if(/(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/.test($(this).val())){

                // return true
                return true;

            } else {

                // give a alert message and return false
                alert("invalid URL");
                return false;
            } // end inner if

        } // end outer if

    }; // end function

    //function call to initialize all the methods required when document is ready
    initialize();

}); //end ready function

