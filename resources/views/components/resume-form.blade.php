<style>
    .form-group { margin-bottom:15px; }
    .form-group > strong { display:block; }
    .form-group .form-control { margin-top:5px; width:100%; height:50px; line-height:50px; border:1px solid #ccc; padding:0px 10px; }

    .file-uploader { cursor:pointer; position:relative;  padding:5px; padding-top:20px; padding-left:80px; height:70px;  border:1px solid #efefef; }
    .file-uploader .icon { background:#efefef; position:absolute; top:5px; left:5px; width:60px; height:60px; text-align:center; font-size:30px; padding:8px 0px; color:#ccc; }
    .file-uploader.has-file  { background:#d5faf3; }
    .file-uploader.has-file  .icon{ background:#3febca; color:#fff; }

</style>

    
<script>
    Vue.component('resume-form', {
        data: function () {
            return {
                error: false,
                avatar: '/images/worker-placeholder.jpg',
                file_resume: null,
                file_tickets: null,
                formdata: {
                    first_name: '',
                    last_name: '',
                    email: '',
                    phone: '',
                    date_available: '',
                    location: '',
                    content: '',
                },
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Authorization': 'Bearer ' + localStorage.getItem('KX-PRIMUS')
                },
            }
        },
        methods: {
             previewFile: function(){
                var scope = this
                var file = $("#avatar-browser").get(0).files[0];
                if(file){
                    var reader = new FileReader();
                    reader.onload = function(){
                        $("#avatar-preview").attr("src", reader.result);
                    }
                    reader.readAsDataURL(file);
                    scope.startUploadAvatar(file);
                }
            },
            startUploadAvatar: function (file) {
                var scope = this
                var avatar = file

                var formData = new FormData();
                formData.append('file', avatar);

                scope.error = false
                
                $.ajax({
                    xhr: function () {
                        var xhr = new window.XMLHttpRequest();
                        xhr.upload.addEventListener("progress", function (evt) {
                            if (evt.lengthComputable) {
                                var percentComplete = evt.loaded / evt.total;
                                console.log(percentComplete);
                                $('.progress').css({
                                    width: percentComplete * 100 + '%'
                                });
                                if (percentComplete === 1) {
                                    $('.progress').addClass('hide');
                                }
                            }
                        }, false);
                        xhr.addEventListener("progress", function (evt) {
                            if (evt.lengthComputable) {
                                var percentComplete = evt.loaded / evt.total;
                                console.log(percentComplete);
                                $('.progress').css({
                                    width: percentComplete * 100 + '%'
                                });
                            }
                        }, false);
                        return xhr;
                    },
                    type: 'POST',
                    url: "/api/users/resume/avatar",
                    enctype: 'multipart/form-data',
                    processData: false,  // tell jQuery not to process the data
                    contentType: false,  // tell jQuery not to set contentType
                    headers: scope.headers,
                    data:  formData,
                    success: function (res) {
                        alert(res.message)
                    },
                    error: function(res) {
                        
                        var response = res.responseJSON
                        response.code = res.status

                        scope.error = response.message

                        $('html, body').animate({
                            scrollTop: $(document).find("#resume-error").offset().top - 70
                        }, 500);
                    }
                });
            },
            startUploadResume: function () {
                var scope = this
                
                var file = $("#file-resume-browser").get(0).files[0];
                if(!file){ return; }
                
                var reader = new FileReader();
               
                $(".file-resume-placeholder").html('Uploading ' + file.name);
                
                var formData = new FormData();
                formData.append('file', file);
                
                scope.error = false

                $.ajax({
                    xhr: function () {
                        var xhr = new window.XMLHttpRequest();
                        xhr.upload.addEventListener("progress", function (evt) {
                            if (evt.lengthComputable) {
                                var percentComplete = evt.loaded / evt.total;
                                console.log(percentComplete);
                                $('.progress').css({
                                    width: percentComplete * 100 + '%'
                                });
                                if (percentComplete === 1) {
                                    $('.progress').addClass('hide');
                                }
                            }
                        }, false);
                        xhr.addEventListener("progress", function (evt) {
                            if (evt.lengthComputable) {
                                var percentComplete = evt.loaded / evt.total;
                                console.log(percentComplete);
                                $('.progress').css({
                                    width: percentComplete * 100 + '%'
                                });
                            }
                        }, false);
                        return xhr;
                    },
                    type: 'POST',
                    url: "/api/users/resume/upload-resume",
                    enctype: 'multipart/form-data',
                    processData: false,  // tell jQuery not to process the data
                    contentType: false,  // tell jQuery not to set contentType
                    headers: scope.headers,
                    data:  formData,
                    success: function (res) {
                        $(".file-resume-placeholder").html('Resume: ' + file.name);
                        scope.file_resume = res.data
                    },
                    error: function(res) {
                        
                        var response = res.responseJSON
                        response.code = res.status

                        scope.error = response.message

                        $('html, body').animate({
                            scrollTop: $(document).find("#resume-error").offset().top - 70
                        }, 500);
                    }
                });
            },
            startUploadTickets: function () {
                var scope = this
                
                var file = $("#file-tickets-browser").get(0).files[0];
                if(!file){ return; }
                
                var reader = new FileReader();
               
                $(".file-tickets-placeholder").html('Uploading ' + file.name);
                
                var formData = new FormData();
                formData.append('file', file);
                
                scope.error = false

                $.ajax({
                    xhr: function () {
                        var xhr = new window.XMLHttpRequest();
                        xhr.upload.addEventListener("progress", function (evt) {
                            if (evt.lengthComputable) {
                                var percentComplete = evt.loaded / evt.total;
                                console.log(percentComplete);
                                $('.progress').css({
                                    width: percentComplete * 100 + '%'
                                });
                                if (percentComplete === 1) {
                                    $('.progress').addClass('hide');
                                }
                            }
                        }, false);
                        xhr.addEventListener("progress", function (evt) {
                            if (evt.lengthComputable) {
                                var percentComplete = evt.loaded / evt.total;
                                console.log(percentComplete);
                                $('.progress').css({
                                    width: percentComplete * 100 + '%'
                                });
                            }
                        }, false);
                        return xhr;
                    },
                    type: 'POST',
                    url: "/api/users/resume/upload-tickets",
                    enctype: 'multipart/form-data',
                    processData: false,  // tell jQuery not to process the data
                    contentType: false,  // tell jQuery not to set contentType
                    headers: scope.headers,
                    data:  formData,
                    success: function (res) {
                        $(".file-tickets-placeholder").html('Tickets: ' + file.name);
                        scope.file_tickets = res.data
                    },
                    error: function(res) {
                        
                        var response = res.responseJSON
                        response.code = res.status

                        scope.error = response.message

                        $('html, body').animate({
                            scrollTop: $(document).find("#resume-error").offset().top - 70
                        }, 500);
                    }
                });
            },
            browseFile: function(el) {
                $(el).trigger('click');
            },
            getResume: function () {
                var scope = this
                $.ajax({
                    url: "/api/users/resume",
                    type: "GET",
                    headers: scope.headers,
                    success: function (response) {
                        if (response.success) {
                            scope.formdata = response.data
                            scope.avatar = ( response.data.avatar) ? response.data.avatar : scope.avatar 
                            scope.file_resume = ( response.data.file_resume) ? response.data.file_resume : null
                            scope.file_tickets = ( response.data.file_tickets) ? response.data.file_tickets : null
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log(textStatus, errorThrown);
                    }
                });
            },
            submitForm: function() {
                var scope = this
                scope.error = false
                $.ajax({
                    url: "/api/users/resume",
                    type: "POST",
                    data: scope.formdata,
                    headers: scope.headers,
                    success: function (response) {

                        location.href = '/resume'
                    },
                    error: function(res) {
                        
                        var response = res.responseJSON
                        response.code = res.status

                        scope.error = response.message

                        $('html, body').animate({
                            scrollTop: $(document).find("#resume-error").offset().top - 70
                        }, 500);
                    }
                });
            }
        },
        mounted() {
            var scope = this
            scope.getResume()
        },
        template: `
        <div>
            <div id="resume-error">
                <div v-if="error" class="alert alert-danger">@{{ error }}</div>
            </div>
            <div @click="browseFile('#avatar-browser')" style="margin-bottom:30px; position:relative; width:150px; cursor:pointer; ">
                <img id="avatar-preview" :src="avatar" style="width:150px; height:150px; margin-right:20px; border:1px solid #efefef;">
                <input @change="previewFile()" style="position:fixed; top:-100px; left:-100px; opacity:0;" id="avatar-browser" type="file">
                <div style="position:absolute; bottom:0px; left:0px; width:100%; border:1px solid #efefef; border-top:none; background:rgba(0,0,0,0.7); color:#fff; text-align:center;">Change Avatar</div>
                <div style="display:none; position:absolute; bottom:0px; left:0px; width:100%;height:24px; background:green; color:#fff;"></div>
            </div>

            <div class="form-group" >
                <strong>Your First Name*</strong>
                <input v-model="formdata.first_name" class="form-control" type="text">
            </div>
            <div class="form-group" >
                <strong>Your Last Name*</strong>
                <input v-model="formdata.last_name" class="form-control" type="text">
            </div>
            <div class="form-group" >
                <strong>Your Email*</strong>
                <input v-model="formdata.email" class="form-control" type="text">
            </div>
            <div class="form-group" >
                <strong>Your Phone *</strong>
                <input v-model="formdata.phone" class="form-control" type="text">
            </div>
            <div class="form-group" >
                <strong>Date Available*</strong>
                <input v-model="formdata.date_available" class="form-control" type="text">
            </div>
            <div class="form-group" >
                <strong>Location*</strong>
                <input v-model="formdata.location" class="form-control" type="text">
            </div>
            <div class="form-group" >
                <strong>Resume Content (Optional)</strong>
                <textarea v-model="formdata.content" style="width:100%; padding:5px 10px; border:1px solid #ccc;" rows="5" type="text"></textarea>
            </div>

            
            <div class="row" >
                <div class="col-12 col-md-6" >
                    <div class="form-group" >
                        <div v-bind:class="{'has-file' : file_resume}" class="file-uploader" @click="browseFile('#file-resume-browser')">
                            <input @change="startUploadResume()" style="position:fixed; top:-100px; left:-100px; opacity:0;" id="file-resume-browser" type="file">
                            <div class="icon"><i class="las la-address-card"></i></div>
                            <span v-if="!file_resume" class="file-resume-placeholder">Attach Resume (optional)</span>
                            <span v-else class="file-resume-placeholder"><strong>Resume:</strong> @{{ file_resume.original_name }}</span>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6" >
                    <div class="form-group">
                        <div v-bind:class="{'has-file' : file_tickets}" class="file-uploader" @click="browseFile('#file-tickets-browser')">
                            <input @change="startUploadTickets()" style="position:fixed; top:-100px; left:-100px; opacity:0;" id="file-tickets-browser" type="file">
                            <div class="icon"><i class="las la-file-alt"></i></div>
                            <span v-if="!file_tickets"  class="file-tickets-placeholder">Upload Tickets Here (optional)</span>
                            <span v-else class="file-tickets-placeholder"><strong>Tickets:</strong> @{{ file_tickets.original_name }}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group" >
                <strong>Tickets and Credentials </strong>
                <button style="cursor:pointer; background:#efefef; border:1px solid #ccc; color:#404040; padding:5px 20px;">Browse</button>
            </div>

            
            <hr/>
            <button style="background:#f58220; border:1px solid #f58220; color:#fff; padding:8px 30px; font-size:20px;" @click="submitForm()">Submit</button>
        </div>`
    })
</script>