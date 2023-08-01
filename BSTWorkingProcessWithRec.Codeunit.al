codeunit 50144 BST_WorkingProcessWithRec
{

    TableNo = "Job Queue Entry";

    var
        BackgroundSessionsTestMgt: Codeunit BackgroundSessionsTestMgt;


    trigger OnRun()
    begin
        BackgroundSessionsTestMgt.SendMailWithGenericContent(strsubstno('Working Process. Job Queue Entry : %1', Rec));
    end;
}
