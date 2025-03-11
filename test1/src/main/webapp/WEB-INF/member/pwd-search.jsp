<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
        <title>view 기본 세팅 파일</title>
    </head>
    <style>
    </style>

    <body>
        <div id="app">
            <div v-if="!authFlg">
                아이디 : <input v-model="userId">
                <button @click="fnAuth()">비밀번호 찾기</button>
            </div>
            <div v-else>
                <div>
                    비밀번호 <input type="password" v-model="pwd">
                </div>
                <div>
                    비밀번호 확인<input type="password" v-model="pwd2">
                </div>
                <button @click="fnChangePwd">비밀번호 변경</button>
            </div>
        </div>
    </body>

    </html>
    <script>
        const userCode = "imp50081124";
        IMP.init(userCode);
        const app = Vue.createApp({
            data() {
                return {
                    authFlg: false,
                    userId: "",
                    pwd: "",
                    pwd2: ""
                };
            },
            methods: {
                fnAuth() {
                    let self = this;
                    if(self.userId == ""){
                        alert("아이디 입력하셈");
                        return;
                    }
                    IMP.certification({
                        channelKey: "channel-key-12c18717-c8a1-4ceb-a6db-0d2f17367d51",
                        merchant_uid: "merchant_" + new Date().getTime(),
                    }, function (rsp) {
                        if (rsp.success) {
                            self.authFlg = true;
                            alert("인증 성공");
                            console.log(rsp);

                        } else {
                            alert(rsp.error_msg);
                            console.log(rsp);
                        }
                    });
                },
                fnChangePwd: function () {
                    let self = this;
                    if (self.pwd != self.pwd2) {
                        alert("비밀번호 맞추셈");
                        return;
                    }
                    var nparmap = {
                        userId: self.userId,
                        pwd: self.pwd
                    };
                    $.ajax({
                        url: "/member/pwd.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            if (data.result == "success") {
                                alert("비밀번호 성공");
                                location.href="/member/login.do";
                            } else {
                                alert("변경 실패");
                            }
                        }
                    });


                }
            },
            mounted() {

            }
        });
        app.mount('#app');
    </script>