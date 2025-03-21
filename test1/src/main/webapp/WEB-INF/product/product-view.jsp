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
        <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
        <title>쇼핑몰 헤더</title>
        <link rel="stylesheet" href="../css/product-style.css">
        <style>

        </style>
    </head>

    <body>
        <jsp:include page="../common/header.jsp" />
        <div id="app">
            <!-- 제품 상세 정보 -->
            <section class="product-detail">
                <div class="product-image-container">
                    <img :src="info.filePath" alt="제품 이미지" id="mainImage">
                    <!-- 이미지 슬라이드 -->
                    <div class="product-image-thumbnails">
                        <img v-for="(img, index) in imgList" :src="img.filePath" alt="제품 썸네일"
                            @click="changeImage(img.filePath)">
                    </div>
                </div>
                <div class="product-info">
                    <h1>{{ info.itemName }}</h1>
                    <p>{{ info.itemInfo }}</p>
                    <p class="price">₩ {{ info.price }}</p>
                    <button class="buy-btn" @click="fnPayment">구매하기</button>
                </div>
            </section>
        </div>


    </body>

    </html>
    <script>
        const userCode = "imp50081124";
        IMP.init(userCode);
        const app = Vue.createApp({
            data() {
                return {
                    itemNo: "${map.itemNo}",
                    info: {},
                    imgList: [],
                    sessionId: "${sessionId}"
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
                },
                fnPayment() {
                    let self = this;
                    IMP.request_pay({
                        pg: "kakaopay",
                        pay_method: "card",
                        merchant_uid: "merchant_" + new Date().getTime(),
                        name: "테스트 결제",
                        amount: self.info.price,
                        buyer_tel: "010-0000-0000",
                    }, function (rsp) { // callback
                        if (rsp.success) {
                            // 결제 성공 시
                            alert("성공");
                            console.log(rsp);
                            self.fnSave(rsp.merchant_uid);
                        } else {
                            // 결제 실패 시
                            console.log(rsp);
                            alert("실패");
                        }
                    });
                },
                fnSave : function(merchant_uid){
                    var self = this;
                    var nparmap = {
                        // 결제 아이디, 세션 아이디, 가격, 제품 번호
                        orderId : merchant_uid,
                        userId : self.sessionId,
                        price : self.info.price,
                        itemNo : self.info.itemNo
                    };
                    $.ajax({
                        url:"/payment.dox",
                        dataType:"json",	
                        type : "POST", 
                        data : nparmap,
                        success : function(data) { 
                            console.log(data);
                        }
                    });
                }
            },
            mounted() {
                var self = this;
                self.fnProduct();  // 페이지가 로드되면 제품 정보를 가져옴
            }
        });
        app.mount('#app');
    </script>