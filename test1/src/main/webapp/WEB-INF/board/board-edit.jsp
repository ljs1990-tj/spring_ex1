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
        <title>첫번째 페이지</title>
        <style>
            div {
                margin-top: 5px;
            }
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
            <div> 제목 : <input v-model="info.title"> </div>
            <div style="width: 500px; height: 300px;">
                <div id="editor"></div>
            </div>
            <div>
                <button @click="fnEdit">저장</button>
            </div>
        </div>
    </body>

    </html>
    <script>
        const app = Vue.createApp({
            data() {
                return {
                    boardNo: "${map.boardNo}",
                    info: {}
                };
            },
            methods: {
                fnGetBoard() {
                    var self = this;
                    var nparmap = {
                        boardNo: self.boardNo,
                        option: "UPDATE"
                    };
                    $.ajax({
                        url: "/board/info.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            self.info = data.info;
                            self.fnQuill();
                        }
                    });
                },
                fnEdit: function () {
                    var self = this;
                    var nparmap = self.info;
                    // var nparmap = {
                    //     boardNo : self.boardNo,
                    //     title : self.info.title,
                    //     contents : self.info.contents
                    // };
                    $.ajax({
                        url: "/board/edit.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            alert("수정되었습니다");
                            location.href = "/board/list.do";
                        }
                    });
                },
                fnQuill() {
                    let self = this;
                    var quill = new Quill('#editor', {
                        theme: 'snow',
                        modules: {
                            toolbar: [
                                [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                                ['bold', 'italic', 'underline'],
                                [{ 'list': 'ordered' }, { 'list': 'bullet' }],
                                ['link', 'image'],
                                ['clean'],
                                [{ 'color': [] }, { 'background': [] }]
                            ]
                        }
                    });
                    quill.root.innerHTML = self.info.contents;
                    // 에디터 내용이 변경될 때마다 Vue 데이터를 업데이트
                    quill.on('text-change', function () {
                        self.info.contents = quill.root.innerHTML;
                    });
                }
            },
            mounted() {
                var self = this;
                self.fnGetBoard();


            }
        });
        app.mount('#app');
    </script>