function three_magnet ()
    m1 = 0.5;
    m2 = 0.5;
    m3 = 0.5;
    k1 = 6.28;
    k2 = 6.28;
    k3 = 6.28;
    A = 1*(10^-4);
    n = 2;
    gamma1 = 0.0;
    gamma2 = 0.0;
    x10 = 0;
    x20 = 0.02;
    x30 = 0.0;
    d1 = 0.08;
    d2 = 0.08;
    v10 = 0;
    v20 = 0;
    v30 = 0;
    b = 0;
    omega = 0;
    options = odeset('RelTol', 1e-15, 'AbsTol', 1e-15);
    
    [T, X] = ode45(@(t, X) DE(t, X, [m1, m2, m3, k1, k2, k3, A, n, gamma1, gamma2, d1, d2, b, omega]), [0 60], [x10-d1 v10 x20 v20 x30+d2 v30], options);
    
    figure;
    subplot(2,4,1);
    plot(T, X(:,1), 'r');
    hold on;
    plot(T, X(:,3), 'b');
    hold on;
    plot(T, X(:,5), 'g');
    xlabel('$t$(s)','interpreter','latex')
    ylabel('$x$(m)','interpreter','latex')
    legend('x_{a}', 'x_{b}','x_{c}');
    legend('boxoff');
    title('(a)')
    set(gca, 'FontSize',14,'FontName','Times New Roman')
    
    subplot(2,4,2);
    plot(X(:,1), X(:,3), 'r');
    xlabel('$x_{a}$(m)','interpreter','latex')
    ylabel('$x_{b}$(m)','interpreter','latex')
    title('(b)')
    set(gca, 'FontSize',14,'FontName','Times New Roman')
    
    subplot(2,4,3);
    plot(X(:,3), X(:,5), 'r');
    xlabel('$x_{b}$(m)','interpreter','latex')
    ylabel('$x_{c}$(m)','interpreter','latex')
    title('(c)')
    set(gca, 'FontSize',14,'FontName','Times New Roman')
    
    subplot(2,4,4);
    plot(X(:,1), X(:,5), 'r');
    xlabel('$x_{a}$(m)','interpreter','latex')
    ylabel('$x_{c}$(m)','interpreter','latex')
    title('(d)')
    set(gca, 'FontSize',14,'FontName','Times New Roman')
    
    subplot(2,4,5);
    plot(X(:,1), X(:,2), 'r');
    xlabel('$x_{a}$(m)','interpreter','latex')
    ylabel('$v_{a}$(m/s)','interpreter','latex')
    title('(e)')
    set(gca, 'FontSize',14,'FontName','Times New Roman')
    
    subplot(2,4,6);
    plot(X(:,3), X(:,4), 'b');
    xlabel('$x_{b}$(m)','interpreter','latex')
    ylabel('$v_{b}$(m/s)','interpreter','latex')
    title('(f)')
    set(gca, 'FontSize',14,'FontName','Times New Roman')
    
    subplot(2,4,7);
    plot(X(:,5), X(:,6), 'g');
    xlabel('$x_{c}$(m)','interpreter','latex')
    ylabel('$v_{c}$(m/s)','interpreter','latex')
    title('(g)')
    set(gca, 'FontSize',14,'FontName','Times New Roman')
end

function dx = DE(t, x, params)
    m1 = params(1);
    m2 = params(2);
    m3 = params(3);
    k1 = params(4);
    k2 = params(5);
    k3 = params(6);
    A = params(7);
    n = params(8);
    gamma1 = params(9);
    gamma2 = params(10);
    d1 = params(11);
    d2 = params(12);
    b = params(13);
    omega = params(14);
    dx = zeros(6, 1);
    dx(1) = x(2);
    dx(3) = x(4);
    dx(5) = x(6);
    dx(2) = (-k1*(x(1)+d1) + A/((x(1)-x(3))^n) + A/((x(5)-x(1))^n) - gamma1*x(2) - gamma2*(x(2)^2) + b*sin(omega)) / m1;
    dx(4) = (-k2*(x(3)) - A/((x(1)-x(3))^n) + A/((x(5)-x(3))^n) - gamma1*x(4) - gamma2*(x(4)^2) + b*sin(omega)) / m2;
    dx(6) = (-k3*(x(5)-d2) - A/((x(5)-x(3))^n) - A/((x(5)-x(1))^n) - gamma1*x(6) - gamma2*(x(6)^2) + b*sin(omega)) / m3;
end