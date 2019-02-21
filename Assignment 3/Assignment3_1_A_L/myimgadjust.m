function out = myimadjust(varargin)
%Parse inputs and initialize variables
[img,imageType,lowIn,highIn,lowOut,highOut,gamma] = ...
    parseInputs(varargin{:});

validateLowHigh(lowIn,highIn,lowOut,highOut);
gamma = validateGamma(gamma,imageType);

if ~isfloat(img) && numel(img) > 65536
    % integer data type image with more than 65536 elements
    out = adjustWithLUT(img,lowIn,highIn,lowOut,highOut,gamma);

else
    classin = class(img);
    classChanged = false;
    if ~isa(img,'double')
        classChanged = true;
        img = im2double(img);
    end

    if strcmp(imageType, 'intensity')
        out = adjustGrayscaleImage(img,lowIn,highIn,lowOut,highOut,gamma);
    elseif strcmp(imageType, 'indexed')
        out = adjustColormap(img,lowIn,highIn,lowOut,highOut,gamma);
    else
        out = adjustTruecolorImage(img,lowIn,highIn,lowOut,highOut,gamma);
    end
    
    if classChanged
        out = images.internal.changeClass(classin,out);
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function out = adjustWithLUT(img,lowIn,highIn,lowOut,highOut,gamma)

imgClass = class(img);
out = zeros(size(img),imgClass);

%initialize for lut

switch imgClass
    case 'uint8'
        lutLength = 256;
        conversionFcn = @im2uint8;
    case 'uint16'
        lutLength = 65536;
        conversionFcn = @im2uint16;
    case 'int16'
        lutLength = 65536;
        conversionFcn = @im2int16;
    otherwise
        error(message('images:myimadjust:internalError'))
end

for p = 1:size(img,3)
    lut = linspace(0,1,lutLength);
    scalingFactor = 1;
    lut = adjustArray(lut,lowIn(p),highIn(p),lowOut(p),highOut(p), ...
        gamma(p),scalingFactor);
    lut = conversionFcn(lut);
    out(:,:,p) = intlut(img(:,:,p),lut);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function out = adjustColormap(cmap,lIn,hIn,lOut,hOut,g)

% expansion factor that can expand a 1-by-3 range to the size of cmap.
expansionFactor = ones(size(cmap,1), 1);
out = adjustArray(cmap, lIn, hIn, lOut, hOut, g, expansionFactor);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function out = adjustGrayscaleImage(img,lIn,hIn,lOut,hOut,g)

expansionFactor = 1;
out = adjustArray(img, lIn, hIn, lOut, hOut, g, expansionFactor);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function out = adjustTruecolorImage(rgb,lIn,hIn,lOut,hOut,g)

out = zeros(size(rgb), 'like', rgb);
expansionFactor = 1;
for p = 1 : 3
    out(:,:,p) = adjustArray(rgb(:,:,p), lIn(p),hIn(p), lOut(p), ...
        hOut(p), g(p), expansionFactor);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function out = adjustArray(img,lIn,hIn,lOut,hOut,g,d)

%make sure img is in the range [lIn;hIn]
img(:) =  max(lIn(d,:), min(hIn(d,:),img));

