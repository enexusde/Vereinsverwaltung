unit vereinswindowmain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls, MD5,
  Windows,
  StdCtrls, Buttons, Menus, uuid, beitragssatzaenderung, DateUtils, Contnrs, math;

const
  REMARK_SIZE = 1024;
  AMOUNT_FORMAT = '#,##0.00';
  clOrange = $0080FF;
type

  { TForm1 }

  TForm1 = class(TForm)
    removeButton: TSpeedButton;
    addHistoricMembershipChange: TMenuItem;
    bankList: TListView;
    bankDesc: TLabeledEdit;
    bankChecked: TCheckBox;
    bankCommentLabel: TLabel;
    bankChange: TLabeledEdit;
    bankRecipient: TLabeledEdit;
    bankMovementNo: TLabeledEdit;
    bankExecutionDate: TLabeledEdit;
    openFileButton: TSpeedButton;
    BitBtn2: TSpeedButton;
    cashList: TListView;
    cashChangeCent: TLabeledEdit;
    cashCommentLabel: TLabel;
    cashChecked: TCheckBox;
    fileGroup: TToolBar;
    fileSave: TSpeedButton;
    fileSaveAs: TSpeedButton;
    planList: TListView;
    memberAdd: TMenuItem;
    addCashIn: TMenuItem;
    statisticGraph: TPaintBox;
    removeCashMove: TMenuItem;
    cloneCashMove: TMenuItem;
    MenuItem13: TMenuItem;
    memberRemove: TMenuItem;
    membershipPay: TMenuItem;
    addBankMovement: TMenuItem;
    removeBankMovement: TMenuItem;
    moveBankToCash: TMenuItem;
    moveCashToBank: TMenuItem;
    cloneBankMove: TMenuItem;
    addCashOut: TMenuItem;
    loadFileDialog: TOpenDialog;
    popupIcons: TImageList;
    Label1: TLabel;
    cashMoveNo: TLabeledEdit;
    cashCategory: TLabeledEdit;
    cashSubject: TLabeledEdit;
    cashRecipient: TLabeledEdit;
    cashDate: TLabeledEdit;
    cashShortDescription: TLabeledEdit;
    cashHistory: TListBox;
    memberMembershipCostPlanCombo: TComboBox;
    CoolBar1: TCoolBar;
    memberMembershipCostPlanLabel: TLabel;
    bankComment: TMemo;
    cashDescription: TMemo;
    memberContextMenu: TPopupMenu;
    bankContextMenu: TPopupMenu;
    cashContextMenu: TPopupMenu;
    membershipCostPlanContextMenu: TPopupMenu;
    saveFileAsDialog: TSaveDialog;
    ad: TToolBar;
    toolbarIcons: TImageList;
    membershipCostPlanAmount: TLabeledEdit;
    membershipCostPlanName: TLabeledEdit;
    memberContactPerson: TLabeledEdit;
    memberMemoLabel: TLabel;
    memberContactState: TCheckGroup;
    memberLastContact: TLabeledEdit;
    membershipCostPlanAge: TLabeledEdit;
    membershipfee: TLabeledEdit;
    memberno: TLabeledEdit;
    members: TListView;
    memberMemo: TMemo;
    tabimages: TImageList;
    objectControl: TPageControl;
    cashSheet: TTabSheet;
    bankSheet: TTabSheet;
    memberSheet: TTabSheet;
    statisticSheet: TTabSheet;
    membershipCostPlan: TTabSheet;
    newButton: TSpeedButton;
    addButton: TSpeedButton;
    ToolButton2: TToolButton;
    procedure addButtonClick(Sender: TObject);
    procedure addHistoricMembershipChangeClick(Sender: TObject);
    procedure bankListSelectItem(Sender: TObject; Item: TListItem; Selected: boolean);
    procedure bankChangeChange(Sender: TObject);
    procedure bankCheckedChange(Sender: TObject);
    procedure bankCommentChange(Sender: TObject);
    procedure bankDescChange(Sender: TObject);
    procedure bankExecutionDateChange(Sender: TObject);
    procedure bankMovementNoChange(Sender: TObject);
    procedure bankRecipientChange(Sender: TObject);
    procedure CoolBar1Change(Sender: TObject);
    procedure fileGroupClick(Sender: TObject);
    procedure fileSaveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure newButtonClick(Sender: TObject);
    procedure objectControlChange(Sender: TObject);

    procedure openFileButtonClick(Sender: TObject);

    procedure BitBtn2Click(Sender: TObject);
    procedure cashCategoryChange(Sender: TObject);
    procedure cashChangeCentChange(Sender: TObject);
    procedure cashCheckedChange(Sender: TObject);
    procedure cashDateChange(Sender: TObject);
    procedure cashDescriptionChange(Sender: TObject);
    procedure cashListChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure cashMoveNoChange(Sender: TObject);
    procedure cashRecipientChange(Sender: TObject);
    procedure cashShortDescriptionChange(Sender: TObject);
    procedure cashSubjectChange(Sender: TObject);
    procedure cloneBankMoveClick(Sender: TObject);
    procedure cloneCashMoveClick(Sender: TObject);
    procedure fileSaveAsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure memberChangeNumber(Sender: TObject);
    procedure memberContactPersonChange(Sender: TObject);
    procedure memberContactStateItemClick(Sender: TObject; Index: integer);
    procedure memberLastContactChange(Sender: TObject);
    procedure memberMembershipCostPlanComboChange(Sender: TObject);
    procedure memberMemoChange(Sender: TObject);
    procedure memberRemoveClick(Sender: TObject);
    procedure membershipCostPlanAgeChange(Sender: TObject);
    procedure membershipCostPlanAmountChange(Sender: TObject);
    procedure planListChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure planListSelectItem(Sender: TObject; Item: TListItem; Selected: boolean);
    procedure membershipCostPlanNameChange(Sender: TObject);
    procedure membershipfeeChange(Sender: TObject);
    procedure addIncomingCash(Sender: TObject);
    procedure membershipPayClick(Sender: TObject);
    procedure moveBankToCashClick(Sender: TObject);
    procedure moveCashToBankClick(Sender: TObject);
    procedure removeButtonClick(Sender: TObject);
    procedure removeCashMoveClick(Sender: TObject);
    procedure memberAddClick(Sender: TObject);
    procedure addBankMovementClick(Sender: TObject);
    procedure removeBankMovementClick(Sender: TObject);
    procedure addCashOutClick(Sender: TObject);
    procedure recalculateCash(Sender: TObject; Item: TListItem);
    procedure selectCashMove(Sender: TObject; Item: TListItem; Selected: boolean);
    procedure statisticGraphClick(Sender: TObject);
    procedure statisticGraphPaint(Sender: TObject);
    procedure updateMemberForm(Sender: TObject; Item: TListItem; Selected: boolean);
    procedure MenuItem13Click(Sender: TObject);
  private

  public
    planChanges: TObjectList;
    filename: String;
    lastStoredHash: String;
    procedure recalculateAllCaptions();
    procedure recalculateDirtyFlag();
    procedure recalculateToolbarButtons();
    procedure recalculateMembershipCostPlan();
    procedure freeMemoryUsage();
    function CalculateDataHash: string;
  end;

  TType = (rtMember, rtMembershipCostPlan, rtBankAccountMovement, rtCashRegisterMovement, rtMembershipChange);
  TMemberFlags = (anualContact, monthContact, otherContact, vacation, telephone, postal, messenger, newsletter, contactPerson, sms, eMail);
  PItem = ^TDataset;
  TDataset = record
    case Typ: TType of
      rtMember: (
        number: string[8];
        overallPayedCents: integer;
        memberSince: TDate;
        lastContact: TDateTime;
        contactPerson: string[8];
        remarks: array[0..REMARK_SIZE] of char;
        flags: set of TMemberFlags;
        pricePlan: uuid_t;
      );
      rtMembershipChange: (
        memberNumber: string[8];
        newPricePlan: uuid_t;
        changedSince: TDate;
      );
      rtMembershipCostPlan: (
        membershipCostName: string[64];
        ageFrom: smallint;
        planAmountCent: integer;
        id: uuid_t;
      );
      rtBankAccountMovement: (
        bankDesc: string[255];
        bankRemarks: array[0..REMARK_SIZE] of char;
        bankChangeCent: integer;
        bankRecipient: string[64];
        bankExecutionDate: TDateTime;
        bankMovementNo: string[32];
        bankMovementChecked: boolean;
      );
      rtCashRegisterMovement: (
        cashMovementNo: string[16];
        cashAmountCentIncomming: integer;
        cashCategory: string[128];
        cashObject: string[128];
        cashRecipient: string[128];
        cashMovementDate: TDateTime;
        cashChecked: boolean;
        cashSmallDescription: string[128];
        cashRemarks: array[0..REMARK_SIZE] of char;
      );
  end;


var
  Form1: TForm1;

implementation

function GetAppVersion: string;
var
  Size, Handle: DWORD;
  Buffer: Pointer;
  FixedPtr: PVSFixedFileInfo;
  FixedSize: UINT;
