table 50140 "BST_EventLog"
{
    Caption = 'BST_EventLog';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Event Date/Time"; DateTime)
        {
            Caption = 'Event Date/Time';
        }
        field(3; "Event Date"; Date)
        {
            Caption = 'Event Date';
        }
        field(4; "Event Time"; Time)
        {
            Caption = 'Event Time';
        }
        field(5; "Process ID"; Guid)
        {
            Caption = 'Process ID';
        }
        field(6; "Event Type"; Text[30])
        {
            Caption = 'Event Type';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
