function missile_tracking
% parameters
alpha = 43.78;
x0 = 151.02;
v0 = 10;  %% 可以更改 v0 来讨论不同情况

% 初始条件
x_start = 0;
y_start = 0;
init = [x_start; y_start];

%时间范围 time span
tspan = [0, 10];

% 求解微分方程
[t, pos] = ode45(@(t, pos) missile_eq(t, pos, alpha, x0, v0), tspan, init);

%绘图
figure
plot(pos(:,1), pos(:,2), 'r', 'LineWidth', 2);  % missile导弹
hold on
plot(x0*ones(size(t)), v0*t, 'b', 'LineWidth', 2);  % ship乙舰
xlabel('x')
ylabel('y')
legend('Missile', 'Ship')
grid on
end

function dposdt = missile_eq(t, pos, alpha, x0, v0)
x = pos(1);
y = pos(2);

dist = sqrt((x0 - x)^2 + (v0*t - y)^2);
dxdt = alpha * v0 * (x0 - x) / dist;
dydt = alpha * v0 * (v0*t - y) / dist;

dposdt = [dxdt; dydt];
end
