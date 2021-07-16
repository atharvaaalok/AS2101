% For each dataset do Linear Regression
for i = 1:3
    % Load the data
    filename = sprintf('./DataSets/data%d.txt', i);
    data = load(filename);


    % Load the data into x and y vector
    x = data(:,1);
    y = data(:,2);

    % Make 3 sets of data using the first 50,100 and 200 points.
    x_first_50 = x(1:50);
    y_first_50 = y(1:50);

    x_first_100 = x(1:100);
    y_first_100 = y(1:100);

    x_first_200 = x(1:200);
    y_first_200 = y(1:200);

    % Create A and b matrix required for Linear Regression for each data set
    % Where y = b and A*[c;m] = mx + c
    A_50 = [ones(length(x_first_50),1) x_first_50];
    b_50 = y_first_50;

    A_100 = [ones(length(x_first_100),1) x_first_100];
    b_100 = y_first_100;

    A_200 = [ones(length(x_first_200),1) x_first_200];
    b_200 = y_first_200;

    % Calculate the parameter values that minimize the squared error for the
    % model for each data set
    parameter_matrix_50 = invert_matrix_function(A_50'*A_50)*A_50'*b_50;
    parameter_matrix_100 = invert_matrix_function(A_100'*A_100)*A_100'*b_100;
    parameter_matrix_200 = invert_matrix_function(A_200'*A_200)*A_200'*b_200;


    % Set table parameters
    DataSetSize = [50;100;200];
    c = [parameter_matrix_50(1);parameter_matrix_100(1);parameter_matrix_200(1)];
    m = [parameter_matrix_50(2);parameter_matrix_100(2);parameter_matrix_200(2)];
    % round m and c values to 3 places of decimal
    m = round(m, 3);
    c = round(c, 3);
    % create the table
    table_data = table(DataSetSize, m, c);


    % Save the table to .mat and .xlsx formats
    format_string = './FilesCreated/Table_data%d%s';

    % set filename .mat
    file_extension = '.mat';
    table_file_name_mat = sprintf(format_string, i, file_extension);
    save(table_file_name_mat, 'table_data');
    % set filename .xlsx
    file_extension = '.xlsx';
    table_file_name_excel = sprintf(format_string, i, file_extension);
    writetable(table_data, table_file_name_excel);
    filename_tex = sprintf('./FilesCreated/table%d.tex', i);
    table2latex(table_data, filename_tex);




    % Plot the Line for the model and the Scatter Plot of the original data on
    % top of it

    m_200 = table_data.m(3);
    c_200 = table_data.c(3);
    % Plot the Linear Model we fit
    figure(i);
    legend_string_model = 'Model Predictions';
    plot(x, m_200*x + c_200,'Color', '#F39C12', 'LineWidth', 16, 'DisplayName', legend_string_model);
    hold on
    % Plot the original data
    legend_string_scatter = 'Original Data';
    plot(x ,y, '.', 'Color', 'blue', 'MarkerSize', 18, 'DisplayName', legend_string_scatter);
    hold off
    % set axis labels and title of plot
    x_string = 'X';
    y_string = 'Y';
    title_string = sprintf('Data Set %d', i);
    xlabel(x_string, 'FontSize', 18);
    ylabel(y_string, 'FontSize', 18);
    title(title_string, 'FontSize', 20);
    %add legend
    legend('FontSize', 16)
    grid on
    % Save the plot
    % set .png filename
    format_string = './FilesCreated/Table_data%d%s';
    file_extension = '.png';
    table_file_name_png = sprintf(format_string, i, file_extension);
    set(gcf,'WindowState','maximized')
    exportgraphics(figure(i), table_file_name_png, 'Resolution', 300);
    


end