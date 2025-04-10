# To Brew Not To Brew

# 목차
1. [프로젝트 소개](#프로젝트-소개)
2. [팀소개](#팀소개)
3. [프로젝트 계기](#프로젝트-계기)
4. [주요기능](#주요기능)
5. [개발기간](#개발기간)
6. [기술스택](#기술스택)
7. [서비스 구조](#서비스-구조)
8. [와이어프레임](#와이어프레임)
9. [프로젝트 파일 구조](#프로젝트-파일-구조)
10. [Trouble Shooting](#trouble-shooting)


# 프로젝트 소개
> 커피 키오스크 앱  
매장에서 사용할 수 있는 직관적이고 간단한 주문 UI 제공  
To Brew(커피) / Not To Brew(논커피) 메뉴 카테고리 구분  
장바구니 담기 및 주문하기 기능 제공  


# 팀소개
| 이름 | 역할 |
|------|------|
| 이찬호 | 메뉴화면 UI 구현 |
| 김형윤 | 상단메뉴 카테고리 바 UI 구현 |
| 김기태 | 주문내역 화면 UI 구현 |
| 박혜민 | 로딩화면, 메인화면 UI 구현 |


 프로젝트 계기
- UIKit & SnapKit 기반 레이아웃 학습
- Delegate Pattern / MVC 구조 이해 & 적용
- 키오스크 UI/UX를 내 손으로 직접 만들어보고 싶어서


# 주요기능
- 메뉴 카테고리 선택
- 메뉴 선택 및 장바구니 담기
- 장바구니 수량 증가 / 감소
- 결제 예정 금액 실시간 업데이트
- 주문하기 알림창


# 개발기간
2024.04.07(월) ~ 2024.04.11(금)


# 기술스택
| 종류 | 내용 |
|------|------|
| Language | Swift |
| IDE | Xcode |
| UI | UIKit + SnapKit |
| 패턴 | Delegate Pattern |
| Version Control | Git / GitHub |


# 서비스 구조
```
ViewController
  └── HomeView
        ├── CategoryView
        ├── MenuCollectionView
        └── TableView
```
→ 각 View별 역할 명확히 분리  
→ Delegate Pattern으로 View-Controller 연결  


# 와이어프레임

![image](https://github.com/user-attachments/assets/a44c81ea-ae5e-4607-805d-5cf8eaaf930b)


# 프로젝트 파일 구조
```
 ToBrewNotToBrew
 ┣  View
 ┃ ┣  CategoryView.swift
 ┃ ┣  HomeView.swift
 ┃ ┣  MenuCollectionView.swift
 ┃ ┗  orderDetails.swift
 ┣  Model
 ┃ ┗  model.swift
 ┣  Controller
 ┃ ┣  ViewController.swift
 ┃ ┗  SplashViewController.swift
 ┣  Protocol.swift
```


# Trouble Shooting
