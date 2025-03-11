<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
    <title>쇼핑몰 헤더</title>
    <link rel="stylesheet" href="../css/product-style.css">
    <style>
       
    </style>
</head>

<body>
    <div id="app">
        <jsp:include page="../common/header.jsp" />

        <!-- 제품 상세 정보 -->
        <section class="product-detail">
            <div class="product-image-container">
                <img :src="info.filePath" alt="제품 이미지" id="mainImage">
                <!-- 이미지 슬라이드 -->
                <div class="product-image-thumbnails">
                    <img v-for="(img, index) in imgList" :src="img.filePath" alt="제품 썸네일" @click="changeImage(img.filePath)">
                </div>
            </div>
            <div class="product-info">
                <h1>{{ info.itemName }}</h1>
                <p>{{ info.itemInfo }}</p>
                <p class="price">₩ {{ info.price }}</p>
                <button class="buy-btn">구매하기</button>
            </div>
        </section>
    </div>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    itemNo: "${map.itemNo}",
                    info: {},
                    imgList: []
                };
            },
            methods: {
                fnProduct() {
                    var self = this;
                    var nparmap = { itemNo: self.itemNo };
                    $.ajax({
                        url: "/product/get.dox",  // 제품 정보를 가져오는 API 엔드포인트
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            self.info = data.info;  // 서버로부터 받은 정보로 info를 채움
                            self.imgList = data.imgList; // 이미지 리스트 받아오기
                        }
                    });
                },
                changeImage(filePath) {
                    // 클릭된 이미지로 메인 이미지 변경
                    document.getElementById('mainImage').src = filePath;
                }
            },
            mounted() {
                var self = this;
                self.fnProduct();  // 페이지가 로드되면 제품 정보를 가져옴
            }
        });
        app.mount('#app');
    </script>
</body>

</html>
