<template>
    <div>
        <div v-if="file"  @click="browseFile('#' + COMPONENT_ID)">
            <h5 class="font-size-14 mb-1"><a class="text-dark" href="javascript:void(0);">
                {{ file_tickets.original_name }}</a>
                <input @change="upload()" style="position:fixed; top:-100px; left:-100px; opacity:0;" :id="COMPONENT_ID" type="file">
            </h5>
            <small>{{ humanFileSize(file.size) }}</small>
        </div>
        <div v-if="!file"  @click="browseFile('#' + COMPONENT_ID)">
            <h5 class="font-size-14 mb-1">
                <a class="text-dark" href="javascript:void(0);">{{ placeholder }}</a>
                <input @change="upload()" style="position:fixed; top:-100px; left:-100px; opacity:0;" :id="COMPONENT_ID" type="file">
            </h5>
            <small>Click to Upload</small>
        </div>
    </div>
</template>



<script>
export default {
    name: 'file-uploader',
    props: ['properties'],
    data: function () {
        return {
            COMPONENT_ID: '',
            file: null,
            upload_url: '',
            placeholder: 'Attach your File (Optional)',
            editable: true
        }
    },
    components: {
        
    },
    computed: {
        
    },
    methods: {
         browseFile: function(el) {
            var scope = this
            if (!scope.editable) {
                return
            }
            $(el).trigger('click');
        },
        upload: function () {
            var scope = this

            var UPLOAD_URL = scope.upload_url
            
            var file = $(document).find("#" + scope.COMPONENT_ID ).get(0).files[0];
            if(!file){ return; }
            
            var reader = new FileReader();
            
            // $(".file-tickets-placeholder").html('Uploading ' + file.name);
            
            var formData = new FormData();
            formData.append('file', file);
            formData.append('user_id', scope.user_id);

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
                url: UPLOAD_URL,
                enctype: 'multipart/form-data',
                processData: false,  // tell jQuery not to process the data
                contentType: false,  // tell jQuery not to set contentType
                headers: scope.headers,
                data:  formData,
                success: function (res) {
                    // $(".file-tickets-placeholder").html('Tickets: ' + file.name);
                    scope.file = res.data
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
    },
    mounted() {
        var scope = this
        scope.COMPONENT_ID = 'file-' + scope.UNIQUE();
    }
}
</script>
