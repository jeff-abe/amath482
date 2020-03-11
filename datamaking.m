clc; clear all; close all;
list1 = dir('Test 1/Anderson .Paak/*.wav');
data1 = [];
paak = zeros(220501,2*length(list1));
for k = 1:length(list1)
    [data1,Fs] = audioread(append('Test 1/Anderson .Paak/', list1(k).name));
    data2 = data1(15*Fs:20*Fs);
    data1 = data1(10*Fs:15*Fs);
    paak(:,k) = data1;
    paak(:,12+k) = data2;
end
list2 = dir('Test 1/Rex Orange County/*.wav');
rex = zeros(220501,2*length(list2));
for k = 1:length(list2)
    [data1,Fs] = audioread(append('Test 1/Rex Orange County/', list2(k).name));
    data2 = data1(15*Fs:20*Fs);
    data1 = data1(10*Fs:15*Fs);
    rex(:,k) = data1;
    rex(:,12+k) = data2;
end
list3 = dir('Test 1/The Strokes/*.wav');
strokes = zeros(220501,2*length(list3));
for k = 1:length(list3)
    [data1,Fs] = audioread(append('Test 1/The Strokes/', list3(k).name));
    data2 = data1(15*Fs:20*Fs);
    data1 = data1(10*Fs:15*Fs);
    strokes(:,k) = data1;
    strokes(:,12+k) = data2;
end
y = [paak rex strokes];
s = zeros((size(y,1)-1)/4,size(y,2));
for l = 1:(size(y,1)-1)/4
    s(l,:) = y(4*l,:);
end
paak = s(:,1:24);
rex = s(:,25:48);
strokes = s(:,49:72);

%%
test = dir('Test 1/Test/*.wav');
tdata = [];
testdata1 = zeros(220501,length(test)*2);
for k = 1:size(test,1)
    [tdata,Fs] = audioread(append('Test 1/Test/', test(k).name));
    tdata2 = tdata(15*Fs:20*Fs);
    tdata = tdata(10*Fs:15*Fs);
    testdata1(:,k) = tdata;
    testdata1(:,9+k) = tdata2;
end
testdata1s = zeros((size(testdata1,1)-1)/4,size(testdata1,2));
for l = 1:(size(testdata1,1)-1)/4
    testdata1s(l,:) = testdata1(4*l,:);
end

%%
%Part2
list4 = dir('Test 2/Pink Floyd/*.wav');
clip1 = [];
clip2 = [];
floyd = zeros(220501,2*length(list4));
for k = 1:size(list4,1)
    [clip1 Fs] = audioread(append('Test 2/Pink Floyd/',list4(k).name));
    clip2 = clip1(15*Fs:20*Fs);
    clip1 = clip1(10*Fs:15*Fs);
    floyd(:,k) = clip1;
    floyd(:,20+k) = clip2;
end

list5 =dir('Test 2/Tame Impala/*.wav');
tame = zeros(220501,2*length(list4));
for k = 1:size(list5,1)
    [clip1 Fs] = audioread(append('Test 2/Tame Impala/',list5(k).name));
    clip2 = clip1(15*Fs:20*Fs);
    clip1 = clip1(10*Fs:15*Fs);
    tame(:,k) = clip1;
    tame(:,20+k) = clip2;
end

list6 =dir('Test 2/The Beatles/*.wav');
beatles = zeros(220501,2*length(list4));
for k = 1:size(list6,1)
    [clip1 Fs] = audioread(append('Test 2/The Beatles/',list6(k).name));
    clip2 = clip1(15*Fs:20*Fs);
    clip1 = clip1(10*Fs:15*Fs);
    beatles(:,k) = clip1;
    beatles(:,20+k) = clip2;
end

S2 = [floyd tame beatles];
s2 = zeros((size(S2,1)-1)/4,size(S2,2));
for l = 1:(size(S2,1)-1)/4
    s2(l,:) = S2(4*l,:);
end

floyd = s2(:,1:40); tame = s2(:,41:80); beatles = s2(:,81:120);


%%
test2 = dir('Test 2/Test/*.wav');
tdata = [];
testdata2 = zeros(220501,length(test2)*2);
for k = 1:size(test2,1)
    [tdata,Fs] = audioread(append('Test 2/Test/', test2(k).name));
    tdata2 = tdata(15*Fs:20*Fs);
    tdata = tdata(10*Fs:15*Fs);
    testdata2(:,k) = tdata; 
    testdata2(:,15+k) = tdata2;
end
testdata2s = zeros((size(testdata2,1)-1)/4,size(testdata2,2));
for l = 1:(size(testdata2,1)-1)/4
    testdata2s(l,:) = testdata2(4*l,:);
end
%% part 3
list7 = dir('Test 3/EDM/*.wav');
clip1 = [];
clip2 = [];
edm = zeros(220501,2*length(list7));
for k = 1:size(list7,1)
    [clip1 Fs] = audioread(append('Test 3/EDM/',list7(k).name));
    clip2 = clip1(15*Fs:20*Fs);
    clip1 = clip1(10*Fs:15*Fs);
    edm(:,k) = clip1;
    edm(:,16+k) = clip2;
end

list8 =dir('Test 3/Mumble/*.wav');
rap = zeros(220501,2*length(list8));
for k = 1:size(list8,1)
    [clip1 Fs] = audioread(append('Test 3/Mumble/',list8(k).name));
    clip2 = clip1(15*Fs:20*Fs);
    clip1 = clip1(10*Fs:15*Fs);
    rap(:,k) = clip1;
    rap(:,16+k) = clip2;
end

list9 =dir('Test 3/Classical/*.wav');
class = zeros(220501,2*length(list9));
for k = 1:size(list9,1)
    [clip1 Fs] = audioread(append('Test 3/Classical/',list9(k).name));
    clip2 = clip1(15*Fs:20*Fs);
    clip1 = clip1(10*Fs:15*Fs);
    class(:,k) = clip1;
    class(:,16+k) = clip2;
end

S2 = [edm rap class];
s2 = zeros((size(S2,1)-1)/4,size(S2,2));
for l = 1:(size(S2,1)-1)/4
    s2(l,:) = S2(4*l,:);
end

edm = s2(:,1:32); rap = s2(:,33:64); class = s2(:,65:96);

%% testdata 3

test3 = dir('Test 3/Test/*.wav');
tdata = [];
testdata3 = zeros(220501,length(test3)*2);
for k = 1:size(test3,1)
    [tdata,Fs] = audioread(append('Test 3/Test/', test3(k).name));
    tdata2 = tdata(15*Fs:20*Fs);
    tdata = tdata(10*Fs:15*Fs);
    testdata3(:,k) = tdata; 
    testdata3(:,12+k) = tdata2;
end
testdata3s = zeros((size(testdata3,1)-1)/4,size(testdata3,2));
for l = 1:(size(testdata3,1)-1)/4
    testdata3s(l,:) = testdata3(4*l,:);
end