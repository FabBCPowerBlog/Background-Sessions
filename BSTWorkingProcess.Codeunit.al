codeunit 50141 "BST_WorkingProcess"
{
    var
        BackgroundSessionsTestMgt: Codeunit BackgroundSessionsTestMgt;

    trigger OnRun()
    var
        ProcessID: Guid;
    begin
        ProcessID := CreateGuid();

        BackgroundSessionsTestMgt.InsertEventLog(ProcessID, 'Start');

        Sleep(5000);

        BackgroundSessionsTestMgt.InsertEventLog(ProcessID, 'Stop');

    end;
}
