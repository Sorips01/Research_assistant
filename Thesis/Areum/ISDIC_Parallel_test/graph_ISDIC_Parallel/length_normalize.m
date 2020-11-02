function mat_result = length_normalize(x_axis, data)
if(length(x_axis) > length(data))
    temp = zeros(1, length(x_axis) - length(data));
    data = [data temp];
end

mat_result = data;
end

