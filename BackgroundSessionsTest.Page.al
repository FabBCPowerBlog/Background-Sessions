page 50140 BackgroundSessionsTest
{
    ApplicationArea = All;
    Caption = 'Background Sessions Test';
    PageType = List;
    UsageCategory = Tasks;
    SourceTable = BST_EventLog;
    SourceTableView = order(descending);
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Event Date/Time"; Rec."Event Date/Time")
                {
                    ToolTip = 'Specifies the value of the Event Date/Time field.';
                }
                field("Event Time"; Rec."Event Time")
                {
                    ToolTip = 'Specifies the value of the Event Time field.';
                }
                field("Process ID"; Rec."Process ID")
                {
                    ToolTip = 'Specifies the value of the Event Time field.';
                }
                field("Event Type"; Rec."Event Type")
                {
                    ToolTip = 'Specifies the value of the Event Type field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TestEmail)
            {
                Caption = 'Test email';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                Image = MailSetup;

                trigger OnAction()
                begin
                    BackgroundSessionsTestMgt.SendMailWithGenericContent('This is a test !');
                end;
            }

            action(UseTaskScheduler)
            {
                Caption = 'Use Task Scheduler';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                begin
                    case StrMenu('Working Process,Failing Process,Working Process (not ready),Set Task Ready,Working Process (false / not before),Working Process (true / not before)') of
                        1:
                            TaskScheduler.CreateTask(Codeunit::BST_WorkingProcess, Codeunit::BST_FailureProcess);
                        2:
                            TaskScheduler.CreateTask(Codeunit::BST_FailingProcess, Codeunit::BST_FailureProcess);
                        3:
                            TaskScheduler.CreateTask(Codeunit::BST_WorkingProcess, Codeunit::BST_FailureProcess, false);
                        4:
                            TaskScheduler.SetTaskReady('e1e62a72-4943-451e-9363-b4ab5c298213');
                        5:
                            TaskScheduler.CreateTask(Codeunit::BST_WorkingProcess, Codeunit::BST_FailureProcess, false, CompanyName(), CurrentDateTime + 20000);
                        6:
                            TaskScheduler.CreateTask(Codeunit::BST_WorkingProcess, Codeunit::BST_FailureProcess, true, CompanyName(), CurrentDateTime + 20000);
                    end;
                end;
            }
            action(OpenScheduledTasks)
            {
                Caption = 'Open Scheduled Tasks';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                RunObject = page "Scheduled Tasks";
                Image = Task;
            }

            action(UseJobQueue)
            {
                Caption = 'Use Job Queue';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                var
                    JobQueueEntry: Record "Job Queue Entry";
                    MyRecordid: RecordId;
                begin
                    case StrMenu('Working Process,Failing Process,Working Process (Not Before),Failing Process (Not Before),Working Process With Rec') of
                        1:
                            JobQueueEntry.ScheduleJobQueueEntry(Codeunit::BST_WorkingProcess, MyRecordid);
                        2:
                            JobQueueEntry.ScheduleJobQueueEntry(Codeunit::BST_FailingProcess, MyRecordid);
                        3:
                            JobQueueEntry.ScheduleJobQueueEntryForLater(Codeunit::BST_WorkingProcess, CurrentDateTime + 30000, '', '');
                        4:
                            JobQueueEntry.ScheduleJobQueueEntryForLater(Codeunit::BST_FailingProcess, CurrentDateTime + 30000, '', '');
                        5:
                            JobQueueEntry.ScheduleJobQueueEntryWithParameters(Codeunit::BST_WorkingProcessWithRec, JobQueueEntry.RecordId, 'MyParameters');
                    end;
                end;
            }
            action(UseJobQueue2)
            {
                Caption = 'Use Job Queue 2';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                var
                    JobQueueEntry1: Record "Job Queue Entry";
                    JobQueueEntry2: Record "Job Queue Entry";
                begin
                    case StrMenu('Parallel, Sequential') of
                        1:
                            begin
                                JobQueueEntry1.ScheduleJobQueueEntryForLater(Codeunit::BST_WorkingProcess, CurrentDateTime, '', '');
                                JobQueueEntry2.ScheduleJobQueueEntryForLater(Codeunit::BST_WorkingProcess, CurrentDateTime, '', '');
                            end;
                        2:
                            begin
                                JobQueueEntry1.ScheduleJobQueueEntryForLater(Codeunit::BST_WorkingProcess, CurrentDateTime, 'TESTDOC', '');
                                JobQueueEntry2.ScheduleJobQueueEntryForLater(Codeunit::BST_WorkingProcess, CurrentDateTime, 'TESTDOC', '');
                            end;
                    end;
                    CurrPage.Update(false);
                end;
            }

            action(OpenJobQueueEntries)
            {
                Caption = 'Open Job Queue Entries';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                RunObject = page "Job Queue Entries";
            }
            action(OpenJobQueueLogEntries)
            {
                Caption = 'Open Job Queue Log Entries';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                RunObject = page "Job Queue Log Entries";
            }
        }
    }

    var
        BackgroundSessionsTestMgt: Codeunit BackgroundSessionsTestMgt;
}