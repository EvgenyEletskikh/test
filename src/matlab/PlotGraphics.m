function PlotGraphics(x,sh,sh_ideal,ch,ch_ideal,ex,ex_ideal)
    figure
    subplot(311)
    grid on, hold on
    plot(x,sh_ideal,'-g','Linewidth',3)
    plot(x,sh,'-r','linewidth',1)
    legend('sh(x) ideal','sh(x) CORDIC');
    title('Сравнение sh(x)');
    xlabel('x');
    ylabel('y');

    subplot(312)
    grid on, hold on
    plot(x,ch_ideal,'-g','Linewidth',3)
    plot(x,ch,'-r','linewidth',1)
    legend('ch(x) ideal','ch(x) CORDIC');
    title('Сравнение ch(x)');
    xlabel('x');
    ylabel('y');

    subplot(313)
    grid on, hold on
    plot(x,ex_ideal,'-g','Linewidth',3)
    plot(x,ex,'-r','linewidth',1)
    legend('exp(x) ideal','exp(x) CORDIC');
    title('Сравнение exp(x) = sh(x) + ch(x)');
    xlabel('x');
    ylabel('y');
end