<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>첫번째 페이지</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
        }

        #app {
            width: 600px; /* 너비를 키움 */
            margin: 50px auto;
            background-color: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
            font-size: 26px; /* 제목 크기 키움 */
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 25px; /* 입력란 간격 조정 */
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 15px; /* 패딩을 키움 */
            font-size: 16px; /* 폰트 크기 키움 */
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            border-color: #4CAF50;
            outline: none;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 150px; /* textarea의 최소 높이 설정 */
        }

        button {
            width: 100%;
            padding: 15px;
            font-size: 18px; /* 버튼 폰트 크기 키움 */
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        button:focus {
            outline: none;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    <div id="app">
        <h1>제품 등록</h1>
        <div class="form-group">
            <input placeholder="제품명을 입력하세요" v-model="itemName">
        </div>
        <div>
            <input type="file" id="file1" name="file1" accept=".jpg, .png" multiple>
        </div>
        <br>
        <div class="form-group">
            <input placeholder="가격을 입력하세요" v-model="price">
        </div>
        <div class="form-group">
            <textarea placeholder="제품 설명을 입력하세요" v-model="itemInfo"></textarea>
        </div>
        <button @click="fnAdd">등록</button>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                itemName : "",
                price : "",
                itemInfo : ""
            };
        },
        methods: {
            fnAdd(){
				var self = this;
				var nparmap = {
                    itemName : self.itemName,
                    itemInfo : self.itemInfo,
                    price : self.price
                };
				$.ajax({
					url:"/product/add.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        if($("#file1")[0].files.length > 0){
                            var form = new FormData(); 
                            for(let i=0; i<$("#file1")[0].files.length; i++){
                                form.append("file1", $("#file1")[0].files[i]);
                            }
                            form.append("itemNo", data.itemNo); // 임시 pk
                            self.upload(form);
                        } else {
                            
                        }
					}
				});
            },
            // 파일 업로드
            upload: function (form) {
                var self = this;
                $.ajax({
                    url: "/product/fileUpload.dox"
                    , type: "POST"
                    , processData: false
                    , contentType: false
                    , data: form
                    , success: function (response) {
                        alert("저장되었습니다!");
                        location.href = "/product/list.do";
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
