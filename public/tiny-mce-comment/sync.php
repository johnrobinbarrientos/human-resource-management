<?php
// get from post data
$html = $_POST['html'];

// get from database
$comments_json_current = file_get_contents('comments.json');

// get from post data
$comments_json_new = $_POST['comments_json'];

// get from session or the current logged in user
$user_id = 1;
$user_name = 'John Doe';

//========================================================

//
$comments_arr = json_decode($comments_json_current, 1);
$comments_new = json_decode($comments_json_new, 1);

//
foreach($comments_new as $k=>$c){
	foreach($comments_new[$k] as $i=>$c2){
		// an existing comment
		if(isset($comments_arr[$k][$i])){
			// allow edit / delete only if owner
			if($user_id == $comments_arr[$k][$i]['user_id']){
				if(!empty($comments_new[$k][$i]['is_deleted'])){
					unset($comments_arr[$k][$i]);
				}else{
					$comments_arr[$k][$i] = $comments_new[$k][$i];
					$comments_arr[$k][$i]['user_id'] = $user_id;
					$comments_arr[$k][$i]['user_name'] = $user_name;
				}
			}
		// a new comment
		}else{
			if(!empty($comments_new[$k][$i]['is_deleted'])){
				continue;
			}
			$comments_new[$k][$i]['user_id'] = $user_id;
			$comments_new[$k][$i]['user_name'] = $user_name;
			$comments_arr[$k][$i] = $comments_new[$k][$i];
		}
		
		//
		if(empty($comments_arr[$k])){
			unset($comments_arr[$k]);
		}
	}
}

// check html to get rid of non-existing $comments_arr instance by key
foreach($comments_arr as $k=>$c){
	if(strpos($html, $k.'') === false){
		$comments_arr[$k] = [];
		unset($comments_arr[$k]);
	}
}

//========================================================

// save this to database
$comments_json = json_encode($comments_arr);
file_put_contents('comments.json', $comments_json);

file_put_contents('comments.html', $html);

//========================================================
echo json_encode($comments_arr);

