function missile_hit_time_location
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

% 找到 y坐标和时间在 x1 = 0.5*x0 等于多少
x1 = 0.5*x0;
[~, idx] = min(abs(pos(:,1)-x1));
y_missile_initial= pos(idx,2); 
t1 = t(idx);

x_missile_initial = 0.5 * x0;
tspan = [0 10];
z0 = [x_missile_initial y_missile_initial];
[t, z] = ode45(@(t, z) hit_model(t, z, v0, x0, alpha, x1,t1), tspan, z0);
hit_index = find(z(:,1) >= x0, 1);
if ~isempty(hit_index)
hit_time = t(hit_index);
hit_location = z(hit_index, :);
disp(['导弹击中了乙舰。击中时间：' num2str(hit_time) '秒，击中位置：(' num2str(hit_location(1)) ', ' num2str(hit_location(2)) ')']);
else
disp('导弹未能击中乙舰。');
end
plot(z(:,1), z(:,2), 'b-', 'LineWidth', 2);
hold on;
if ~isempty(hit_index)
plot(hit_location(1), hit_location(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2); 
end
plot(x0, 0, 'go', 'MarkerSize', 10, 'LineWidth', 2); 
xlabel('x');
ylabel('y');
title('导弹的运行轨迹与击中情况');
grid on;
legend('导弹轨迹', '击中位置', '乙舰初始位置');
hold off;
end
function dposdt = missile_eq(t, pos, alpha, x0, v0)
x = pos(1);
y = pos(2);

dist = sqrt((x0 - x)^2 + (v0*t - y)^2);
dxdt = alpha * v0 * (x0 - x) / dist;
dydt = alpha * v0 * (v0*t - y) / dist;

dposdt = [dxdt; dydt];
end
function dzdt = hit_model(t, z, v0, x0, alpha, x1, t1)
x = z(1);
y = z(2);
if x > x1
    yt = v0 * t1 + 1.5 * v0 * (t - t1);
else
    yt = v0 * t;
end
vx = alpha * v0 * (x0 - x) / sqrt((x0 - x)^2 + (yt - y)^2);
vy = alpha * v0 * (yt - y) / sqrt((x0 - x)^2 + (yt - y)^2);
dzdt = [vx; vy];
end

