function [] = defineVid()
%Defines the video input and other caliberations
    global vid
    vid = videoinput('winvideo', 1, 'MJPG_320x240');
src = getselectedsource(vid);
src.Brightness = -64;
vid.ReturnedColorspace = 'YCbCr';
end

