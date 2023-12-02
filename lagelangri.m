% 定义b值和对应的ln(b)值
b_values = [440, 450, 460, 470, 480, 490, 500, 510, 520, 530];
lnb_values = arrayfun(@compute_ln, b_values);
%lnb_values = [6.0868, 6.1092, 6.1312, 6.1527, 6.1738, 6.1944, 6.2146, 6.2344, 6.2538, 6.2729]

% 定义插值范围
b_interp = linspace(min(b_values), max(b_values), 1000);

% 进行拉格朗日插值
lnb_interp = zeros(size(b_interp));
for i = 1:length(b_interp)
    lnb_interp(i) = lagrange_interpolation(b_values, lnb_values, b_interp(i));
end

% 绘制插值图形
plot(b_interp, lnb_interp);
hold on;

% 标记学号平均值的点
average_b = 483;
average_lnb = lagrange_interpolation(b_values, lnb_values, average_b);
plot(average_b, average_lnb, 'ro'); % 使用红色圆圈标记
text(average_b, average_lnb, sprintf('(%.2f, %.2f)', average_b, average_lnb));

% 设置图形的标题和轴标签
title('拉格朗日多项式插值');
xlabel('b');
ylabel('ln(b)');
hold off;


% 定义拉格朗日插值函数
function result = lagrange_interpolation(x, y, x_new)
    total = 0;
    n = length(x);
    for i = 1:n
        xi = x(i);
        yi = y(i);
        prod = yi;
        for j = 1:n
            if i ~= j
                xj = x(j);
                prod = prod * (x_new - xj) / (xi - xj);
            end
        end
        total = total + prod;
    end
    result = total;
end
% 定义一个函数，根据b的值计算ln(b)
function ln_val = compute_ln(b)
    if b > 10
        n = floor(log10(b));  % 获取10的幂次
        B = b / 10^n;         % 获取B的值
        ln_val = log(B) + n * log(10);
    else
        ln_val = log(b);
    end
end
