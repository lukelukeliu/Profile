function double_magnet()
    m1 = 0.5;
    m2 = 0.5;
    k1 = 6.28;
    k2 = 6.28; 
    A = 1*(10^-4);
    n = 2;
    gamma1 = 0;
    gamma2 = 0;
    x10 = 0;
    x20 = 0.015;
    d = 0.04;
    v10 = 0;
    v20 = 0;
    b = 0;
    omega = 0;
    options = odeset('RelTol', 1e-15, 'AbsTol', 1e-15); 
    
    [T, X] = ode45(@(t, X) DE(t, X, [m1, m2, k1, k2, A, n, gamma1, gamma2, b, omega, d]), [0 60], [x10-d/2 v10 x20+d/2 v20], options);
    
    figure;
    subplot(2,2,1);
    plot(T, X(:,1), 'r');
    hold on;
    plot(T, X(:,3), 'b');
    xlabel('$t$(s)','interpreter','latex')
    ylabel('$x$(m)','interpreter','latex')
    legend('x_{a}', 'x_{b}');
    legend('boxoff');
    title('(a)')
    set(gca, 'FontSize',14,'FontName','Times New Roman')
    
    subplot(2,2,2);
    plot(X(:,1), X(:,3), 'r');
    xlabel('$x_{a}$(m)','interpreter','latex')
    ylabel('$x_{b}$(m)','interpreter','latex')
    title('(b)')
    set(gca, 'FontSize',14,'FontName','Times New Roman')
    
    subplot(2,2,3);
    plot(X(:,1), X(:,2), 'r');
    xlabel('$x_{a}$(m)','interpreter','latex')
    ylabel('$v_{a}$(m/s)','interpreter','latex')
    title('(c)')
    set(gca, 'FontSize',14,'FontName','Times New Roman')
    
    subplot(2,2,4);
    plot(X(:,3), X(:,4), 'b');
    xlabel('$x_{b}$(m)','interpreter','latex')
    ylabel('$v_{b}$(m/s)','interpreter','latex')
    title('(d)')
    set(gca, 'FontSize',14,'FontName','Times New Roman')
end

function dx = DE(~, x, params)
    m1 = params(1);
    m2 = params(2);
    k1 = params(3);
    k2 = params(4);
    A = params(5);
    n = params(6);
    gamma1 = params(7);
    gamma2 = params(8);
    b = params(9);
    omega = params(10);
    d = params(11);
    dx = zeros(4, 1);
    dx(1) = x(2);
    dx(3) = x(4);
    dx(2) = (-k1 * (x(1)+d/2) - A / ((x(1)-x(3))^n) - gamma1*x(2) - gamma2 * (x(2)^2) + b*sin(omega)) / m1;
    dx(4) = (-k2 * (x(3)-d/2) + A / ((x(1)-x(3))^n) - gamma1*x(4) - gamma2 * (x(4)^2) + b*sin(omega)) / m2;
end