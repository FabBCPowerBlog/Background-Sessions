codeunit 50140 BackgroundSessionsTestMgt
{
    procedure InsertEventLog(ProcessID: Guid; EventType: Text[30]);
    var
        EventLog: Record BST_EventLog;
    begin
        EventLog.Init();
        EventLog."Event Date/Time" := CurrentDateTime;
        EventLog."Event Date" := Today();
        EventLog."Event Time" := Time();
        EventLog."Process ID" := ProcessID;
        EventLog."Event Type" := EventType;
        EventLog.insert();
    end;

    procedure SendMailWithGenericContent(Subject: Text)
    var
        Body: Text;
    begin
        Body := strsubstno('Sent from the %1 at %2', CompanyName, format(CurrentDateTime, 0, 1));
        SendMail(GetEmailRecipient(), Subject, Body);
    end;

    local procedure GetEmailRecipient(): Text;
    begin
        exit('fecarnot@groupe-calliope.com');
    end;

    local procedure SendMail(ToAddresses: Text; Subject: Text; Body: Text);
    var
        EMailMessage: Codeunit "EMail Message";
        Email: Codeunit Email;
        RecipientList: List of [Text];
    begin
        RecipientList.Add(ToAddresses);
        CLEAR(EMailMessage);
        EMailMessage.Create(ToAddresses, Subject, Body);
        if not Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
            Message(GetLastErrorText());
    end;

    /*
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Queue Error Handler", 'OnAfterLogError', '', false, false)]
    local procedure OnAfterLogError(var JobQueueEntry: Record "Job Queue Entry");
    begin
        SendMailWithGenericContent('Failure Process from Job Queue.');
    end;
    */
}