Lc = [0.015 0.0075 0.01 0.01];
d = [2.50E-03 2.50E-03 3.33E-03 (5/3000)];
w = [0.025 0.025 0.025 0.025];
zeta = [5.274606666 4.922168903 4.834588912 5.62704443];

x =  linspace(0,1,100);
beta_out = [0.1 0.1 0.1];
beta_in = [0.8 0.8 0.8];
rho = 1.225;
vo=1;

n = Lc./d;
Ac=d.^2.*pi./4;
Ai=d.*w;
Ae=d.*w;
len=length(Lc);

% epsilon = zeros(len,1);
m=zeros(len,1);
% m_sq=zeros(len,1);
epsilon=(2-beta_in)./zeta./((Ai./Ac./n).^2);
m_sq=((2-beta_out)./(2-beta_in).*((Ai./Ae).^2)-1).*epsilon; 
m=sqrt(m_sq);
uc={};

for k=1:1:len
% pi_minus_pe{k}=((zeta/2).*((Ai./Ac./n(k)).^2)).*(((m(k)./sin(m(k))).^2).*(cos(m(k)*(1-x))-(epsilon_n(k)./(-m_sq(k))).*(cos(m(k)*x)-cos(m(k)*(1-x)))).^2);

pi_minus_pe{k}=((zeta(k)/2).*((Ai./Ac./n(k)).^2)).*(((m(k)./sinh(m(k))).^2).*(cosh(m(k)*x)+(epsilon(k)./m_sq(k)).*(cosh(m(k)*x)-cosh(m(k)*(1-x)))).^2)*rho*vo^2;

% net_deltap_non_dim{k}=((zeta/2).*((Ai./Ac./n(k)).^2)).*(((m(k)./tanh(m(k))).^2) + epsilon(k).*(1 + epsilon(k)./(m_sq(k))).*((1-sech(m(k)))./tanh(m(k))).^2);
end
%% PLOTTING
plotStyle = {'b-','m-','g-'};
grid on;
hold on;

plot(x,pi_minus_pe{1},plotStyle{1},x,pi_minus_pe{2},plotStyle{2},...
    x,pi_minus_pe{3},plotStyle{3},'LineWidth',1.2);

Lc_by_w = Lc./w;

legend(['L_c/w = ' num2str(Lc_by_w(1))],['L_c/w = ' num2str(Lc_by_w(2))], ...
    ['L_c/w = ' num2str(Lc_by_w(3))],'Location','southwest','FontSize',9,'FontWeight','bold');
xlabel('Linear location of channel \it (x)','FontSize',10,'FontWeight','bold')
ylabel('\Delta P \it (x)','FontSize',10)
figure(2)
plot(x,pi_minus_pe{2},plotStyle{1})