clear all;
close all;
%roslaunch rikirobot bringup.launch
% $ roslaunch robot_pose_ekf.launch
% https://blog.csdn.net/wilylcyu/article/details/51891299
% https://ww2.mathworks.cn/matlabcentral/answers/196911-use-matlab-robotics-system-toolbox-to-receive-ros-message
%��Ҫ�趨HOSTNAME
% setenv('ROS_MASTER_URI','http://192.168.1.112:11311')
% setenv('ROS_IP','192.168.1.113')
% rosinit('http://192.168.1.112:11311')
% rosnode list
% rostopic list

%%��ȡIMU��odom
%%ע��1 ����RIKIBOBOT��IMU+ODOM�д�����Ϊ�������Ӻͱ�����ѧģ���������ϵ�ֱ����ʻ������
% rawimu = rossubscriber('/imu/data');
% imudata = receive(rawimu,10)
% showdetails(imudata)
% 
% 
% odom = rossubscriber('odom')
% odomdata = receive(rawimu,10)
% showdetails(odomdata)

% %%
% %%��ȡ����1/imu/data
% bag = rosbag('2019-01-27-21-33-29.bag');
% bagSelection = select(bag,'Topic','/imu/data');
% ts = timeseries(bagSelection);
% 
% tsdata = getdatasamples(ts,1:ts.length);
% dataimu = tsdata(:,4:13);
% seq = tsdata(:,4:13);
% sec = tsdata(:,2);
% nsec = tsdata(:,3);
% time2 = double(sec)+double(nsec)*10^-9;
% 
% %%
% %%����Iomega����λ�ƣ��ٶ�
% oriData = dataimu(:,1:4);
% anSData = dataimu(:,5:7);
% accData = dataimu(:,8:10);
% data2 = [time2 anSData accData ];
% init2 = [0 0 0; 0 0 0; 0 0 0];
% output=find_position(data2,init2)

%%
%%��ȡ����3 /robot_pose_ekf/odom_combined  �ó����ۣ�����IMU����+EKF��1��������ڷ��׼��𣬶�������������
% rosbag record /imu/data_raw /imu/data /odom /robot_pose_ekf/odom_combined
% rawimu = rossubscriber('/robot_pose_ekf/odom_combined');
% imudata = receive(rawimu,10)
% showdetails(imudata)
if 0
bag = rosbag('2019-01-29-02-29-45.bag');
bagSelection = select(bag,'Topic','/robot_pose_ekf/odom_combined');
ts = timeseries(bagSelection);

tsdata = getdatasamples(ts,1:ts.length);
dataimu = tsdata(:,4:end);
dataPos = tsdata(:,[4 5 6 ]);
sec = tsdata(:,2);
nsec = tsdata(:,3);
time2 = double(sec)+double(nsec)*10^-9;

figure
hold on
plot(dataPos(:,1),dataPos(:,2),'.')
plot(dataPos(end,1),dataPos(end,2),'s')
plot(dataPos(1,1),dataPos(1,2),'o')
hold off

end

%%
%%��ȡ����2 /odo
% rosbag record /imu/data_raw /imu/data /odom /robot_pose_ekf/odom_combined
% odom = rossubscriber('odom')
% odomdata = receive(odom,10)
% showdetails(odomdata)
if 1
bag = rosbag('2019-01-29-02-29-45.bag');
bagSelection = select(bag,'Topic','/odom');
ts = timeseries(bagSelection);

tsdata = getdatasamples(ts,1:ts.length);

dataPos = tsdata(:,[4 5 6 ]);
sec = tsdata(:,2);
nsec = tsdata(:,3);
time2 = double(sec)+double(nsec)*10^-9;
oridata = tsdata(:,[7 8 9 10]);
linearSpeed = tsdata(:,[11 12 13]);
angularSpeed = tsdata(:,[14 15 16]);
figure
hold on
plot(dataPos(:,1),dataPos(:,2),'.')
plot(dataPos(end,1),dataPos(end,2),'s')
plot(dataPos(1,1),dataPos(1,2),'o')
hold off

end