out = ( (img - lIn(d,:)) ./ (hIn(d,:) - lIn(d,:)) ) .^ (g(d,:));
out(:) = out .* (hOut(d,:) - lOut(d,:)) + lOut(d,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [img,imageType,low_in,high_in,low_out,high_out,gamma] = ...
    parseInputs(varargin)

narginchk(1,4);
img = varargin{1};


% Default values
lowhigh_in  = [0; 1];
lowhigh_out = [0; 1];
gamma = 1;

if nargin == 1
    % myimadjust(I)
    if ~ismatrix(img)
        error(message('images:myimadjust:oneArgOnlyGrayscale','myimadjust(I)'))
    end
    validateattributes(img, {'double' 'uint8' 'uint16' 'int16' 'single'}, ...
        {'2d'}, mfilename, 'I', 1);

    % If a user passes in a m-by-3 double array, assume it is an intensity
    % image (there is really no way to tell).
    imageType = 'intensity';
 
    % Turn off warning 'images:imhistc:inputHasNans' before calling STRETCHLIM and
    % restore afterwards. STRETCHLIM calls IMHIST/IMHISTC and the warning confuses
    % a user who calls myimadjust with NaNs.
    s = warning('off','images:imhistc:inputHasNaNs');
    lowhigh_in = stretchlim(img);
    warning(s) 

else
    if nargin == 2
    % myimadjust(I,[LOW_IN HIGH_IN])
    % myimadjust(MAP,[LOW_IN HIGH_IN])
    % myimadjust(RGB,[LOW_IN HIGH_IN])
    if ~isempty(varargin{2})
        lowhigh_in = varargin{2};
    end
    
    elseif nargin == 3
        % myimadjust(I,[LOW_IN HIGH_IN],[LOW_OUT HIGH_OUT])
        % myimadjust(MAP,[LOW_IN HIGH_IN],[LOW_OUT HIGH_OUT])
        % myimadjust(RGB,[LOW_IN HIGH_IN],[LOW_OUT HIGH_OUT])

        if ~isempty(varargin{2})
            lowhigh_in = varargin{2};
        end
        if ~isempty(varargin{3})
            lowhigh_out = varargin{3};
        end
    else
        % myimadjust(I,[LOW_IN HIGH_IN],[LOW_OUT HIGH_OUT],GAMMA)
        % myimadjust(MAP,[LOW_IN HIGH_IN],[LOW_OUT HIGH_OUT],GAMMA)
        % myimadjust(RGB,[LOW_IN HIGH_IN],[LOW_OUT HIGH_OUT],GAMMA)
        if ~isempty(varargin{2})
            lowhigh_in = varargin{2};
        end
        if ~isempty(varargin{3})
            lowhigh_out = varargin{3};
        end
        if ~isempty(varargin{4})
            gamma = varargin{4};
        end
    end
    imageType = findImageType(img, lowhigh_in, lowhigh_out);
    checkRange(lowhigh_in, imageType, 2,'[LOW_IN; HIGH_IN]');
    checkRange(lowhigh_out, imageType, 3,'[LOW_OUT; HIGH_OUT]');
end

[low_in, high_in]   = splitRange(lowhigh_in, imageType);
[low_out, high_out] = splitRange(lowhigh_out, imageType);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function imageType = findImageType(img, lowhigh_in, lowhigh_out)

if (ndims(img)==3 && size(img,3)==3)
    % RGB image
    validateattributes(img, {'double' 'uint8' 'uint16' 'int16' 'single'}, ...
        {}, mfilename, 'RGB1', 1);
    imageType = 'truecolor';

elseif (numel(lowhigh_in) == 2 && numel(lowhigh_out) == 2) || ...
    size(img,2) ~= 3
    % Assuming that a user passed in an intensity image if lowhigh_in and
    % lowhigh_out are 2-element vectors, e.g., myimadjust(3 column image,
    % [1;2], [2;3]).
    validateattributes(img, {'double' 'uint8' 'uint16' 'int16' 'single'}, ...
        {'2d'}, mfilename, 'I', 1);
    imageType = 'intensity';

else
    %Colormap
    iptcheckmap(img,mfilename,'MAP',1);
    imageType = 'indexed';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function checkRange(range, imageType, argumentPosition, variableName)

if strcmp(imageType, 'intensity')
    if numel(range) ~= 2
        error(message('images:myimadjust:InputMustBe2ElVec', mfilename, iptnum2ordinal( argumentPosition ), variableName))
    end
else
    if ~(numel(range) == 2 || isequal(size(range), [2 3]))
        error(message('images:myimadjust:InputMustBe2ElVecOr2by3Matrix', mfilename, iptnum2ordinal( argumentPosition ), variableName));
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rangeMin, rangeMax] = splitRange(range, imageType)

if numel(range) == 2
    if strcmp(imageType, 'intensity')
        rangeMin = range(1);
        rangeMax = range(2);
    else   
        % Create triples for RGB image or Colormap
        rangeMin = range(1) * ones(1,3);
        rangeMax = range(2) * ones(1,3);
    end
else
    % range is a 2 by 3 array
    rangeMin = range(1,:);
    rangeMax = range(2,:);
end
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function validateLowHigh(lowIn,highIn,lowOut,highOut)

if any(lowIn >= highIn)
    error(message('images:myimadjust:lowMustBeSmallerThanHigh'))
end

if isInvalidRange(lowIn) || isInvalidRange(highIn) ...
        || isInvalidRange(lowOut) || isInvalidRange(highOut)
    error(message('images:myimadjust:parametersAreOutOfRange'))
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function isInvalid = isInvalidRange(range)

isInvalid = min(range) < 0 || max(range) > 1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function gamma = validateGamma(gamma,image_type)

if strcmp(image_type,'intensity')
    validateattributes(gamma,{'double'},{'scalar', 'nonnegative'}, ...
        mfilename, 'GAMMA', 4)
else
    validateattributes(gamma,{'double'},{'nonnegative','2d'},...
        mfilename, 'GAMMA', 4)
    if numel(gamma) == 1,
        gamma = gamma*ones(1,3);
    elseif numel(gamma) ~=3,
        error(message('images:myimadjust:invalidGamma'));
    end
end