# bike_share_analysis
Phân tích dữ liệu người dùng dịch vụ thuê xe bằng MySQL
## 1. Giới thiệu
Dự án phân tích xu hướng sử dụng dịch vụ của khách hàng 
## 2. Phân tích
**1.**
- Phân tích cho thấy dịch vụ được sử dụng gần như xuyên suốt cả ngày, cao điểm nhất là vào 2 đợt: 7:00 AM và 3:00 PM
- Đề xuất: Cần đảm bảo đội ngũ điều phối xe có thể luân chuyển được khối lượng xe đủ để có thể đáp ứng 2 khung giờ cao điểm không thiếu xe, có thể luân chuyển xe trong các khoảng thời gian ít có người sử dụng
**2.**
  -Dữ liệu cho thấy nhóm khách subcriber có xu hướng sử dụng phương tiên ở những lộ trình trung bình-ngắn cho việc di chuyển làm việc hàng ngày. Đây cũng là nhóm khách đóng góp lớn vào lưu lượng sử dụng hàng ngày
  - Còn nhóm casual thường đi các chuyến có lộ trình dài hơn nhưng số lần sử dụng ít hơn. Nhóm này thường là những nhóm du lịch hoặc những người có nhã hứng đi đây đó. Đây là nhóm đóng góp lớn vào thời lượng sử dụng xe
  - Đề xuất: có thể đưa ra các chương trình khuyến mãi dành cho nhóm khách này . Ví dụ: thuê vào cuối tuần sẽ có ưu đãi giảm giá ...
**3**
    -Bằng việc sử dụng CTE, chúng tôi phát hiện ra một số trạm là điểm ử đọng - vì có nhiều xe đổ về nhưng không có chiều ngược lại ), và số trạm thì ngược lại là điểm cạn kiệt - nơi có số lượng người sử dụng nhiều
    -các trạm ứ động nhiều có thể là công ty , trung tâm thương mại hoặc các điểm vui chơi , còn các trạm cạn kiệt thường xuất phát tại các khu dân cư, chung cư, trạm tàu ,...
    -Đề xuất: có thể đưa ra các chương trình khuyến khích trả xe về các trạm trống để có thể nhận thưởng .

**4**
- Ở phần cuối, đã cho thấy dược tốc độ tăng trưởng ổn định cảu lượng người dùng dịch vụ 


    
