% 数据集中的b值，确保范围涵盖了学号值
b_values = linspace(1, 600, 6000); % 创建一个更加密集的b值范围以便更平滑

% 计算数据集中b值的ln(b)值
lnb_values = arrayfun(@compute_ln, b_values);

% 插值范围
b_interp_range = linspace(250, 600, 350); % 选择一个适当的插值范围

% 插值计算，使用三次样条插值
interp_values = spline(b_values, lnb_values, b_interp_range);

% 学号数据
student_numbers = [259, 595, 596];
student_ln_values = arrayfun(@compute_ln, student_numbers);
student_points = [student_numbers; student_ln_values];
student_points

% 绘制插值图形
figure;
plot(b_interp_range, interp_values, 'g-', 'LineWidth', 2, 'DisplayName', 'Cubic Spline Interpolation');
hold on;
scatter(student_numbers, student_ln_values, 50, 'r', 'filled', 'DisplayName', 'Student Numbers');
for i = 1:numel(student_numbers)
    text(student_numbers(i), student_ln_values(i), sprintf('(%d, %.2f)', student_numbers(i), student_ln_values(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', 'r');
end
hold off;

xlabel('b');
ylabel('ln(b)');
title('Cubic Spline Interpolation of Logarithmic Values');
legend('Location', 'Best');
grid on;

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
