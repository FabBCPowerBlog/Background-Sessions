codeunit 50143 BST_FailureProcess
{
    var
        BackgroundSessionsTestMgt: Codeunit BackgroundSessionsTestMgt;

    trigger OnRun()
    begin
        BackgroundSessionsTestMgt.SendMailWithGenericContent('Failure Process.');
    end;
}
