colorOrder = [188 39 49
              54 134 160 
              129 190 161
              56 54 97
              107 78 113];
co = colorOrder/255;

red = co(1,:);
blue = co(2,:);
green = co(3,:);
navy = co(4,:);
purple = co(5,:);

set(groot,'defaultAxesColorOrder',co)

%https://gka.github.io/palettes/#/100|d|bc2731|6b4e71|1|1
diverg1 = ["#770000", "#7c0304", "#810707", "#860b0b", "#8c0e0f", "#911213", "#961617", "#9c191a", "#a11d1e", "#a62022", "#ab2425", "#b02729", "#b62b2d", "#bb2e30", "#c03234", "#c53638", "#ca393b", "#cf3d3f", "#d54043", "#d84648", "#db4c4d", "#de5252", "#e05757", "#e35d5c", "#e66361", "#e86866", "#eb6d6a", "#ed736f", "#f07874", "#f27d78", "#f5837d", "#f78881", "#fa8d86", "#fc928a", "#ff978f", "#fe9d96", "#fea49d", "#fdaaa4", "#fcb0aa", "#fcb6b1", "#fbbcb7", "#fac2be", "#fac8c4", "#f9ceca", "#f9d4d1", "#f8d9d7", "#f7dfdd", "#f7e4e3", "#f6eae9", "#f6efef", "#ebf2f4", "#e1eff4", "#d7ecf3", "#cde8f3", "#c2e5f2", "#b8e2f2", "#addff1", "#a3dbf1", "#98d8f0", "#8dd4ef", "#86d0ec", "#81cce8", "#7dc8e4", "#78c4e0", "#74c0db", "#6fbcd7", "#6bb7d3", "#66b3cf", "#62afca", "#5dabc6", "#59a7c2", "#55a3be", "#509fba", "#4c9bb5", "#4797b1", "#4393ad", "#3f8fa9", "#3a8ba5", "#3687a1", "#32839d", "#2e7f99", "#2b7b94", "#297790", "#26738c", "#246f88", "#216b84", "#1f6780", "#1c637c", "#1a5f78", "#175b73", "#15576f", "#13546b", "#105067", "#0e4c64", "#0b4860", "#09455c", "#074158", "#043d54", "#023a50", "#00364d"];
diverg1 = hex2rgb(char(diverg1'));

%https://gka.github.io/palettes/#/100|d|bc2731|6b4e71|1|1
diverg2 = ["#770000", "#7c0304", "#810707", "#860b0b", "#8c0e0f", "#911213", "#961617", "#9c191a", "#a11d1e", "#a62022", "#ab2425", "#b02729", "#b62b2d", "#bb2e30", "#c03234", "#c53638", "#ca393b", "#cf3d3f", "#d54043", "#d84648", "#db4c4d", "#de5252", "#e05757", "#e35d5c", "#e66361", "#e86866", "#eb6d6a", "#ed736f", "#f07874", "#f27d78", "#f5837d", "#f78881", "#fa8d86", "#fc928a", "#ff978f", "#fe9d96", "#fea49d", "#fdaaa4", "#fcb0aa", "#fcb6b1", "#fbbcb7", "#fac2be", "#fac8c4", "#f9ceca", "#f9d4d1", "#f8d9d7", "#f7dfdd", "#f7e4e3", "#f6eae9", "#f6efef", "#f3f0f3", "#f1eaf2", "#efe5f0", "#eddfef", "#eadaed", "#e8d4ec", "#e6cfea", "#e4c9e9", "#e2c4e7", "#e0bfe6", "#dcbae2", "#d7b6dd", "#d3b2d9", "#cfaed5", "#caa9d0", "#c6a5cc", "#c2a1c8", "#bd9dc3", "#b999bf", "#b595bb", "#b191b7", "#ac8db2", "#a889ae", "#a485aa", "#a081a6", "#9c7da2", "#98799e", "#94759a", "#907196", "#8c6d92", "#87698d", "#836589", "#7f6185", "#7b5e81", "#775a7d", "#735679", "#705276", "#6c4f72", "#684b6e", "#64486a", "#604466", "#5c4062", "#593d5f", "#55395b", "#513657", "#4d3253", "#4a2f50", "#462b4c", "#422849", "#3f2545"];
diverg2 = hex2rgb(char(diverg2'));

%https://gka.github.io/palettes/#/100|d|81be81|6b4e71|1|1
diverg3 = ["#003804", "#033c07", "#073f0b", "#0a430e", "#0e4712", "#124b15", "#154e19", "#19521c", "#1d5620", "#205a23", "#245e27", "#28612b", "#2b652e", "#2f6932", "#336d36", "#367139", "#3a753d", "#3e7941", "#427d44", "#468148", "#49854c", "#4d8950", "#518d53", "#559157", "#59955b", "#5d995f", "#619d63", "#65a167", "#69a56a", "#6daa6e", "#71ae72", "#75b276", "#79b67a", "#7dba7e", "#82bf82", "#86c386", "#8ac78a", "#8ecc8e", "#92d092", "#96d496", "#9cd89b", "#a5dba4", "#aedeae", "#b7e1b7", "#c0e4c0", "#c9e7c9", "#d2ead2", "#dbeddb", "#e4efe4", "#ecf2ec", "#f3f0f3", "#f1eaf2", "#efe5f0", "#eddfef", "#eadaed", "#e8d4ec", "#e6cfea", "#e4c9e9", "#e2c4e7", "#e0bfe6", "#dcbae2", "#d7b6dd", "#d3b2d9", "#cfaed5", "#caa9d0", "#c6a5cc", "#c2a1c8", "#bd9dc3", "#b999bf", "#b595bb", "#b191b7", "#ac8db2", "#a889ae", "#a485aa", "#a081a6", "#9c7da2", "#98799e", "#94759a", "#907196", "#8c6d92", "#87698d", "#836589", "#7f6185", "#7b5e81", "#775a7d", "#735679", "#705276", "#6c4f72", "#684b6e", "#64486a", "#604466", "#5c4062", "#593d5f", "#55395b", "#513657", "#4d3253", "#4a2f50", "#462b4c", "#422849", "#3f2545"];
diverg3 = hex2rgb(char(diverg3'));




%https://gka.github.io/palettes/#/100|s|bc2731|3686a0|1|1
redseq=["#4b0000", "#4e0000", "#510000", "#540000", "#570000", "#5a0000", "#5d0000", "#600000", "#630000", "#660000", "#690000", "#6c0000", "#6f0000", "#720000", "#750000", "#780000", "#7b0001", "#7e0004", "#810007", "#84000a", "#87000d", "#8a000f", "#8d0011", "#900013", "#930015", "#960017", "#9a0019", "#9d001c", "#a0001e", "#a30120", "#a50421", "#a80923", "#aa0e24", "#ac1226", "#ae1627", "#b11929", "#b31c2b", "#b51f2c", "#b7222e", "#ba242f", "#bc2731", "#be2932", "#c02c34", "#c32e36", "#c53037", "#c73339", "#c9353b", "#cc373c", "#ce393e", "#d03c3f", "#d23e41", "#d54043", "#d74244", "#d94446", "#dc4648", "#de484a", "#e04b4b", "#e24d4d", "#e54f4f", "#e75150", "#e95352", "#ec5554", "#ee5756", "#f05957", "#f25b59", "#f55d5b", "#f75f5c", "#f9615e", "#fc6360", "#fe6562", "#ff6865", "#ff6c68", "#ff706b", "#ff746f", "#ff7872", "#ff7b75", "#ff7f79", "#ff827c", "#ff867f", "#ff8982", "#ff8c85", "#ff9088", "#ff938b", "#ff968e", "#ff9991", "#ff9c94", "#ff9f97", "#ffa299", "#ffa59c", "#ffa99f", "#ffaca2", "#ffaea5", "#ffb1a7", "#ffb4aa", "#ffb7ad", "#ffbab0", "#ffbdb2", "#ffc0b5", "#ffc3b8", "#ffc6bb"];
redseq = hex2rgb(char(redseq'));

%https://gka.github.io/palettes/#/100|s|3686a0|3686a0|1|1
blueseq = ["#001528", "#00182a", "#001a2d", "#001b2f", "#001d31", "#001f34", "#002136", "#002339", "#00253b", "#00273d", "#00293f", "#002b42", "#002e44", "#003046", "#003248", "#00344b", "#00364d", "#00384f", "#003a51", "#003d54", "#003f56", "#004158", "#00435b", "#00465d", "#00485f", "#004a62", "#004c64", "#004f67", "#005169", "#00536b", "#00566e", "#005870", "#005a73", "#005d75", "#005f78", "#00617a", "#00647d", "#00667f", "#026881", "#086b84", "#0e6d86", "#146f88", "#18718b", "#1c748d", "#20768f", "#237892", "#277a94", "#2a7d96", "#2d7f99", "#30819b", "#33849e", "#3686a0", "#3988a2", "#3c8ba5", "#3e8da7", "#418faa", "#4492ac", "#4794af", "#4996b1", "#4c99b3", "#4f9bb6", "#519eb8", "#54a0bb", "#56a2bd", "#59a5c0", "#5ca7c2", "#5eaac5", "#61acc7", "#63afca", "#66b1cc", "#68b3cf", "#6bb6d1", "#6eb8d4", "#70bbd6", "#73bdd9", "#75c0db", "#78c2de", "#7ac5e0", "#7dc7e3", "#7fcae6", "#82cce8", "#84cfeb", "#87d1ed", "#8ad4f0", "#8cd6f2", "#8fd9f5", "#91dbf8", "#94defa", "#96e0fd", "#99e3ff", "#9ce6ff", "#9fe9ff", "#a1ecff", "#a4eeff", "#a7f1ff", "#aaf4ff", "#adf7ff", "#b0faff", "#b2fcff", "#b7ffff"];
blueseq = hex2rgb(char(blueseq'));

%https://gka.github.io/palettes/#/100|s|81bea1|3686a0|1|1
greenseq = ["#001800", "#001a00", "#001d00", "#001e03", "#002007", "#00220c", "#00240f", "#002612", "#002814", "#002a16", "#002d18", "#002f1a", "#00311c", "#00331e", "#003520", "#003722", "#003924", "#003c26", "#003e28", "#00402a", "#00422c", "#01452e", "#044730", "#074932", "#0a4b34", "#0d4d36", "#114f38", "#13513a", "#16543c", "#19563e", "#1b5840", "#1e5a42", "#205c44", "#235f46", "#256148", "#28634a", "#2a654c", "#2c684e", "#2f6a51", "#316c53", "#336e55", "#367157", "#387359", "#3a755b", "#3d785d", "#3f7a60", "#417c62", "#437e64", "#468166", "#488369", "#4a866b", "#4d886d", "#4f8a6f", "#518d72", "#548f74", "#569176", "#589478", "#5b967b", "#5d997d", "#5f9b7f", "#629d82", "#64a084", "#66a286", "#69a589", "#6ba78b", "#6daa8d", "#70ac90", "#72ae92", "#74b194", "#77b397", "#79b699", "#7cb89c", "#7ebb9e", "#80bda0", "#83c0a3", "#85c2a5", "#88c5a8", "#8ac7aa", "#8ccaac", "#8fccaf", "#91cfb1", "#94d1b4", "#96d4b6", "#99d7b9", "#9bd9bb", "#9edcbe", "#a0dec0", "#a3e1c3", "#a5e3c5", "#a7e6c8", "#aae9ca", "#acebcd", "#afeecf", "#b2f0d2", "#b4f3d4", "#b7f6d7", "#b9f8d9", "#bcfbdc", "#befedf", "#c5ffe5"];
greenseq = hex2rgb(char(greenseq'));

%https://gka.github.io/palettes/#/100|s|383661|3686a0|1|1
purpleseq = ["#07042e", "#080730", "#0a0b32", "#0b0e34", "#0d1036", "#0f1339", "#11143b", "#14163d", "#16183f", "#181a41", "#1b1c43", "#1d1e45", "#1f2048", "#21214a", "#23234c", "#26254e", "#282750", "#2a2953", "#2c2b55", "#2e2d57", "#312f59", "#33315c", "#35335e", "#373560", "#3a3763", "#3c3a65", "#3e3c67", "#403e6a", "#43406c", "#45426e", "#474471", "#494673", "#4c4875", "#4e4b78", "#504d7a", "#534f7d", "#55517f", "#575381", "#595684", "#5c5886", "#5e5a89", "#615c8b", "#635f8d", "#656190", "#686392", "#6a6595", "#6c6897", "#6f6a9a", "#716c9c", "#746f9f", "#7671a1", "#7873a4", "#7b76a6", "#7d78a9", "#807aab", "#827dae", "#857fb0", "#8782b3", "#8984b6", "#8c86b8", "#8e89bb", "#918bbd", "#938ec0", "#9690c2", "#9893c5", "#9b95c8", "#9d98ca", "#a09acd", "#a39cd0", "#a59fd2", "#a8a2d5", "#aaa4d7", "#ada7da", "#afa9dd", "#b2acdf", "#b4aee2", "#b7b1e5", "#bab3e7", "#bcb6ea", "#bfb8ed", "#c1bbef", "#c4bdf2", "#c7c0f5", "#c9c3f8", "#ccc5fa", "#cfc8fd", "#d1caff", "#d4cdff", "#d7d0ff", "#dad3ff", "#ddd6ff", "#e0d9ff", "#e3dcff", "#e6dfff", "#e9e2ff", "#ece4ff", "#efe7ff", "#f2eaff", "#f5edff", "#f7f0ff"];
purpleseq = hex2rgb(char(purpleseq'));

%https://gka.github.io/palettes/#/100|s|6b4e71|3686a0|1|1
lavseq= ["#1e0022", "#1f0325", "#210626", "#220928", "#240b2a", "#260e2c", "#280f2e", "#2a1130", "#2c1332", "#2e1534", "#301737", "#321939", "#351b3b", "#371d3d", "#391f3f", "#3b2141", "#3d2343", "#3f2545", "#412747", "#43294a", "#462b4c", "#482d4e", "#4a2f50", "#4c3152", "#4e3354", "#513557", "#533759", "#55395b", "#573b5d", "#5a3e60", "#5c4062", "#5e4264", "#604466", "#634669", "#65486b", "#674b6d", "#6a4d70", "#6c4f72", "#6e5174", "#715377", "#735679", "#75587b", "#785a7e", "#7a5c80", "#7c5f82", "#7f6185", "#816387", "#84658a", "#86688c", "#886a8e", "#8b6c91", "#8d6f93", "#907196", "#927398", "#95769b", "#97789d", "#9a7aa0", "#9c7da2", "#9e7fa5", "#a181a7", "#a384aa", "#a686ac", "#a889af", "#ab8bb1", "#ad8db4", "#b090b6", "#b392b9", "#b595bb", "#b897be", "#ba9ac0", "#bd9cc3", "#bf9fc5", "#c2a1c8", "#c4a4ca", "#c7a6cd", "#caa9d0", "#ccabd2", "#cfaed5", "#d1b0d7", "#d4b3da", "#d7b5dd", "#d9b8df", "#dcbae2", "#debde5", "#e1bfe7", "#e4c2ea", "#e6c4ed", "#e9c7ef", "#eccaf2", "#eeccf4", "#f1cff7", "#f4d1fa", "#f6d4fd", "#f9d7ff", "#fcd9ff", "#ffdcff", "#ffe0ff", "#ffe4ff", "#ffe8ff", "#ffecff"];
lavseq = hex2rgb(char(lavseq'));



function [ rgb ] = hex2rgb(hex,range)
% hex2rgb converts hex color values to rgb arrays on the range 0 to 1. 
% 
% 
% * * * * * * * * * * * * * * * * * * * * 
% SYNTAX:
% rgb = hex2rgb(hex) returns rgb color values in an n x 3 array. Values are
%                    scaled from 0 to 1 by default. 
%                    
% rgb = hex2rgb(hex,256) returns RGB values scaled from 0 to 255. 
% 
% 
% * * * * * * * * * * * * * * * * * * * * 
% EXAMPLES: 
% 
% myrgbvalue = hex2rgb('#334D66')
%    = 0.2000    0.3020    0.4000
% 
% 
% myrgbvalue = hex2rgb('334D66')  % <-the # sign is optional 
%    = 0.2000    0.3020    0.4000
% 
%
% myRGBvalue = hex2rgb('#334D66',256)
%    = 51    77   102
% 
% 
% myhexvalues = ['#334D66';'#8099B3';'#CC9933';'#3333E6'];
% myrgbvalues = hex2rgb(myhexvalues)
%    =   0.2000    0.3020    0.4000
%        0.5020    0.6000    0.7020
%        0.8000    0.6000    0.2000
%        0.2000    0.2000    0.9020
% 
% 
% myhexvalues = ['#334D66';'#8099B3';'#CC9933';'#3333E6'];
% myRGBvalues = hex2rgb(myhexvalues,256)
%    =   51    77   102
%       128   153   179
%       204   153    51
%        51    51   230
% 
% HexValsAsACharacterArray = {'#334D66';'#8099B3';'#CC9933';'#3333E6'}; 
% rgbvals = hex2rgb(HexValsAsACharacterArray)
% 
% * * * * * * * * * * * * * * * * * * * * 
% Chad A. Greene, April 2014
%
% Updated August 2014: Functionality remains exactly the same, but it's a
% little more efficient and more robust. Thanks to Stephen Cobeldick for
% the improvement tips. In this update, the documentation now shows that
% the range may be set to 256. This is more intuitive than the previous
% style, which scaled values from 0 to 255 with range set to 255.  Now you
% can enter 256 or 255 for the range, and the answer will be the same--rgb
% values scaled from 0 to 255. Function now also accepts character arrays
% as input. 
% 
% * * * * * * * * * * * * * * * * * * * * 
% See also rgb2hex, dec2hex, hex2num, and ColorSpec. 
% 
%% Input checks:
assert(nargin>0&nargin<3,'hex2rgb function must have one or two inputs.') 
if nargin==2
    assert(isscalar(range)==1,'Range must be a scalar, either "1" to scale from 0 to 1 or "256" to scale from 0 to 255.')
end
%% Tweak inputs if necessary: 
if iscell(hex)
    assert(isvector(hex)==1,'Unexpected dimensions of input hex values.')
    
    % In case cell array elements are separated by a comma instead of a
    % semicolon, reshape hex:
    if isrow(hex)
        hex = hex'; 
    end
    
    % If input is cell, convert to matrix: 
    hex = cell2mat(hex);
end
if strcmpi(hex(1,1),'#')
    hex(:,1) = [];
end
if nargin == 1
    range = 1; 
end
%% Convert from hex to rgb: 
switch range
    case 1
        rgb = reshape(sscanf(hex.','%2x'),3,[]).'/255;
    case {255,256}
        rgb = reshape(sscanf(hex.','%2x'),3,[]).';
    
    otherwise
        error('Range must be either "1" to scale from 0 to 1 or "256" to scale from 0 to 255.')
end
end
