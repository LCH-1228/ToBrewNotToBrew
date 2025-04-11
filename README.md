

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
To Brew / Not To Brew 메뉴 카테고리 구분  
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
| Language | Swift 5 |
| IDE | Xcode16 |
| UI | UIKit + SnapKit 5.7.1 |
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
├── README.md
└── ToBrewNotToBrew
    ├── ToBrewNotToBrew
    │   ├── AppDelegate.swift
    │   ├── Assets.xcassets
    │   ├── Controller
    │   │   ├── SplashViewController.swift
    │   │   └── ViewController.swift
    │   ├── Font
    │   ├── Info.plist
    │   ├── Model
    │   │   └── Model.swift
    │   ├── SceneDelegate.swift
    │   └── View
    │       ├── CategoryView.swift
    │       ├── HomeView.swift
    │       ├── MenuCollectionView.swift
    │       └── orderDetails.swift
    └── ToBrewNotToBrew.xcodeproj
```


# Trouble Shooting
| 문제 상황 | 해결 방법 | 비고 |
|----------|-----------|------|
| CategoryView 버튼 그림자 짤림 | ViewController에서 CategoryViewdml top offset을 4로 설정하고,<br> HomeView에서 firstView height를 60으로 설정하여 버튼 위아래의 그림자 공간 확보 | 레이아웃 관련 문제 |
| 주문하기 버튼 작동 버그 | 주문하기 버튼이 결제예정금액이 0일 때는 비활성화, 0이 아닐 때는 비활성화 되어야하는데 동작이 되지 않았음. didset을 이용하여 결제예정금액에 따라 버튼 활성화 여부가 바뀌도록 개선 | UI 상태 동기화 문제 |
| 총 수량 변경 불능 | 기존 didSet에 총 수량을 갱신하는 메서드를 넣어 값이 변경될 때 마다 메서드를 실행시킴. 해당 메서드를 통해 누적된 총 수량을 보여주도록 하여 코드를 개선함. | didSet 연동 |
| 메뉴이름 사라짐 | 코드 수정중 불필요한 제약조건으로 생각한 Constraints 삭제로 인한 문제 Constraints 원상복구 | 레이아웃 관련 문제 |
