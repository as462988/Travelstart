# Travelstart

### A. Description :

Use Taipei open data below and build an application to introduce tourist sites in Taipei.<br> 
API Resource - [臺北市臺北旅遊網-景點資料(中文)](https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=36847f3f-deff-4183-a5bb-800737591de5)

### B. Please follow the guideline below :
#### Main Screen
1. Fetch ten tourist sites a time, scroll down and load more
2. Show error message if there’s internet connect issue
3. Start fetching data if there’s no connect issue
4. Implement tableView, collectionView
  * cell auto height
  * tableView cell include tourist sites title / description and collectionView
  * put tourist sites images in collectionView and can be scrolled horizontally
  * tap any image and navigate to detail screen
#### Detail Screen
1. put Images set on the top and can be scrolled horizontally like page view
2. add title, description, address, information...etc
