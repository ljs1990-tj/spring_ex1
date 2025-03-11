<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
	<title>첫번째 페이지</title>
    <style>
        .btn-link {
            text-decoration: none;
            color : red;
        }
    </style>
</head>
<style>
</style>
<body>
	<div id="app">
		<div>
            제목 : {{info.title}}
        </div>
        <div>
            <div v-for="item in fileList">
                <img :src="item.filePath">
            </div>
            내용 : <div v-html="info.contents"></div>
        </div>
        <div>
            조회수 : {{info.cnt}}
        </div>
        <div v-if="sessionId == info.userId || sessionStatus == 'A'">
            <button @click="fnEdit">수정</button>
            <button @click="fnRemove()">삭제</button>
        </div>
        <hr>
        <div v-for="item in cmtList">       
            {{item.userId}} : {{item.contents}}
            <template v-if="sessionId == item.userId || sessionStatus == 'A'">
                <button class="btn-link" href="javascript:;">🖍</button>
                <button class="btn-link" href="javascript:;">❌</button>
            </template>
           <hr>
        </div>
        <div>
            <textarea cols="30" rows="5" v-model="contents"></textarea>
            <button @click="fnCommentAdd">등록</button>
        </div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                boardNo : "${map.boardNo}",
                info : {},
                sessionId : "${sessionId}",
                sessionStatus : "${sessionStatus}",
                cmtList : [],
                contents : "",
                fileList : [] 
            };
        },
        methods: {
            fnGetBoard(){
				var self = this;
				var nparmap = {
                    boardNo : self.boardNo,
                    option : "SELECT"
                };
				$.ajax({
					url:"/board/info.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        self.info = data.info;
                        self.cmtList = data.cmtList;
                        self.fileList = data.fileList;
					}
				});
            },
            fnEdit : function(){
                pageChange("/board/edit.do", {boardNo : this.boardNo});
            },
            fnRemove : function(){
                var self = this;
				var nparmap = {
                    boardNo : self.boardNo
                };
				$.ajax({
					url:"/board/remove.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						alert("삭제되었습니다.");
                        location.href = "/board/list.do";
					}
				});
            },
            fnCommentAdd : function(){
                var self = this;
				var nparmap = {
                    boardNo : self.boardNo,
                    contents : self.contents,
                    userId : self.sessionId
                };
				$.ajax({
					url:"/board/cmt-add.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						alert("등록되었습니다.");
                        self.fnGetBoard();
					}
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