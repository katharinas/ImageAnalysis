function [startZ stopZ] = zChooser(maskStackBWL)
%Show the user the results of segmentation and ask them to specify
%the correct range of Z-sections.

global ROIText;
global sectionFigure;
global fig1;
global sectionClicked;

numZ = length(maskStackBWL(1,1,:));
if numZ > 25
    showmeRawLargeScreenZSections(maskStackBWL);
else
    showmeRaw(maskStackBWL);
end
sectionsChosen = 0;
while sectionsChosen == 0
    set(ROIText, 'String', 'Click on the LOWEST correct Z-Section.');
    figure(sectionFigure);
    drawnow;
    uiwait(sectionFigure);
    startZ = sectionClicked;
    set(ROIText, 'String', 'Click on the Highest correct Z-Section.');
    figure(sectionFigure);
    drawnow;
    uiwait(sectionFigure);
    stopZ = sectionClicked;
    questionStr = ['Lowest Z = ', num2str(startZ), ', highest Z = ', num2str(stopZ), '?'];
    response = questdlg(questionStr, 'Correct Z-Sections?', 'Yes', 'No', 'Yes');
    if strcmp(response, 'Yes')
        sectionsChosen = 1;
    end
end
close(sectionFigure);
