tinymce.PluginManager.add('wordcomment', function(editor, url) {
	/*
	
	editor.addMenuItem('wordcomment', {
		text: 'Comments',
		context: 'tools',
		onclick: function() {   }
	});
	
	*/
	
	var $wrapper;
	
	var user_id;
	var user_name;
	
	var $wordcomment;
	var wordcomment_id;
	
	var wordcomments = {};
	
	var wordcomments_render = function(){
		//
		if(!$wrapper_sb){
			return;
		}
		
		//
		if(!wordcomment_id){
			$wrapper_sb.find('.wordcomment-sb-comments').html('');
			return;
		}
		
		var comments = wordcomments[wordcomment_id];
		if(!comments){
			$wrapper_sb.find('.wordcomment-sb-comments').html('');
			return;
		}
		
		$wrapper_sb.find('.wordcomment-sb-comments').html('');
		
		// render comments
		for(var i in comments){
			
			var comment_ = comments[i];
			
			(function(comment_id, comment){
				if(comment.is_deleted){
					return;
				}
				
				var html = '';
				html += '<div style="border: 1px solid #fafafa; padding: 5px; margin-bottom: 5px; position: relative;">';
				html += '	<div style="float: left; width: 100%;">';
				html += '		<div style="float: left; width: 32px; height: 32px; line-height: 32px; text-align: center; border-radius: 50%; overflow: hidden; background: #fff; line-height: 32px; border: 1px solid #333; margin-right: 5px;">'+comment.user_id+'</div>';
				html += '		<div style="float: left;">';
				html += '			<div style="float: left; font-weight: bold;">'+comment.user_name+'</div>';
				html += '			<div style="float: left; width: 100%;" data-wordcomment-time="'+comment.created_at+'"></div>';
				html += '		</div>';
				html += '	</div>';
				html += '	<div class="wc-the-message" style="clear: both; padding: 5px 0; white-space: normal;"></div>';
				
				if(user_id==comment.user_id){
				html += '	<div class="c-pop-menu-btn" style="position: absolute; top: 5px; right: 5px; border: 0 solid #c0c0c0;"><div style="text-align: right; border-radius: 2px; padding: 0; font-weight: bold; cursor: pointer;">...</div>';
				html += '		<div class="c-pop-menu" style="display: none; background: #000; border: 1px solid #000; padding: 3px; border-radius: 3px; margin-top: -1px;">';
				html += '			<div data-c-pop-menu-action="edit" style="text-align: center; color: #fff; font-weight: normal; cursor: pointer;">edit</div>';
				html += '			<div data-c-pop-menu-action="delete" style="text-align: center; color: #fff; font-weight: normal; cursor: pointer;">delete</div>';
				html += '		</div>';
				html += '	</div>';
				}
				
				html += '</div>';
				
				var $el = $(html);
				
				$el.find('.wc-the-message').text(comment.message);
				
				
				// comment actions
				$el.find('[data-c-pop-menu-action]').click(function(){
					var action = $(this).data('c-pop-menu-action');
					
					// delete
					if(action == 'delete'){
						if(confirm('Are you sure?')){
							wordcomments[wordcomment_id][comment_id].is_deleted = 1;
							var c = 0;
							for(var kk in wordcomments[wordcomment_id]){
								c++;
							}
							if(c == 0){
								$wordcomment.removeClass('wordcomment');
								$wordcomment.removeAttr('data-wordcomment-id');
								wordcomments[wordcomment_id] = [];
							}
							wordcomments_render();
						}
						
					// edit
					}else if(action == 'edit'){
						$modal = $(
						 '<div class="c-pop-modal-comment-edit" style="width: 100%;	height: 100%; position: fixed; top: 0; left: 0; background: rgba(0,0,0,0.2);">'
						+'	<div style="width: 600px; max-width: 90%; margin: auto;">'
						+'		<textarea class="c-pop-modal-comment-edit-message" style="width: 100%; min-height: 200px; margin-top: 50px;"></textarea>'
						+'		<div style="text-align: right;">'
						+'			<button class="c-pop-modal-comment-edit-save" style="background: blue; color: #fff; padding: 5px 10px; border: none;">Save</button>'
						+'			<button class="c-pop-modal-comment-edit-cancel" style="background: #fff; color: #000; padding: 5px 10px; border: none;">Cancel</button>'
						+'		</div>'
						+'	</div>'
						+'</div>');
						
						$modal.find('.c-pop-modal-comment-edit-message').val(wordcomments[wordcomment_id][comment_id].message);
						
						$('body').append($modal);
						
						$modal.find('.c-pop-modal-comment-edit-message').focus();
						
						$modal.find('.c-pop-modal-comment-edit-save').click(function(){
							var msg = $modal.find('.c-pop-modal-comment-edit-message').val();
							wordcomments[wordcomment_id][comment_id].message = msg;
							wordcomments[wordcomment_id][comment_id].updated_at = new Date().getTime();
							wordcomments_render();
							$modal.remove();
						});
						
						$modal.find('.c-pop-modal-comment-edit-cancel').click(function(){
							$modal.remove();
						});
					}
					//
					
				});
				
				$wrapper_sb.find('.wordcomment-sb-comments').append($el);
			})(i, comment_);
		}
		
	};
	
	
	// the dropdown menu of actions for each comment
	$(document).on('click', '.c-pop-menu-btn', function(){
		var is_hidden = !$(this).find('.c-pop-menu').is(':visible');
		$('.c-pop-menu').hide();
		if(is_hidden){
			$(this).find('.c-pop-menu').show();
		}

	});
	
	
	// time updater for each comment
	var t_u = setInterval(function(){
		$('[data-wordcomment-time]').each(function(){
			var t = $(this).data('wordcomment-time');
			
			var txt = moment(t).fromNow();
			txt = txt.replace('a few seconds ago', 'just now');
			
			$(this).html(txt);
		});
	}, 1000);
	
	//
	var is_sidebar_open = false;
	
	var sidebar_open = function(){
		if(!is_sidebar_open){
			editor.dom.$('body').addClass('wordcomment-show');
			$wrapper_sb.show();
			$wrapper_sb.addClass('sidebar-open');
			$wrapper.find('[aria-label="Comments Sidebar"] button').click();
			is_sidebar_open = true;
		}
	};
	
	var sidebar_close = function(){
		if(is_sidebar_open){
			editor.dom.$('body').removeClass('wordcomment-show');
			$wrapper_sb.hide();
			$wrapper_sb.removeClass('sidebar-open');
			$wrapper.find('[aria-label="Comments Sidebar"] button').click();
			is_sidebar_open = false;
		}
	};
	
	var sidebar_toggle = function(){
		if(is_sidebar_open){
			sidebar_close();
		}else{
			sidebar_open();
		}
	};
	
	//
	editor.addButton('wordcomment', {
		text: 'Comments',
		icon: false,
		onclick: function() {
			sidebar_toggle();
		}
	});
	
	//
	$wrapper_sb = $('<div></div>');
	
	var sb_render = function(){
		var html =  '';
		html += '<div style="padding: 5px;">';
		html += '	<div class="wordcomment-sb-comments"></div><br/>';
		html += '	<textarea class="wordcomment-sb-comment-message" style="width: 100%; border: 1px solid #ccc;"></textarea><br/><br/>';
		html += '	<div style="text-align: right;"><button class="wordcomment-sb-comment-submit" style="background: blue; color: #fff; padding: 5px 10px;">Submit</button></div>';
		html += '</div>';
		$wrapper_sb.html(html);
		
		// add a comment
		$wrapper_sb.find('.wordcomment-sb-comment-submit').click(function(){
			var message = $.trim($wrapper_sb.find('.wordcomment-sb-comment-message').val());
			
			//
			if(message == ''){
				return;
			}
			
			// create new comment
			if(!wordcomment_id){
				wordcomment_id = (Math.random()+'').replace('0.','wc-');
				editor.formatter.apply('wordcomment_format', { id: wordcomment_id});
				$wordcomment = $($('[data-wordcomment-id="'+wordcomment_id+'"]')[0]);
			}
			
			// initialize comment array
			if(!wordcomments[wordcomment_id]){
				wordcomments[wordcomment_id] = JSON.parse('{}');
			}
			
			// push comment object
			var k = 'c-'+new Date().getTime()+'-'+(Math.random()+'').replace('0.','');
			
			wordcomments[wordcomment_id][k] = {
				user_id: user_id,
				user_name: user_name,
				created_at: new Date().getTime(),
				message: message
			};
			
			//
			$wrapper_sb.find('.wordcomment-sb-comment-message').val('');
			wordcomments_render();
		});
		
		//
		
		
	};
	
	//
	if(!editor.settings.wordcomments_sidebar){
		editor.addSidebar('wordcomment-sb', {
			tooltip: 'Comments Sidebar',
			icon: 'settings',
			onrender: function (api) {
				$wrapper_sb = $(api.element());
				sb_render();
			},
			onshow: function (api) {
				
			},
			onhide: function (api) {
				
			}
		});
	}
	
	//
	editor.on('init', function() {
		//
		$wrapper = $(editor.editorContainer);
		
		// add stylesheet
		var cssId = editor.dom.uniqueId();
		
		var linkElm = editor.dom.create('link', {
			id: cssId,
			rel: 'stylesheet',
			href: url + '/styles.css'
		});
		
		editor.getDoc().getElementsByTagName('head')[0].appendChild(linkElm);
		
		// register the formatter
		editor.formatter.register('wordcomment_format', { inline: 'span', attributes: {'data-wordcomment-id': '%id'}, classes: 'wordcomment', exact: !true });
		
		
		//
		if(editor.settings.wordcomments_sidebar){
			$wrapper_sb = $(editor.settings.wordcomments_sidebar);
			sb_render();
		}
		
		if(editor.settings.wordcomments_sidebar_open_default){
			sidebar_open();
		}
		
		//
		
		
		/*
		editor.on('mouseup', function (e) {
			if($(e.target).is('.wordcomment')){
				console.log('Element mouseup:', e.target);
			}
		});
		
		
		editor.on('mousedown', function (e) {
			if($(e.target).is('.wordcomment')){
				console.log('Element mousedown:', e.target);
			}
		});
		*/
		
		// detect which existing word with comments is clicked
		editor.on('mouseup', function (e) {
			var $el = null;
			
			if($(e.target).is('.wordcomment')){
				$el = $(e.target);
			}else if($(e.target).closest('.wordcomment').length > 0){
				$el = $($(e.target).closest('.wordcomment')[0]);
			}
			
			if($el){
				console.log('Element click:', $el);
				$wordcomment = $el;
				wordcomment_id = $el.attr('data-wordcomment-id');
			}else{
				$wordcomment = null;
				wordcomment_id = null;
			}
			
			wordcomments_render();
		});
		
		//
		
	});
	
	
	// 
	
	editor.setUserId = function(v){
		user_id = v;
	};
	
	editor.setUserName = function(v){
		user_name = v;
	};
	
	editor.getCommentsJSON = function(){
		return JSON.stringify(wordcomments);
	};
	
	editor.setCommentsJSON = function(str){
		var obj = JSON.parse(str);
		wordcomments = obj;
	};

	return {
		getMetadata: function () {
			return  {
				name: "Word Comment",
				//url: "http://www.example.com"
			};
		}
	};
});