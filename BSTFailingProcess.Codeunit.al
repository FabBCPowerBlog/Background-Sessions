codeunit 50142 BST_FailingProcess
{
    var
        BackgroundSessionsTestMgt: Codeunit BackgroundSessionsTestMgt;

    trigger OnRun()
    begin
        BackgroundSessionsTestMgt.SendMailWithGenericContent('Process that is going to fail.');
        Error('I am failing the process.')
    end;
}
