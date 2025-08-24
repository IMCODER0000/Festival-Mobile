# Fasteval

**2023-11-18 ~ 2023-12-18**
	
**#Node     #express      #Flutter       #MariaDB     #AWS S3    #MariaDB   #Docker**

**#Java       #SpringBoot    #React    #AWS Lambda   #JWT**

## Overview

대한민국의 축제 관심도는 굉장히 뜨겁습니다

워터밤등 네임드 사축제의 티켓, 콘서트 티켓은 재판매로 수익을 내는 사람이 있을정도이다

또한 많은 젊은 세대들은 다양한 축제와 관광지를 찾습니다

 

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/bc941965-de18-43ed-ba4b-81c40cbda6f9/7f360d60-9dcc-410c-aec0-5b740fe52318/image.png)

원하는 축제가 있다면 언제 어디서든 원하는 축제의 다양한 정보를 얻을 수 있습니다

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/bc941965-de18-43ed-ba4b-81c40cbda6f9/501f82ce-38c5-4007-a081-39292e3a4e65/image.png)

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/bc941965-de18-43ed-ba4b-81c40cbda6f9/e4e3c2e5-ec03-4593-8aa4-205285132e6c/image.png)

하지만 내가 어떤 축제를 가고 싶은지 어떤 축제를 가면 재미있을지에 대한 

접근에 어려움이 있다

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/bc941965-de18-43ed-ba4b-81c40cbda6f9/0e40eda9-e0d9-4c8b-b516-a15454238282/image.png)

다양한 축제에 대한 정보와 컨텐츠를 제공하며 생긴 

데이터들을 통해 축제를 추천 받을 수 있다면 

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/bc941965-de18-43ed-ba4b-81c40cbda6f9/937749b6-d0bd-46e0-85be-a2a4c1672c31/image.png)

![image.png](attachment:b6cd341e-de86-4db5-9d02-6781a33f8998:image.png)

## Role

- Team Leader
    - 기획 및 디자인
    - 교내의 캡스톤 프로젝트로 계획, 일정, 역할 분담
- Backend(100%)
    - NodeJS의 Express - REST_API
    - Spring으로 마이그레이션 진행중
- Frontend(100%)
    - React - admin서비스 구현
- Mobile(100%)
    - Flutter 어플리케이션 제작
- Infra
    - CentOS기반 교내 서버를 통해 배포
    - AWS S3

## Challenge 1

**Problem**

---

![image.png](attachment:4f120629-5983-4b52-9b0d-6c343b28a795:image.png)

“교내 서버를 제공받아 사용하였고, 한 서버에 많은 팀이 각각 1개의 포트를 할당받아 AI 프로젝트를 수행하며 자원이 매우 부족”

#특히 이미지 처리에서 지연 시간 발생 및 잦은 오류 발생

- 클라이언트에서 웹서버로 업로드 되며 느린 이미지 업로드 로직과 서버 부하 발생
- 클라이언트 화면 크기에 상관 없이 원본 이미지를 조회 하며 속도 저하 발생

               “느린 이미지 업로드/조회 속도로 사용자 참여도 하락”

**Solution**

---

**Version 1**

S3도입으로 자원 분할

![image.png](attachment:4af19109-2a3f-4b82-b265-e9cc033ec3c2:image.png)

**Version 2**

**S3 및 AWS Lambda 기반의 서버리스 이미지 처리 아키텍처**를 도입

**이미지 처리 로직을 Lambda로 분산하고 이미지 저장소를 S3로 이전**

![image.png](attachment:f6e2cf8c-9420-4d8c-ad52-ceb64c19c6e8:image.png)

**결과적으로 서버의 CPU 사용률을 약 40~50% 감소시키고 메모리 사용률을 약 30~35% 절감했으며,** 

**전반적인 이미지 처리 성능도 향상**

**Summary**

---

교내에서 제공받은 서버에서 여러 팀이 각자 **1개의 포트**를 할당받아 AI 프로젝트를 수행하였습니다. 초기에는 서버의 **CPU 사용률이 평균 85~90%**, 메모리 사용률이 **75~80%**에 달했으며, 이미지 처리 작업당 평균 **4~5초**가 소요되는 등 심각한 자원 부족 현상이 발생했습니다.

이러한 상황에서 **30명 이상의 동시 사용자를 고려한 성능 테스트**가 필요했기에, **S3 및 AWS Lambda 기반의 서버리스 이미지 처리 아키텍처**를 도입했습니다. 이를 통해 **이미지 처리 로직을 Lambda로 분산하고 이미지 저장소를 S3로 이전하여 서버 부하와 I/O 병목 현상을 해소**했습니다.

결과적으로 **서버의 CPU 사용률을 약 40~50% 감소**시키고 **메모리 사용률을 약 30~35% 절감**했으며, 전반적인 이미지 처리 성능도 향상되었습니다.