begin
  Result := '';
  Size := GetFileVersionInfoSize(PChar(ParamStr(0)), Handle);
  if Size = 0 then Exit;

  GetMem(Buffer, Size);
  try
    if GetFileVersionInfo(PChar(ParamStr(0)), Handle, Size, Buffer) then
    begin
      if VerQueryValue(Buffer, '\', Pointer(FixedPtr), FixedSize) then
      begin
        Result :=
          IntToStr(HiWord(FixedPtr^.dwFileVersionMS)) + '.' +
          IntToStr(LoWord(FixedPtr^.dwFileVersionMS)) + '.' +
          IntToStr(HiWord(FixedPtr^.dwFileVersionLS)) + '.' +
          IntToStr(LoWord(FixedPtr^.dwFileVersionLS));
      end;
    end;
  finally
    FreeMem(Buffer);
  end;
end;

function MonthsBetweenDates(d1, d2: TDate): Integer;
begin
  Result := (YearOf(d2) - YearOf(d1)) * 12 + (MonthOf(d2) - MonthOf(d1));
end;

function FindPlanAmount(planId: uuid_t): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Form1.planList.Items.Count - 1 do
    if PItem(Form1.planList.Items[i].Data)^.id.ToString(True) =
       planId.ToString(True) then
    begin
      Result := PItem(Form1.planList.Items[i].Data)^.planAmountCent;
      Exit;
    end;
end;

function CalculateOpenContribution(member: PItem): Integer;
var
  startDate: TDate;
  endDate: TDate;
  currentPlan: uuid_t;
  months: Integer;
  amount: Integer;
  i: Integer;
  change: PItem;
begin
  Result := 0;

  startDate := member^.memberSince;
  currentPlan := member^.pricePlan;

  for i := 0 to Form1.planChanges.Count - 1 do
  begin
    change := PItem(Form1.planChanges[i]);

    if change^.memberNumber = member^.number then
    begin
      endDate := change^.changedSince;

      months := MonthsBetweenDates(startDate, endDate);
      amount := FindPlanAmount(currentPlan);

      Result := Result + months * amount;

      startDate := endDate;
      currentPlan := change^.newPricePlan;
    end;
  end;

  months := MonthsBetweenDates(startDate, Date);
  amount := FindPlanAmount(currentPlan);

  Result := Result + months * amount;

  Result := Result - member^.overallPayedCents;
end;

function StrToFloat(const S: string): double;
var
  tmp: string;
begin
  tmp := StringReplace(S, '.', '', [rfReplaceAll]);
  Result := SysUtils.StrToFloat(tmp);
end;


function TryParseDate(const S: string): Boolean;
var
  D: TDateTime;
begin
  Result := TryStrToDate(S, D);
end;

{$R *.lfm}

procedure TForm1.recalculateMembershipCostPlan();
var
  i: integer;
  item: TListItem;
begin
  memberMembershipCostPlanCombo.Clear;
  for i := 0 to planList.Items.Count - 1 do
  begin
    item := planList.Items[i];
    if item.Data <> nil then
      memberMembershipCostPlanCombo.Items.AddObject(PItem(item.Data)^.membershipCostName + ' (' + FormatFloat(AMOUNT_FORMAT,
        PItem(item.Data)^.planAmountCent / 100) + ')', TObject(item.Data));
  end;
end;

procedure TForm1.recalculateAllCaptions();
var
  i, valueCent, changeCent, overallCent: integer;
begin
  overallCent:=0;
  valueCent := 0;
  for i := 0 to cashList.Items.Count - 1 do
    with cashList.Items[i] do
      if SubItems.Count > 1 then
      begin
        changeCent := PItem(Data)^.cashAmountCentIncomming;
        Caption := FormatFloat(AMOUNT_FORMAT, valueCent / 100); // previous
        valueCent := valueCent + changeCent;
        if SubItems.Count > 2 then
        begin
          SubItems[0] := FormatFloat(AMOUNT_FORMAT, changeCent / 100); // modification
          SubItems[1] := FormatFloat(AMOUNT_FORMAT, valueCent / 100); // new
        end;
      end;
  cashSheet.Caption:='Barkasse ' + FormatFloat(AMOUNT_FORMAT, valueCent / 100);;
  overallCent:=valueCent;
  valueCent := 0;
  for i := 0 to bankList.Items.Count - 1 do
    with bankList.Items[i] do
      if SubItems.Count > 1 then
      begin
        changeCent := PItem(Data)^.bankChangeCent;
        Caption := FormatFloat(AMOUNT_FORMAT, valueCent / 100); // previous
        valueCent := valueCent + changeCent;
        if SubItems.Count > 2 then
        begin
          SubItems[0] := FormatFloat(AMOUNT_FORMAT, changeCent / 100); // modification
          SubItems[1] := FormatFloat(AMOUNT_FORMAT, valueCent / 100); // new
        end;
      end;
  bankSheet.Caption:='Bankkonto ' + FormatFloat(AMOUNT_FORMAT, valueCent / 100);;
  overallCent += valueCent;
  statisticGraph.Invalidate;
  Caption := 'Vereinsverwaltung ' + GetAppVersion + ' ('+FormatFloat(AMOUNT_FORMAT, overallCent / 100)+')';
  if filename <> '' then
  begin
    Caption:= Caption + ' ' + filename;
  end;
end;

procedure paintEntry(i: TListItem; Data: PItem);
var
  j: Integer;
  balanceCent: Integer;
begin
  i.Data := TObject(Data);
  if Data^.typ = rtMember then
  begin
    i.Caption := Data^.number;
    while (i.SubItems.Count < Form1.members.Columns.Count) do
      i.SubItems.Add('');

    balanceCent := CalculateOpenContribution(Data);

    i.SubItems[0] := FormatFloat(AMOUNT_FORMAT, -balanceCent / 100);
    i.SubItems[1] := 'Nein';
    i.SubItems[2] := DateTimeToStr(Data^.lastContact);
    i.SubItems[3] := 'Aktiv';
    i.SubItems[4] := '';

    for j := 0 to Form1.planList.Items.Count - 1 do
      if Data^.pricePlan.ToString(False) = PItem(Form1.planList.Items[j].Data)^.id.ToString(False) then
        i.SubItems[5] := FormatFloat(AMOUNT_FORMAT, PItem(Form1.planList.Items[j].Data)^.planAmountCent / 100);
  end;

  if Data^.typ = rtMembershipCostPlan then
  begin
    i.Caption := Data^.membershipCostName;
    while (i.SubItems.Count < Form1.planList.Columns.Count) do
      i.SubItems.Add('');
    i.SubItems[0] := IntToStr(Data^.ageFrom);
    i.SubItems[1] := FormatFloat(AMOUNT_FORMAT, Data^.planAmountCent / 100);
  end;

  if Data^.typ = rtCashRegisterMovement then
  begin
    i.Caption := '...';
    while (i.SubItems.Count < Form1.cashList.Columns.Count) do
      i.SubItems.Add('');
    i.SubItems[0] := FormatFloat(AMOUNT_FORMAT, Data^.cashAmountCentIncomming / 100);
    i.SubItems[1] := '...';
    i.SubItems[2] := Data^.cashMovementNo;
    i.SubItems[3] := Data^.cashCategory;
    i.SubItems[4] := Data^.cashObject;
    i.SubItems[5] := Data^.cashRecipient;
    i.SubItems[6] := Data^.cashSmallDescription;
    i.SubItems[7] := DateTimeToStr(Data^.cashMovementDate);
  end;

  if Data^.typ = rtBankAccountMovement then
  begin
    i.Caption := '...';
    while (i.SubItems.Count < Form1.bankList.Columns.Count) do
      i.SubItems.Add('');
    i.SubItems[0] := FormatFloat(AMOUNT_FORMAT, Data^.bankChangeCent / 100);
    i.SubItems[1] := '...';
    i.SubItems[2] := Data^.bankMovementNo;
    i.SubItems[3] := Data^.bankDesc;
    i.SubItems[4] := Data^.bankRecipient;
    i.SubItems[5] := DateTimeToStr(Data^.bankExecutionDate);
  end;
end;

function IfThen(Condition: boolean; const TrueVal, FalseVal: string): string;
begin
  if Condition then
    Result := TrueVal
  else
    Result := FalseVal;
end;

function IsDateTime(const s: string): boolean;
var
  dummy: TDateTime;
begin
  Result := TryStrToDateTime(s, dummy);
end;

function IsInt(const s: string): boolean;
var
  dummy: longint;
begin
  Result := TryStrToInt(s, dummy);
end;

function IsFloat(const s: string): boolean;
var
  dummy: double;
  st: string;
begin
  st := StringReplace(s, '.', '', [rfReplaceAll]);
  Result := TryStrToFloat(st, dummy);
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := 'Vereinsverwaltung ' + GetAppVersion;
  filename := '';
  lastStoredHash := '';
  planChanges := TObjectList.Create(False);
end;

procedure TForm1.freeMemoryUsage();
var
  i: integer;
  P: PItem;
begin
  for i := 0 to planList.Items.Count - 1 do
  begin
    P := PItem(planList.Items[i].Data);
    Dispose(P);
  end;
  planList.Clear;

  for i := 0 to members.Items.Count - 1 do
  begin
    P := PItem(members.Items[i].Data);
    Dispose(P);
  end;
  members.Clear;

  for i := 0 to bankList.Items.Count - 1 do
  begin
    P := PItem(bankList.Items[i].Data);
    Dispose(P);
  end;
  bankList.Clear;

  for i := 0 to cashList.Items.Count - 1 do
  begin
    P := PItem(cashList.Items[i].Data);
    Dispose(P);
  end;
  cashList.Clear;


  for i := 0 to planChanges.Count - 1 do
  begin
    P := PItem(planChanges.Items[i]);
    Dispose(P);
  end;
  planChanges.Clear;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.cashCategoryChange(Sender: TObject);
begin
  if cashList.ItemIndex > -1 then
  begin
    PItem(cashList.Items[cashList.ItemIndex].Data)^.cashCategory := cashCategory.Text;
    paintEntry(cashList.Items[cashList.ItemIndex], PItem(cashList.Items[cashList.ItemIndex].Data));
    recalculateDirtyFlag
  end;
end;

procedure TForm1.cashChangeCentChange(Sender: TObject);
begin
  if cashList.ItemIndex > -1 then
  begin
    PItem(cashList.Items[cashList.ItemIndex].Data)^.cashAmountCentIncomming := Round(StrToFloat(cashChangeCent.Text) * 100);
    paintEntry(cashList.Items[cashList.ItemIndex], PItem(cashList.Items[cashList.ItemIndex].Data));
    recalculateAllCaptions;
    recalculateDirtyFlag;
  end;
end;

procedure TForm1.cashCheckedChange(Sender: TObject);
begin
  if cashList.ItemIndex > -1 then
  begin
    PItem(cashList.Items[cashList.ItemIndex].Data)^.cashChecked := cashChecked.Checked;
    paintEntry(cashList.Items[cashList.ItemIndex], PItem(cashList.Items[cashList.ItemIndex].Data));
    recalculateDirtyFlag
  end;
end;

procedure TForm1.cashDateChange(Sender: TObject);
begin
  if (cashList.ItemIndex > -1) and IsDateTime(cashDate.Text) then
  begin
    PItem(cashList.Items[cashList.ItemIndex].Data)^.cashMovementDate := StrToDateTime(cashDate.Text);
    paintEntry(cashList.Items[cashList.ItemIndex], PItem(cashList.Items[cashList.ItemIndex].Data));
    recalculateDirtyFlag
  end;

end;

procedure TForm1.cashDescriptionChange(Sender: TObject);
begin
  if cashList.ItemIndex > -1 then
  begin
    StrPLCopy(PItem(cashList.Items[cashList.ItemIndex].Data)^.cashRemarks, cashDescription.Text, REMARK_SIZE);
    paintEntry(cashList.Items[cashList.ItemIndex], PItem(cashList.Items[cashList.ItemIndex].Data));
    recalculateDirtyFlag
  end;
end;

procedure TForm1.cashListChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  recalculateCash(Sender, item);
end;

procedure TForm1.cashMoveNoChange(Sender: TObject);
begin
  if cashList.ItemIndex > -1 then
  begin
    PItem(cashList.Items[cashList.ItemIndex].Data)^.cashMovementNo := cashMoveNo.Text;
    paintEntry(cashList.Items[cashList.ItemIndex], PItem(cashList.Items[cashList.ItemIndex].Data));
    recalculateDirtyFlag
  end;
end;

procedure TForm1.cashRecipientChange(Sender: TObject);
begin
  if cashList.ItemIndex > -1 then
  begin
    PItem(cashList.Items[cashList.ItemIndex].Data)^.cashRecipient := cashRecipient.Text;
    paintEntry(cashList.Items[cashList.ItemIndex], PItem(cashList.Items[cashList.ItemIndex].Data));
    recalculateDirtyFlag
  end;
end;

procedure TForm1.cashShortDescriptionChange(Sender: TObject);
begin
  if cashList.ItemIndex > -1 then
  begin
    PItem(cashList.Items[cashList.ItemIndex].Data)^.cashSmallDescription := cashShortDescription.Text;
    paintEntry(cashList.Items[cashList.ItemIndex], PItem(cashList.Items[cashList.ItemIndex].Data));
    recalculateDirtyFlag
  end;

end;

procedure TForm1.cashSubjectChange(Sender: TObject);
begin
  if cashList.ItemIndex > -1 then
  begin
    PItem(cashList.Items[cashList.ItemIndex].Data)^.cashObject := cashSubject.Text;
    paintEntry(cashList.Items[cashList.ItemIndex], PItem(cashList.Items[cashList.ItemIndex].Data));
    recalculateDirtyFlag
  end;

end;

procedure TForm1.cloneBankMoveClick(Sender: TObject);
var clone, old : PItem;
begin
  if bankList.ItemIndex > -1 then
  begin
    old := PItem(bankList.Items[bankList.ItemIndex].Data);
    new(clone);
    FillChar(clone^, SizeOf(TDataset), 0);
    clone^.typ := old^.typ;
    clone^.bankMovementNo := old^.bankMovementNo + ' (Duplikat)';
    clone^.bankDesc := old^.bankDesc;
    Move(old^.bankRemarks, clone^.bankRemarks, SizeOf(old^.bankRemarks));
    clone^.bankChangeCent := old^.bankChangeCent;
    clone^.bankRecipient := old^.bankRecipient;
    clone^.bankExecutionDate := old^.bankExecutionDate;
    clone^.bankMovementChecked:=false;
    paintEntry(bankList.Items.Add, clone);
    recalculateAllCaptions;
    recalculateDirtyFlag
  end;
end;

procedure TForm1.cloneCashMoveClick(Sender: TObject);
var clone, old : PItem;
begin
  if cashList.ItemIndex > -1 then
  begin
    old := PItem(cashList.Items[cashList.ItemIndex].Data);
    new(clone);
    FillChar(clone^, SizeOf(TDataset), 0);
    clone^.typ := old^.typ;
    clone^.cashMovementNo := old^.cashMovementNo + ' (Duplikat)';
    clone^.cashAmountCentIncomming := old^.cashAmountCentIncomming;
    clone^.cashCategory := old^.cashCategory;
    clone^.cashObject := old^.cashObject;
    clone^.cashRecipient := old^.cashRecipient;
    clone^.cashMovementDate := old^.cashMovementDate;
    Move(old^.cashRemarks, clone^.cashRemarks, SizeOf(old^.cashRemarks));
    clone^.cashSmallDescription := old^.cashSmallDescription;
    clone^.cashChecked := false;
    paintEntry(cashList.Items.Add, clone);
    recalculateAllCaptions;
    recalculateDirtyFlag
  end;
end;


procedure TForm1.bankListSelectItem(Sender: TObject; Item: TListItem; Selected: boolean);
var
  enable: boolean;
begin
  enable := bankList.ItemIndex > -1;
  bankDesc.Enabled := enable;
  bankChange.Enabled := enable;
  bankRecipient.Enabled := enable;
  bankExecutionDate.Enabled := enable;
  bankMovementNo.Enabled := enable;
  bankChecked.Enabled := enable;
  bankComment.Enabled := enable;
  addBankMovement.Enabled:=true;
  removeBankMovement.Enabled:=enable;
  moveBankToCash.Enabled:=true;
  cloneBankMove.Enabled:=enable;

  if not enable then
  begin
    bankDesc.Text := '';
    bankChange.Text := '';
    bankRecipient.Text := '';
    bankExecutionDate.Text := '';
    bankMovementNo.Text := '';
    bankComment.Text := '';
    bankChecked.Checked := False;
  end
  else
    with PItem(bankList.Items[bankList.ItemIndex].Data)^ do
    begin
      bankChange.Text := FormatFloat(AMOUNT_FORMAT, bankChangeCent / 100);
      form1.bankDesc.Text := bankDesc;
      form1.bankRecipient.Text := bankRecipient;
      form1.bankExecutionDate.Text := DateTimeToStr(bankExecutionDate);
      form1.bankMovementNo.Text := bankMovementNo;
      bankComment.Text := bankRemarks;
      bankChecked.Checked := bankMovementChecked;
      recalculateAllCaptions;
    end;
  recalculateToolbarButtons;
end;

procedure TForm1.addHistoricMembershipChangeClick(Sender: TObject);
var newChange, plan : PItem;
    i: integer;
    xname: String;
begin
  MembershipChangeForm.limit(memberno.Text);

  MembershipChangeForm.membershipChangeAvailableCostPlanList.Clear;
  for i := 0 to planList.Items.Count-1 do
  begin
    MembershipChangeForm.membershipChangeAvailableCostPlanList.Items.AddObject(planList.Items[i].Caption, TObject(planList.Items[i].Data));
  end;

  if MembershipChangeForm.ShowModal = mrOK then
  begin
    New(newChange);
    FillChar(newChange^, SizeOf(TDataset), 0);
    newChange^.Typ := rtMembershipChange;
    MembershipChangeForm.fill(newChange^.changedSince, TObject(plan));
    newChange^.newPricePlan := plan^.id;
    newChange^.memberNumber := memberno.Text;
    planChanges.Add(TObject(newChange));
    xname:='Unbenannt';
    for i := 0 to planList.Items.Count-1 do
    begin
      if PItem(planList.Items[i].Data)^.id.ToString(true) = newChange^.newPricePlan.ToString(true) then
        xname := PItem(planList.Items[i].Data)^.membershipCostName;
    end;
    memberMemo.Text:=memberMemo.Text + LineEnding+ 'Beitragssatz seit ' + FormatDateTime('mm.yyyy', newChange^.changedSince)+': '+xname;
    recalculateDirtyFlag
  end;
end;

procedure TForm1.addButtonClick(Sender: TObject);
var x: TTabSheet;
begin
  x:= objectControl.ActivePage;
  if (x = cashSheet) then
  begin
    if QuestionDlg('Bewegungstyp', 'Einzahlung oder Auszahlung?', mtConfirmation, [mrYes, 'Einzahlung', mrNo, 'Auszahlung'], '') = mrYes then
      addIncomingCash(sender)
    else
      addCashOutClick(sender);
  end
  else if (objectControl.ActivePage = bankSheet) then
    addBankMovementClick(sender)
  else if (objectControl.ActivePage = memberSheet)then
    memberAddClick(sender)
  else if (objectControl.ActivePage = membershipCostPlan) then
    MenuItem13Click(sender);
end;

procedure TForm1.bankChangeChange(Sender: TObject);
begin
  if bankList.ItemIndex > -1 then
  begin
    PItem(bankList.Items[bankList.ItemIndex].Data)^.bankChangeCent := Round(StrToFloat(bankChange.Text) * 100);
    paintEntry(bankList.Items[bankList.ItemIndex], PItem(bankList.Items[bankList.ItemIndex].Data));
    recalculateAllCaptions();
    recalculateDirtyFlag
  end;
end;

procedure TForm1.bankCheckedChange(Sender: TObject);
begin
  if bankList.ItemIndex > -1 then
  begin
    PItem(bankList.Items[bankList.ItemIndex].Data)^.bankMovementChecked := bankChecked.Checked;
    paintEntry(bankList.Items[bankList.ItemIndex], PItem(bankList.Items[bankList.ItemIndex].Data));
    recalculateDirtyFlag
  end;
end;

procedure TForm1.bankCommentChange(Sender: TObject);
begin
  if bankList.ItemIndex > -1 then
  begin
    StrPLCopy(PItem(bankList.Items[bankList.ItemIndex].Data)^.bankRemarks, bankComment.Text, REMARK_SIZE);
    paintEntry(bankList.Items[bankList.ItemIndex], PItem(bankList.Items[bankList.ItemIndex].Data));
    recalculateDirtyFlag
  end;
end;

procedure TForm1.bankDescChange(Sender: TObject);
begin
  if bankList.ItemIndex > -1 then
  begin
    PItem(bankList.Items[bankList.ItemIndex].Data)^.bankDesc := bankDesc.Text;
    paintEntry(bankList.Items[bankList.ItemIndex], PItem(bankList.Items[bankList.ItemIndex].Data));
    recalculateDirtyFlag
  end;
end;

procedure TForm1.bankExecutionDateChange(Sender: TObject);
var t: TDateTime;
begin
  if (bankList.ItemIndex > -1) AND (tryStrToDateTime(bankExecutionDate.Text,t)) then
  begin
    PItem(bankList.Items[bankList.ItemIndex].Data)^.bankExecutionDate := t;
    paintEntry(bankList.Items[bankList.ItemIndex], PItem(bankList.Items[bankList.ItemIndex].Data));
    recalculateDirtyFlag
  end;
end;

procedure TForm1.bankMovementNoChange(Sender: TObject);
begin
  if bankList.ItemIndex > -1 then
  begin
    PItem(bankList.Items[bankList.ItemIndex].Data)^.bankMovementNo := bankMovementNo.Text;
    paintEntry(bankList.Items[bankList.ItemIndex], PItem(bankList.Items[bankList.ItemIndex].Data));
    recalculateDirtyFlag
  end;
end;

procedure TForm1.bankRecipientChange(Sender: TObject);
begin
  if bankList.ItemIndex > -1 then
  begin
    PItem(bankList.Items[bankList.ItemIndex].Data)^.bankRecipient := bankRecipient.Text;
    paintEntry(bankList.Items[bankList.ItemIndex], PItem(bankList.Items[bankList.ItemIndex].Data));
    recalculateDirtyFlag
  end;
end;

procedure TForm1.CoolBar1Change(Sender: TObject);
begin

end;

procedure TForm1.fileGroupClick(Sender: TObject);
begin

end;

procedure TForm1.fileSaveClick(Sender: TObject);
var
  f: file of TDataset;
  Data: TDataset;
  i: integer;
  p: PItem;
begin
  AssignFile(f, filename);
  Rewrite(f);

  for i := 0 to members.Items.Count - 1 do
  begin
    Write(f, PItem(members.Items[i].Data)^);
  end;

  for i := 0 to planList.Items.Count - 1 do
  begin
    Write(f, PItem(planList.Items[i].Data)^);
  end;

  for i := 0 to bankList.Items.Count - 1 do
  begin
    Write(f, PItem(bankList.Items[i].Data)^);
  end;

  for i := 0 to cashList.Items.Count - 1 do
  begin
    Write(f, PItem(cashList.Items[i].Data)^);
  end;

  for i := 0 to planChanges.Count - 1 do
  begin
    Write(f, PItem(planChanges.Items[i])^);
  end;
  CloseFile(f);
  lastStoredHash := CalculateDataHash; // we need this in order to mark the file as unchanged
  recalculateAllCaptions;
  newButton.enabled := true;
  recalculateDirtyFlag;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  freeMemoryUsage();
  planChanges.Free;
end;


procedure TForm1.MenuItem14Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem15Click(Sender: TObject);
begin

end;

procedure TForm1.newButtonClick(Sender: TObject);
begin
  if ((lastStoredHash <> '') AND (lastStoredHash <> CalculateDataHash)) AND (QuestionDlg('Neue Verwaltung', 'Sie haben ungespeicherte Änderungen. Sind Sie sicher?', mtConfirmation, [mrYes, 'Ja', mrCancel, 'Abbrechen'], '') = mrCancel) then
    Exit;
  filename := '';
  freeMemoryUsage();
  recalculateAllCaptions();
  newButton.enabled := false;
end;

procedure TForm1.objectControlChange(Sender: TObject);
begin
  recalculateToolbarButtons;
end;

procedure TForm1.openFileButtonClick(Sender: TObject);
var
  f: file of TDataset;
  p: PItem;
begin
  loadFileDialog.filename:='';
  if loadFileDialog.Execute then
  begin
    freeMemoryUsage(); // alte Items freigeben
    AssignFile(f, loadFileDialog.FileName);
    Reset(f);
    while not EOF(f) do
    begin
      New(p);
      FillChar(p^, SizeOf(TDataset), 0);
      Read(f, p^);
      if p^.Typ = rtMember then
        paintEntry(members.Items.Add, p);
      if p^.Typ = rtMembershipCostPlan then
      begin
        paintEntry(planList.Items.Add, p);
        MembershipChangeForm.membershipChangeAvailableCostPlanList.Items.AddObject(p^.membershipCostName, TObject(p));
        recalculateMembershipCostPlan();
      end;
      if p^.Typ = rtBankAccountMovement then
        paintEntry(bankList.Items.Add, p);
      if p^.Typ = rtCashRegisterMovement then
        paintEntry(cashList.Items.Add, p);
      if p^.Typ = rtMembershipChange then
      begin
        planChanges.add(TObject(p));
      end;
    end;
    CloseFile(f);
    filename := loadFileDialog.FileName;
    recalculateAllCaptions();
    lastStoredHash := CalculateDataHash;
    newButton.enabled := true;
    loadFileDialog.FileName:='';
  end;
end;

procedure TForm1.fileSaveAsClick(Sender: TObject);
begin
  if saveFileAsDialog.Execute then
  begin
    filename := saveFileAsDialog.FileName;
    fileSaveClick(sender);
  end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  planListSelectItem(self, nil, False);
  updateMemberForm(self, nil, False);
end;

procedure TForm1.FormResize(Sender: TObject);
begin

end;

procedure TForm1.memberChangeNumber(Sender: TObject);
begin
  if members.ItemIndex > -1 then
  begin
    PItem(members.Items[members.ItemIndex].Data)^.number := memberno.Text;
    paintEntry(members.Items[members.ItemIndex], PItem(members.Items[members.ItemIndex].Data));
    recalculateDirtyFlag;
  end;
end;

procedure TForm1.memberContactPersonChange(Sender: TObject);
begin
  if members.ItemIndex > -1 then
  begin
    PItem(members.Items[members.ItemIndex].Data)^.contactPerson := memberContactPerson.Text;
    paintEntry(members.Items[members.ItemIndex], PItem(members.Items[members.ItemIndex].Data));
    recalculateDirtyFlag;
  end;
end;

procedure TForm1.memberContactStateItemClick(Sender: TObject; Index: integer);
begin
  if members.ItemIndex > -1 then
  begin
    if memberContactState.Checked[0] then
      Include(PItem(members.Items[members.ItemIndex].Data)^.flags, anualContact)
    else
      Exclude(PItem(members.Items[members.ItemIndex].Data)^.flags, anualContact);

    if memberContactState.Checked[1] then
      Include(PItem(members.Items[members.ItemIndex].Data)^.flags, monthContact)
    else
      Exclude(PItem(members.Items[members.ItemIndex].Data)^.flags, monthContact);




    if memberContactState.Checked[2] then
      Include(PItem(members.Items[members.ItemIndex].Data)^.flags, vacation)
    else
      Exclude(PItem(members.Items[members.ItemIndex].Data)^.flags, vacation);

    if memberContactState.Checked[3] then
      Include(PItem(members.Items[members.ItemIndex].Data)^.flags, otherContact)
    else
      Exclude(PItem(members.Items[members.ItemIndex].Data)^.flags, otherContact);



    if memberContactState.Checked[4] then
      Include(PItem(members.Items[members.ItemIndex].Data)^.flags, telephone)
    else
      Exclude(PItem(members.Items[members.ItemIndex].Data)^.flags, telephone);

    if memberContactState.Checked[5] then
      Include(PItem(members.Items[members.ItemIndex].Data)^.flags, eMail)
    else
      Exclude(PItem(members.Items[members.ItemIndex].Data)^.flags, eMail);


    if memberContactState.Checked[6] then
      Include(PItem(members.Items[members.ItemIndex].Data)^.flags, postal)
    else
      Exclude(PItem(members.Items[members.ItemIndex].Data)^.flags, postal);

    if memberContactState.Checked[7] then
      Include(PItem(members.Items[members.ItemIndex].Data)^.flags, sms)
    else
      Exclude(PItem(members.Items[members.ItemIndex].Data)^.flags, sms);


    if memberContactState.Checked[8] then
      Include(PItem(members.Items[members.ItemIndex].Data)^.flags, messenger)
    else
      Exclude(PItem(members.Items[members.ItemIndex].Data)^.flags, messenger);

    if memberContactState.Checked[9] then
      Include(PItem(members.Items[members.ItemIndex].Data)^.flags, contactPerson)
    else
      Exclude(PItem(members.Items[members.ItemIndex].Data)^.flags, contactPerson);


    if memberContactState.Checked[10] then
      Include(PItem(members.Items[members.ItemIndex].Data)^.flags, newsletter)
    else
      Exclude(PItem(members.Items[members.ItemIndex].Data)^.flags, newsletter);

    paintEntry(members.Items[members.ItemIndex], PItem(members.Items[members.ItemIndex].Data));
    recalculateDirtyFlag;
  end;
end;

procedure TForm1.memberLastContactChange(Sender: TObject);
begin
  if IsDateTime(memberLastContact.Text) and (members.ItemIndex > -1) then
  begin
    PItem(members.Items[members.ItemIndex].Data)^.lastContact := StrToDateTime(memberLastContact.Text);
    paintEntry(members.Items[members.ItemIndex], PItem(members.Items[members.ItemIndex].Data));
    recalculateDirtyFlag;
  end;
end;

procedure TForm1.memberMembershipCostPlanComboChange(Sender: TObject);
var
  combo, pricing: PItem;
begin
  if (members.ItemIndex > -1) and (memberMembershipCostPlanCombo.ItemIndex > -1) then
  begin
    combo := PItem(members.Items[members.ItemIndex].Data);
    pricing := PItem(memberMembershipCostPlanCombo.Items.Objects[memberMembershipCostPlanCombo.ItemIndex]);
    combo^.pricePlan := pricing^.id;
    paintEntry(members.Items[members.ItemIndex], PItem(members.Items[members.ItemIndex].Data));
    recalculateDirtyFlag;
  end;
end;

procedure TForm1.memberMemoChange(Sender: TObject);
begin
  if members.ItemIndex > -1 then
  begin
    StrPLCopy(PItem(members.Items[members.ItemIndex].Data)^.remarks, memberMemo.Text, REMARK_SIZE);
    paintEntry(members.Items[members.ItemIndex], PItem(members.Items[members.ItemIndex].Data));
    recalculateDirtyFlag
  end;
end;

procedure TForm1.memberRemoveClick(Sender: TObject);
var i: integer;
    no: string;
begin
  if members.ItemIndex > -1 then
  begin
    no := PItem(members.Items[members.ItemIndex].Data)^.number;
    Dispose(PItem(members.Items[members.ItemIndex].Data));
    members.items[members.ItemIndex].Delete;
    for i := planChanges.Count -1 downto 0 do
    begin
      if PItem(planChanges.Items[i])^.memberNumber = no then
      begin
        Dispose(PItem(planChanges.Items[i]));
        planChanges.Delete(i);
      end;
    end;
    recalculateDirtyFlag
  end;
end;

procedure TForm1.membershipCostPlanAgeChange(Sender: TObject);
begin
  if (planList.ItemIndex > -1) and IsInt(membershipCostPlanAge.Text) then
  begin
    PItem(planList.Items[planList.ItemIndex].Data)^.ageFrom := StrToInt(membershipCostPlanAge.Text);
    paintEntry(planList.Items[planList.ItemIndex], PItem(planList.Items[planList.ItemIndex].Data));
    recalculateDirtyFlag
  end;
end;

procedure TForm1.membershipCostPlanAmountChange(Sender: TObject);
begin
  if (planList.ItemIndex > -1) and IsFloat(membershipCostPlanAmount.Text) then
  begin
    PItem(planList.Items[planList.ItemIndex].Data)^.planAmountCent := Round(StrToFloat(membershipCostPlanAmount.Text) * 100);
    paintEntry(planList.Items[planList.ItemIndex], PItem(planList.Items[planList.ItemIndex].Data));
    recalculateDirtyFlag
  end;

end;

procedure TForm1.planListChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  recalculateMembershipCostPlan();
end;


procedure TForm1.membershipfeeChange(Sender: TObject);
begin
  if members.ItemIndex > -1 then
  begin
    try
      PItem(members.Items[members.ItemIndex].Data)^.overallPayedCents := Round(StrToFloat(membershipfee.Text) * 100);
      paintEntry(members.Items[members.ItemIndex], PItem(members.Items[members.ItemIndex].Data));
      recalculateDirtyFlag;
    except
    end;
  end;
end;

procedure addCash(Value: double);
var
  newItem: PItem;
begin
  New(newItem);
  FillChar(newItem^, SizeOf(TDataset), 0);
  with newItem^ do
  begin
    Typ := rtCashRegisterMovement;
    cashMovementNo := '';
    cashAmountCentIncomming := Round(Value * 100);
    cashCategory := IfThen(Value > 0, 'Spendeneingang', 'Kopierkosten');
    cashObject := IfThen(Value > 0, 'Spendendose', 'Kopien');
    cashRecipient := IfThen(Value > 0, 'Passanten', 'Copyshop');
    cashMovementDate := Now;
    cashChecked := False;
    cashSmallDescription := 'Straßenfest';
    StrPLCopy(cashRemarks, IfThen(Value > 0, 'Einnahmen aus einer Spendensammlung', 'Ausgaben für Öffentlichkeitsarbeit'), REMARK_SIZE);

  end;
  paintEntry(Form1.cashList.Items.Add, newItem);
  Form1.recalculateAllCaptions();
end;

procedure addBank(Value: double);
var
  newItem: PItem;
begin
  New(newItem);
  FillChar(newItem^, SizeOf(TDataset), 0);
  with newItem^ do
  begin
    Typ := rtBankAccountMovement;
    bankDesc := '';
    bankRemarks[0] := #0;
    bankChangeCent := Round(Value * 100);
    bankRecipient := '';
    bankExecutionDate := Now;
    bankMovementNo := '';
    bankMovementChecked := False;
  end;
  paintEntry(Form1.bankList.Items.Add, newItem);
  Form1.recalculateAllCaptions();
end;

procedure TForm1.addIncomingCash(Sender: TObject);
var
  Value: string;
begin
  if DefaultInputDialog('Bar-Einzahlung', 'Wie hoch ist die Bareinzahlung?', False, Value) then
  begin
    if IsFloat(Value) then
    begin
      addCash(StrToFloat(Value));
      cashList.ItemIndex := cashList.Items.Count - 1;
      cashMoveNo.SetFocus;
      recalculateDirtyFlag
    end;
  end;
end;

procedure TForm1.membershipPayClick(Sender: TObject);
var s: string;
    val: double;
    item: PItem;
begin
  val := 0;
  repeat
    if not InputQuery('Mitgliedbeitrag', 'Beitragseinzahlungshöhe:', s) then
      Exit;
    if TryStrToFloat(s, val) then
      Break;
    if QuestionDlg('Wert unverständlich', 'Ich konnte den Betrag "'+s+'" nicht verstehen. Wiederholen?', mtConfirmation, [mrYes, 'Ja', mrNo, 'Nein'], '') = mrNo then
      Exit;
  until false;
  item := PItem(members.Items[members.ItemIndex].Data);
  item^.overallPayedCents := item^.overallPayedCents + Round(StrToFloat(s)*100);
  recalculateDirtyFlag
end;

procedure TForm1.moveBankToCashClick(Sender: TObject);
var
  s: string;
  val, nowvalue: TDateTime;
  amount: Double;
  move : PItem;
begin
  val := Now;
  repeat
    if not InputQuery('Abhebung von Konto', 'Wann wurde der Betrag vom Konto abgehoben?', s) then
      Exit;
    if TryStrToDateTime(s, val) then
      Break;
    if QuestionDlg('Datum unverständlich', 'Ich konnte das Datum "'+s+'" nicht lesen. Wiederholen?', mtConfirmation, [mrYes, 'Ja', mrNo, 'Nein'], '') = mrNo then
      Exit;
  until false;
  val := StrToDateTime(s);
  repeat
    if not InputQuery('Höhe der Abhebung', 'Wieviel wurde abgehoben?', s) then
      Exit;
    if IsFloat(s) then
      Break;
    if QuestionDlg('Wert unverständlich', 'Ich konnte den Abhebungsbetrag "'+s+'" nicht verstehen. Wiederholen?', mtConfirmation, [mrYes, 'Ja', mrNo, 'Nein'], '') = mrNo then
      Exit;
  until false;
  amount := StrToFloat(s);

  if QuestionDlg('Prüfung', 'Es soll also am '+DateTimeToStr(val)+' vom Vereinskonto ein Betrag von '+FormatFloat(AMOUNT_FORMAT, amount)+' abgehoben und in die Barkasse gelegt werden. Richtig?', mtConfirmation, [mrYes, 'Ja', mrCancel, 'Abbrechen'], '') = mrCancel then
    Exit;

  nowvalue:=now;

  // abhebung
  new(Move);
  FillChar(move^, SizeOf(TDataset), 0);
  move^.Typ:=rtBankAccountMovement;  // abhebung oder einzahlung
  move^.bankRemarks:='Abhebung am '+ DateTimeToStr(nowvalue);
  move^.bankDesc := 'Abhebung zur Barkasse';
  move^.bankChangeCent := -Round(amount*100);
  move^.bankRecipient:='Vereinsbarkasse';
  move^.bankExecutionDate :=val;
  move^.bankMovementNo:='';
  move^.bankMovementChecked:=false;
  paintEntry(Form1.bankList.Items.Add, move);

  // einzahlung
  new(Move);
  FillChar(move^, SizeOf(TDataset), 0);
  move^.Typ:=rtCashRegisterMovement;  // abhebung oder einzahlung
  move^.cashAmountCentIncomming:=Round(amount *100);
  move^.cashCategory := 'Transfer';
  move^.cashObject := 'Vereinskonto';
  move^.cashRecipient:='Vereinsbankkonto';
  move^.cashMovementDate:=val;
  move^.cashChecked := false;
  move^.cashSmallDescription:='Abhebung von Vereinskonto in Barkasse.';
  move^.cashRemarks:='Eingetragen am ' + DateTimeToStr(nowvalue);
  paintEntry(Form1.cashList.Items.Add, move);
  recalculateDirtyFlag
end;

procedure TForm1.moveCashToBankClick(Sender: TObject);
var
  s: string;
  val, nowvalue: TDateTime;
  amount: Double;
  move : PItem;
begin
  val := Now;
  repeat
    if not InputQuery('Einzahlung von Barkonto', 'Wann wurde der Betrag auf das Konto eingezahlt?', s) then
      Exit;
    if TryStrToDateTime(s, val) then
      Break;
    if QuestionDlg('Datum unverständlich', 'Ich konnte das Datum "'+s+'" nicht lesen. Wiederholen?', mtConfirmation, [mrYes, 'Ja', mrNo, 'Nein'], '') = mrNo then
      Exit;
  until false;
  val := StrToDateTime(s);
  repeat
    if not InputQuery('Höhe der Einzahlung', 'Wieviel wurde eingezahlt?', s) then
      Exit;
    if IsFloat(s) then
      Break;
    if QuestionDlg('Wert unverständlich', 'Ich konnte den Einzahlungsbetrag "'+s+'" nicht verstehen. Wiederholen?', mtConfirmation, [mrYes, 'Ja', mrNo, 'Nein'], '') = mrNo then
      Exit;
  until false;
  amount := StrToFloat(s);

  if QuestionDlg('Prüfung', 'Es soll also am '+DateTimeToStr(val)+' von der Vereinsbarkasse ein Betrag von '+FormatFloat(AMOUNT_FORMAT, amount)+' entnommen und in das Vereinskonto eingezahlt werden. Richtig?', mtConfirmation, [mrYes, 'Ja', mrCancel, 'Abbrechen'], '') = mrCancel then
    Exit;

  nowvalue:=now;

  // einzahlung
  new(Move);
  FillChar(move^, SizeOf(TDataset), 0);
  move^.Typ:=rtBankAccountMovement;  // abhebung oder einzahlung
  move^.bankRemarks:='Einzahlung am '+ DateTimeToStr(nowvalue);
  move^.bankDesc := 'Einzahlung von Barkasse';
  move^.bankChangeCent := Round(amount*100);
  move^.bankRecipient:='Vereinsbarkasse';
  move^.bankExecutionDate :=val;
  move^.bankMovementNo:='';
  move^.bankMovementChecked:=false;
  paintEntry(Form1.bankList.Items.Add, move);

  // entnahme
  new(Move);
  FillChar(move^, SizeOf(TDataset), 0);
  move^.Typ:=rtCashRegisterMovement;  // abhebung oder einzahlung
  move^.cashAmountCentIncomming:=-Round(amount *100);
  move^.cashCategory := 'Einzahlung';
  move^.cashObject := 'Vereinsbarkasse';
  move^.cashRecipient:='Vereinsbarkasse';
  move^.cashMovementDate:=val;
  move^.cashChecked := false;
  move^.cashSmallDescription:='Einzahlung auf Vereinskonto von Barkasse.';
  move^.cashRemarks:='Eingetragen am ' + DateTimeToStr(nowvalue);
  paintEntry(Form1.cashList.Items.Add, move);
  recalculateDirtyFlag
end;

procedure TForm1.removeButtonClick(Sender: TObject);
begin
  if (objectControl.ActivePage = cashSheet) AND (cashList.ItemIndex > -1) then
    removeCashMoveClick(sender)
  else if (objectControl.ActivePage = bankSheet) AND (bankList.ItemIndex > -1) then
    removeBankMovementClick(sender)
  else if (objectControl.ActivePage = memberSheet) AND (members.ItemIndex > -1) then
    memberRemoveClick(sender)
  else if (objectControl.ActivePage = membershipCostPlan) AND (planList.ItemIndex > -1) then
    memberRemoveClick(sender);
end;

procedure TForm1.removeCashMoveClick(Sender: TObject);
begin
  if cashList.ItemIndex > -1 then
  begin
    Dispose(PItem(cashList.Items[cashList.ItemIndex].Data));
    cashList.items[cashList.ItemIndex].Delete;
    recalculateDirtyFlag
  end;
end;



procedure TForm1.memberAddClick(Sender: TObject);
var
  newItem: PItem;
  since: string;
begin
  repeat
    if not DefaultInputDialog('Mitglied seit', 'Wann war der erste Tag der Mitgliedschaft?' + LineEnding  + 'Es werden nur volle Monate berechnet,' +
      LineEnding  + 'es wird also automatisch der erste' + LineEnding  + 'des Monats genommen.', False, since) then
      break;
  until TryParseDate(since);
  New(newItem);
  FillChar(newItem^, SizeOf(TDataset), 0);
  with newItem^ do
  begin
    Typ := rtMember;
    number := '';
    overallPayedCents := 0;
    lastContact := Now;
    memberSince := StrToDate(since);
    contactPerson := '';
    remarks := 'Ein neues Mitglied!';
    flags := [monthContact];
    paintEntry(members.Items.Add, newItem);
  end;
  members.ItemIndex := members.Items.Count - 1;
  memberno.SetFocus;
  recalculateDirtyFlag
end;

procedure TForm1.addBankMovementClick(Sender: TObject);
var
  Value: string;
begin
  if DefaultInputDialog('Konto Bewegung', 'Wie hoch ist die Wertänderung gegenüber dem Konto? ' + LineEnding  + 'Positiv für Einzahlung, negativ für Auszahlung.',
    False, Value) then
  begin
    if IsFloat(Value) then
    begin
      addBank(StrToFloat(Value));
      bankList.ItemIndex := bankList.Items.Count - 1;
      bankDesc.SetFocus;
      recalculateDirtyFlag
    end;
  end;
end;

procedure TForm1.removeBankMovementClick(Sender: TObject);
begin
  if bankList.ItemIndex > -1 then
  begin
    Dispose(PItem(bankList.Items[bankList.ItemIndex].Data));
    bankList.items[bankList.ItemIndex].Delete;
    recalculateDirtyFlag
  end;
end;

procedure TForm1.addCashOutClick(Sender: TObject);
var
  Value: string;
begin
  if DefaultInputDialog('Bar-Auszahlung', 'Wie hoch ist die Barauszahlung?', False, Value) then
  begin
    if IsFloat(Value) then
    begin
      addCash(-StrToFloat(Value));
      cashList.ItemIndex := cashList.Items.Count - 1;
      cashMoveNo.SetFocus;
      recalculateDirtyFlag
    end;
  end;
end;

procedure TForm1.recalculateCash(Sender: TObject; Item: TListItem);
begin
  recalculateAllCaptions();
end;

procedure TForm1.selectCashMove(Sender: TObject; Item: TListItem; Selected: boolean);
var
  enable: boolean;
begin
  enable := cashList.ItemIndex > -1;
  cashChangeCent.Enabled := enable;
  cashMoveNo.Enabled := enable;
  cashCategory.Enabled := enable;
  cashSubject.Enabled := enable;
  cashRecipient.Enabled := enable;
  cashDate.Enabled := enable;
  cashChecked.Enabled := enable;
  cashShortDescription.Enabled := enable;
  cashDescription.Enabled := enable;
  cashHistory.Enabled := enable;

  addCashIn.Enabled:=not enable;
  addCashOut.Enabled:=not enable;
  removeCashMove.Enabled:=enable;
  moveCashToBank.Enabled:=not enable;
  cloneCashMove.Enabled:=enable;

  if not enable then
  begin
    cashChangeCent.Text := '';
    cashMoveNo.Text := '';
    cashCategory.Text := '';
    cashSubject.Text := '';
    cashRecipient.Text := '';
    cashDate.Text := '';
    cashChecked.Checked := False;
    cashShortDescription.Text := '';
    cashDescription.Text := '';
    cashHistory.Clear;
  end
  else
    with PItem(cashList.Items[cashList.ItemIndex].Data)^ do
    begin
      cashChangeCent.Text := FormatFloat(AMOUNT_FORMAT, cashAmountCentIncomming / 100);
      cashMoveNo.Text := cashMovementNo;
      form1.cashCategory.Text := cashCategory;
      cashSubject.Text := cashObject;
      form1.cashRecipient.Text := cashRecipient;
      cashDate.Text := DateTimeToStr(cashMovementDate);
      form1.cashChecked.Checked := cashChecked;
      cashShortDescription.Text := cashSmallDescription;
      cashDescription.Text := cashRemarks;
      recalculateAllCaptions;
    end;
  recalculateToolbarButtons;
end;

procedure TForm1.statisticGraphClick(Sender: TObject);
begin

end;
procedure TForm1.statisticGraphPaint(Sender: TObject);
const
  MONTHS_HISTORY = 6;
  MONTHS_FORECAST = 3;
var

  bmp: TPaintBox;
  c: TCanvas;

  startDate: TDate;
  totalMonths: Integer;

  bankSeries: array of Double;
  cashSeries: array of Double;

  i, m: Integer;

  minVal, maxVal: Double;
  scaleY: Double;

  leftMargin, bottomMargin, topMargin, rightMargin: Integer;
  w, h: Integer;

  function MonthIndex(d: TDateTime): Integer;
  begin
    Result := MonthsBetweenDates(startDate, DateOf(d));
  end;

  procedure CollectData;
  var
    i, idx: Integer;
  begin
    for i := 0 to cashList.Items.Count-1 do
    begin
      idx := MonthIndex(PItem(cashList.Items[i].Data)^.cashMovementDate);
      if (idx >= 0) and (idx < totalMonths) then
        cashSeries[idx] := cashSeries[idx] +
          PItem(cashList.Items[i].Data)^.cashAmountCentIncomming / 100;
    end;

    for i := 0 to bankList.Items.Count-1 do
    begin
      idx := MonthIndex(PItem(bankList.Items[i].Data)^.bankExecutionDate);
      if (idx >= 0) and (idx < totalMonths) then
        bankSeries[idx] := bankSeries[idx] +
          PItem(bankList.Items[i].Data)^.bankChangeCent / 100;
    end;

    for i := 1 to totalMonths-1 do
    begin
      bankSeries[i] := bankSeries[i] + bankSeries[i-1];
      cashSeries[i] := cashSeries[i] + cashSeries[i-1];
    end;
  end;

  procedure Forecast;
  var
    avgBank, avgCash: Double;   i:integer;
  begin
    avgBank := (bankSeries[MONTHS_HISTORY-1] - bankSeries[0]) / MONTHS_HISTORY;
    avgCash := (cashSeries[MONTHS_HISTORY-1] - cashSeries[0]) / MONTHS_HISTORY;

    for i := MONTHS_HISTORY to totalMonths-1 do
    begin
      bankSeries[i] := bankSeries[i-1] + avgBank;
      cashSeries[i] := cashSeries[i-1] + avgCash;
    end;
  end;

  procedure FindMinMax;
  var i:integer;
  begin
    minVal := 1e18;
    maxVal := -1e18;
    for i := 0 to totalMonths-1 do
    begin
      minVal := Min(minVal, bankSeries[i]);
      minVal := Min(minVal, cashSeries[i]);
      maxVal := Max(maxVal, bankSeries[i]);
      maxVal := Max(maxVal, cashSeries[i]);
    end;
  end;

  procedure DrawGrid;
  var
    y,i: Integer;
    val: Double;
    step: Double;
  begin
    c.Pen.Color := clSilver;

    step := (maxVal - minVal) / 5;

    for i := 0 to 5 do
    begin
      val := minVal + step*i;
      y := topMargin + Round((maxVal-val)*scaleY);

      c.MoveTo(leftMargin, y);
      c.LineTo(w-rightMargin, y);

      c.TextOut(5, y-8, FormatFloat('#,##0', val));
    end;
  end;

  procedure DrawXAxis;
  var
    x,i: Integer;
    d: TDate;
  begin
    for i := 0 to totalMonths-1 do
    begin
      x := leftMargin + Round((w-leftMargin-rightMargin)*(i/(totalMonths-1)));

      d := IncMonth(startDate, i);

      c.TextOut(
        x-20,
        h-bottomMargin+5,
        FormatDateTime('yyyy-mm', d)
      );
    end;
  end;

  procedure DrawSeries(series: array of Double; color: TColor; dashed: Boolean);
  var
    x, y,i: Integer;
  begin
    c.Pen.Color := color;

    if dashed then
      c.Pen.Style := psDash
    else
      c.Pen.Style := psSolid;

    for i := 0 to totalMonths-1 do
    begin
      x := leftMargin + Round((w-leftMargin-rightMargin)*(i/(totalMonths-1)));
      y := topMargin + Round((maxVal-series[i])*scaleY);

      if i=0 then
        c.MoveTo(x,y)
      else
        c.LineTo(x,y);
    end;
  end;

  procedure DrawLegend;
  begin
    c.Pen.Style := psSolid;

    c.Brush.Style := bsClear;

    c.Font.Style := [];

    c.Pen.Color := clOrange;
    c.MoveTo(leftMargin,10);
    c.LineTo(leftMargin+20,10);
    c.TextOut(leftMargin+25,2,'Bankkonto');

    c.Pen.Color := clGreen;
    c.MoveTo(leftMargin,25);
    c.LineTo(leftMargin+20,25);
    c.TextOut(leftMargin+25,17,'Barkasse');

    c.Pen.Color := clRed;
    c.Pen.Style := psDash;
    c.MoveTo(leftMargin,40);
    c.LineTo(leftMargin+20,40);
    c.TextOut(leftMargin+25,32,'Vorhersage');
  end;

begin
  bmp := statisticGraph;
  c := bmp.Canvas;

  w := bmp.Width;
  h := bmp.Height;

  leftMargin := 70;
  bottomMargin := 50;
  topMargin := 50;
  rightMargin := 20;

  c.Brush.Color := clWhite;
  c.FillRect(0,0,w,h);

  startDate := StartOfTheMonth(IncMonth(Date,-MONTHS_HISTORY+1));
  totalMonths := MONTHS_HISTORY + MONTHS_FORECAST;

  SetLength(bankSeries, totalMonths);
  SetLength(cashSeries, totalMonths);

  CollectData;
  Forecast;
  FindMinMax;

  if maxVal = minVal then
    maxVal := minVal + 1;

  scaleY := (h-topMargin-bottomMargin)/(maxVal-minVal);

  DrawGrid;
  DrawXAxis;

  DrawSeries(bankSeries, clOrange, False);
  DrawSeries(cashSeries, clGreen, False);

  DrawSeries(bankSeries, clRed, True);
  DrawSeries(cashSeries, clRed, True);

  DrawLegend;
end;


procedure TForm1.updateMemberForm(Sender: TObject; Item: TListItem; Selected: boolean);
var
  enable: boolean;
  i: integer;
  combo, list: PItem;
begin
  enable := members.ItemIndex > -1;
  memberno.Enabled := enable;
  membershipfee.Enabled := enable;
  memberLastContact.Enabled := enable;
  memberContactPerson.Enabled := enable;
  memberMembershipCostPlanCombo.Enabled := enable;
  memberContactPerson.Enabled := enable;
  memberContactState.Enabled := enable;
  memberMemo.Enabled := enable;
  memberMembershipCostPlanLabel.Enabled := enable;
  memberMemoLabel.Enabled := enable;
  memberAdd.Enabled:=not enable;
  memberRemove.Enabled := enable;
  membershipPay.Enabled:=Enable;
  addHistoricMembershipChange.Enabled:=enable;

  if not enable then
  begin
    memberno.Text := '';
    membershipfee.Text := '';
    memberLastContact.Text := '';
    memberContactPerson.Text := '';
    //    memberMembershipCostPlanCombo.Enabled:= enable;
    memberContactPerson.Text := '';
    for i := 0 to memberContactState.Items.Count - 1 do
      memberContactState.Checked[i] := False;
    memberMemo.Text := '';
  end
  else
  begin
    with PItem(members.Items[members.ItemIndex].Data)^ do
    begin
      memberno.Text := number;
      membershipfee.Text := FormatFloat(AMOUNT_FORMAT, overallPayedCents / 100);
      memberLastContact.Text := DateTimeToStr(lastContact);
      memberContactPerson.Text := contactPerson;
      //    memberMembershipCostPlanCombo.Enabled:= enable;

      for i := 0 to memberContactState.Items.Count - 1 do
        memberContactState.Checked[i] := False;
      memberMemo.Text := StrPas(@remarks);
      memberContactState.Checked[0] := anualContact in flags;
      memberContactState.Checked[1] := monthContact in flags;
      memberContactState.Checked[2] := vacation in flags;
      memberContactState.Checked[3] := otherContact in flags;
      memberContactState.Checked[4] := telephone in flags;
      memberContactState.Checked[5] := eMail in flags;
      memberContactState.Checked[6] := postal in flags;
      memberContactState.Checked[7] := sms in flags;
      memberContactState.Checked[8] := messenger in flags;
      memberContactState.Checked[9] := TMemberFlags.contactPerson in flags;
      memberContactState.Checked[10] := newsletter in flags;


      for i := 0 to memberMembershipCostPlanCombo.Items.Count - 1 do
      begin
        if PItem(memberMembershipCostPlanCombo.Items.Objects[i])^.id.ToString(True) = pricePlan.ToString(True) then
          memberMembershipCostPlanCombo.ItemIndex := i;
      end;

    end;
  end;
  recalculateToolbarButtons;
end;


procedure TForm1.planListSelectItem(Sender: TObject; Item: TListItem; Selected: boolean);
var
  enable: boolean;
begin
  enable := planList.ItemIndex > -1;
  membershipCostPlanName.Enabled := enable;
  membershipCostPlanAge.Enabled := enable;
  membershipCostPlanAmount.Enabled := enable;
  if not enable then
  begin
    membershipCostPlanName.Text := '';
    membershipCostPlanAge.Text := '';
    membershipCostPlanAmount.Text := '';
  end
  else
  begin
    with PItem(planList.Items[planList.ItemIndex].Data)^ do
    begin
      membershipCostPlanName.Text := membershipCostName;
      membershipCostPlanAge.Text := IntToStr(ageFrom);
      membershipCostPlanAmount.Text := FormatFloat(AMOUNT_FORMAT, planAmountCent / 100);
    end;
  end;
  recalculateToolbarButtons;
end;

procedure TForm1.membershipCostPlanNameChange(Sender: TObject);
begin
  if planList.ItemIndex > -1 then
  begin
    PItem(planList.Items[planList.ItemIndex].Data)^.membershipCostName := membershipCostPlanName.Text;
    paintEntry(planList.Items[planList.ItemIndex], PItem(planList.Items[planList.ItemIndex].Data));
    recalculateDirtyFlag
  end;
end;

procedure TForm1.MenuItem13Click(Sender: TObject);
var
  newItem: PItem;
  age, amount: string;
  mname: string;
begin
  age := '18';
  mname := 'Vollverdiener';
  amount := '10,00';
  if DefaultInputDialog('Alter', 'Ab wieviel Jahren (Inklusive)', False, age) then
  begin
    StrToInt(age);
    if DefaultInputDialog('Name', 'Wie soll der Beitragssatz heißen (Ab ' + age + ' Jahren)?', False, mname) then
    begin
      if DefaultInputDialog('Beitragshöhe', 'Wie hoch ist der Beitragssatz?', False, amount) then
      begin
        StrToFloat(amount);
        New(newItem);
        FillChar(newItem^, SizeOf(TDataset), 0);
        newItem^.Typ := rtMembershipCostPlan;
        newItem^.ageFrom := StrToInt(age);
        newItem^.membershipCostName := mname;
        newItem^.planAmountCent := Round(StrToFloat(amount) * 100);
        uuid_create(newItem^.id);
        with planList.Items.Add do
        begin
          Data := TObject(newItem);
          Caption := newItem^.membershipCostName;
          SubItems.Add(age);
          SubItems.Add(amount);
        end;
        planList.ItemIndex := planList.Items.Count - 1;
        membershipCostPlanName.SetFocus;
        recalculateDirtyFlag
      end;
    end;
  end;
end;
function TForm1.CalculateDataHash: string;
var
  ctx: TMD5Context;
  digest: TMD5Digest;
  i: Integer;
  p: PItem;

  procedure MD5UpdateString(const s: string);
  var
    b: TBytes;
  begin
    b := TEncoding.UTF8.GetBytes(s);
    if Length(b) > 0 then
      MD5Update(ctx, b[0], Length(b));
  end;

  procedure MD5UpdateFixedString(const s: string; maxLen: Integer);
  var
    actual: string;
  begin
    actual := Copy(s, 1, maxLen);
    MD5UpdateString(actual);
  end;

  procedure UpdateMember(data: PItem);
  begin
    MD5UpdateString(data^.number);
    MD5Update(ctx, data^.overallPayedCents, SizeOf(data^.overallPayedCents));
    MD5Update(ctx, data^.memberSince, SizeOf(data^.memberSince));
    MD5Update(ctx, data^.lastContact, SizeOf(data^.lastContact));
    MD5UpdateString(data^.contactPerson);
    MD5UpdateString(data^.remarks);
    MD5Update(ctx, data^.flags, SizeOf(data^.flags));
    MD5Update(ctx, data^.pricePlan, SizeOf(data^.pricePlan));
  end;

  procedure UpdateMembershipCostPlan(data: PItem);
  begin
    MD5UpdateString(data^.membershipCostName);
    MD5Update(ctx, data^.ageFrom, SizeOf(data^.ageFrom));
    MD5Update(ctx, data^.planAmountCent, SizeOf(data^.planAmountCent));
    MD5Update(ctx, data^.id, SizeOf(data^.id));
  end;

  procedure UpdateBankMovement(data: PItem);
  begin
    MD5UpdateString(data^.bankDesc);
    MD5UpdateString(data^.bankRemarks);
    MD5Update(ctx, data^.bankChangeCent, SizeOf(data^.bankChangeCent));
    MD5UpdateString(data^.bankRecipient);
    MD5Update(ctx, data^.bankExecutionDate, SizeOf(data^.bankExecutionDate));
    MD5UpdateString(data^.bankMovementNo);
    MD5Update(ctx, data^.bankMovementChecked, SizeOf(data^.bankMovementChecked));
  end;

  procedure UpdateCashMovement(data: PItem);
  begin
    MD5UpdateString(data^.cashMovementNo);
    MD5Update(ctx, data^.cashAmountCentIncomming, SizeOf(data^.cashAmountCentIncomming));
    MD5UpdateString(data^.cashCategory);
    MD5UpdateString(data^.cashObject);
    MD5UpdateString(data^.cashRecipient);
    MD5Update(ctx, data^.cashMovementDate, SizeOf(data^.cashMovementDate));
    MD5Update(ctx, data^.cashChecked, SizeOf(data^.cashChecked));
    MD5UpdateString(data^.cashSmallDescription);
    MD5UpdateString(data^.cashRemarks);
  end;

  procedure UpdateMembershipChange(data: PItem);
  begin
    MD5UpdateString(data^.memberNumber);
    MD5Update(ctx, data^.newPricePlan, SizeOf(data^.newPricePlan));
    MD5Update(ctx, data^.changedSince, SizeOf(data^.changedSince));
  end;

begin
  MD5Init(ctx);
  for i := 0 to members.Items.Count - 1 do
  begin
    p := PItem(members.Items[i].Data);
    UpdateMember(p);
  end;
  for i := 0 to planList.Items.Count - 1 do
  begin
    p := PItem(planList.Items[i].Data);
    UpdateMembershipCostPlan(p);
  end;
  for i := 0 to bankList.Items.Count - 1 do
  begin
    p := PItem(bankList.Items[i].Data);
    UpdateBankMovement(p);
  end;
  for i := 0 to cashList.Items.Count - 1 do
  begin
    p := PItem(cashList.Items[i].Data);
    UpdateCashMovement(p);
  end;
  for i := 0 to planChanges.Count - 1 do
  begin
    p := PItem(planChanges[i]);
    UpdateMembershipChange(p);
  end;
  MD5Final(ctx, digest);
  Result := MD5Print(digest);
end;
procedure TForm1.recalculateDirtyFlag();
var dirty, hasFlag: boolean;
begin
  dirty := (lastStoredHash <> '') AND (lastStoredHash <> CalculateDataHash);
  hasFlag := (Length(Caption) > 0) AND (Caption[Length(Caption)] = '*');
  if dirty AND not hasFlag then
    Caption := Caption + ' *';
  if hasFlag AND NOT dirty then
    Caption := Copy(Caption,1, Length(Caption) - 2);
  fileSave.Enabled := dirty;
end;

procedure TForm1.recalculateToolbarButtons();
var enable:boolean;
begin
  enable := false;
  if objectControl.ActivePage = cashSheet then
    enable := cashList.ItemIndex > -1
  else if objectControl.ActivePage = bankSheet then
    enable := bankList.ItemIndex > -1
  else if objectControl.ActivePage = memberSheet then
    enable := members.ItemIndex > -1
  else if objectControl.ActivePage = membershipCostPlan then
    enable := planList.ItemIndex > -1;
  addButton.Enabled:=not enable;
  removeButton.Enabled:=enable;
end;

end.
