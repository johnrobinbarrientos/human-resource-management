<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="tinymce/js/tinymce/tinymce.js" referrerpolicy="origin"></script>
    <script src="moment.min.js"></script>
	
</head>
	
<body>

<textarea id="full-featured"></textarea>

<br/>
<br/>

<button id="submit">Submit</button>

<div id="sidebar" style="position: fixed; top: 0; right: 0; height: 100%; width: 200px; max-width: 80%; border-left: 1px solid #c0c0c0; background: #fff; padding: 10px; display: none;"></div>

<script>
tinymce.init({
	selector: 'textarea#full-featured',
	plugins: 'wordcomment',
	mobile: {
		plugins: 'wordcomment'
	},
	menubar: 'file edit view insert format tools table tc help',
	toolbar: 'wordcomment | undo redo | bold italic underline strikethrough | fontselect fontsizeselect formatselect | alignleft aligncenter alignright alignjustify | outdent indent |  numlist bullist checklist | forecolor backcolor casechange permanentpen formatpainter removeformat | pagebreak | charmap emoticons | fullscreen  preview save print | insertfile image media pageembed template link anchor codesample | a11ycheck ltr rtl | showcomments addcomment',
	importcss_append: true,
	height: 400,
	readonly : 0,
	//wordcomments_sidebar: '#sidebar',
	wordcomments_sidebar_open_default: true,
	setup: function (editor) {
		editor.on('init', function () {
			editor.setUserId(1);
			editor.setUserName('John Doe');
			editor.setContent(<?php echo json_encode(file_get_contents('comments.html'));?>);
			editor.setCommentsJSON(<?php echo json_encode(file_get_contents('comments.json'));?>);
			
			$('#submit').click(function(){
				console.log('content', editor.getContent());
				console.log('comments', editor.getCommentsJSON());
				
				$.ajax({
					url: 'sync.php',
					data: {
						html: editor.getContent(),
						comments_json: editor.getCommentsJSON()
					},
					type: 'post',
					dataType: 'json',
					success: function(response){
						console.log('response');
						console.log(response);
						alert('Successfully saved!');
					}
				});
			});
		});
	}
});
</script>

</body>
</html>
