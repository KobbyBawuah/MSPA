% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  
set(0,'defaultaxesfontsize',20)
set(0,'DefaultFigureWindowStyle','docked')

for g = 1:10
% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rw(g) = 1.0- (g-1)*0.075;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125*1;        % grid size (horizontal)
dy = 0.0125*1;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute

[x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                            rh,rw(g),side,dx,dy); 

% First consider the fundamental TE mode:

[Hx,Hy,neffTE(g)] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');

%for loop
%for n = 1:nmodes
fprintf(1,'neff(%i) = %.6f\n',g,neffTE(g));

figure(g);
subplot(1,2,1);
contourmode(x,y,Hx(:,:,1));
title(['Hx (TE mode: ' num2str(g) ')']); xlabel('x'); ylabel('y'); 
%for v = edges, line(v{:}); end

subplot(122);
contourmode(x,y,Hy(:,:,1));
title(['Hy (TE mode: ' num2str(g) ')']); xlabel('x'); ylabel('y'); 
%for v = edges, line(v{:}); end
%end
% Next consider the fundamental TM mode
% (same calculation, but with opposite symmetry)


%for n = 1:nmodes
%could comment out this part but left it to see its reaction as well

[Hx,Hy,neffTM(g)] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000S');
fprintf(1,'neff(%i) = %.6f\n',g,neffTM(g));

figure(n+nmodes);
subplot(121);
contourmode(x,y,Hx(:,:,1));
title(['Hx (TM mode:' num2str(g) ')']); xlabel('x'); ylabel('y'); 
for v = edges, line(v{:}); end

subplot(122);
contourmode(x,y,Hy(:,:,1));
title(['Hy (TM mode: ' num2str(g) ')']); xlabel('x'); ylabel('y'); 
for v = edges, line(v{:}); end
end

figure 
plot(neffTE);hold on 
plot(neffTM);
xlabel('mode number')
ylabel('Neff')
legend('TE','TM')
