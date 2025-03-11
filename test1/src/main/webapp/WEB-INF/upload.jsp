<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
        <title>시험 제출</title>
        <style>
            div {
                margin-top: 5px;
            }

            .ql-container {
                height: 80%;
            }
        </style>
    </head>
    <style>
    </style>

    <body>
        <div id="app">
            <input type="file" id="file1" name="file1" >
            <button @click="fnSave">파일 저장</button>
        </div>
    </body>

    </html>
    <script>
        const app = Vue.createApp({
            data() {
                return {

                };
            },
            methods: {
                fnSave() {
                    var self = this;
                    
                    if($("#file1")[0].files.length > 0){
                        var form = new FormData();                       
                        form.append("file1", $("#file1")[0].files[0]);
                        form.append("boardNo", "1234"); 
                        self.upload(form);
                        
                    } else {
                        alert("파일 첨부하셈");
                    }
                            
                 
                },              
                // 파일 업로드
                upload: function (form) {
                    var self = this;
                    $.ajax({
                        url: "/testUpload.dox"
                        , type: "POST"
                        , processData: false
                        , contentType: false
                        , data: form
                        , success: function (response) {
                            alert("ㅅㄱ");
                            location.href = "/result.do";
                        }
                    });
                }
            },
            mounted() {
                var self = this;
            }
        });
        app.mount('#app');
    </script>