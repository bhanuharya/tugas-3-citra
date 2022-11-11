classdef functionsHelper
    methods (Static)
        function Out = Sobel(I, c0, threshold)
            c = round(c0);
            Hx = [-1 0 1; -c 0 c; -1 0 1];
            Hy = [1 c 1; 0 0 0; -1 -c -1];
            Jx = convn(double(I), double(Hx), "same");
            Jy = convn(double(I), double(Hy), "same");
            Out = uint8(abs(Jx) + abs(Jy)) > threshold;
        end
        
        function Out = Roberts(I, threshold)
            Hx = [1 0; 0 -1];
            Hy = [0 1; -1 0];
            Jx = convn(double(I), double(Hx), "same");
            Jy = convn(double(I), double(Hy), "same");
            Out = uint8(abs(Jx) + abs(Jy)) > threshold;
        end
        
        function Out = Prewitt(I, threshold)
            
            Hx = [-1 0 1; -1 0 1; -1 0 1];
            % Filter vertikal
            Hy = [1 1 1; 0 0 0; -1 -1 -1];
            Jx = convn(double(I), double(Hx), "same");
            Jy = convn(double(I), double(Hy), "same");
            % Jumlahkan kedua hasil konvolusi
            Out = uint8(abs(Jx) + abs(Jy) > threshold);
        end
        
        function Out = LoG(I, n0, threshold)
            n = round(n0);
            s = n/5;
            r = (n-1) / 2;
            X = repmat(-r:r, n, 1);
            Y = repmat(transpose(-r:r), 1, n);
            t = -(X.*X+Y.*Y)/(2.0*s*s);
            H = (-1/(pi*s*s*s*s)) * ((1+t) .* exp(t));
            H = H - mean2(H);
            %H = fspecial('log', n, s)
            Out = uint8(convn(double(I), double(H), "same")) > threshold;
        end
        
        function Out = Laplace(I, threshold)
            H = [0 1 0; 1 -4 1; 0 1 0];
            Out = uint8(convn(double(I), double(H), "same")) > threshold;
        end

        function Out = Canny(I, threshold)
            Out = edge(I, 'canny', threshold/255);
        end

        
    end
end