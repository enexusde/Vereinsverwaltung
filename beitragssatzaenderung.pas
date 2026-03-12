unit beitragssatzaenderung;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Calendar, Buttons, uuid, DateUtils;

type

  { TMembershipChangeForm }

  TMembershipChangeForm = class(TForm)
    infoPanel: TBevel;
    save: TBitBtn;
    cancel: TBitBtn;
    changeIcon: TImage;
    hints: TLabel;
    membershipChangeDateLabel: TLabel;
    membershipCostPlanChangeDate: TCalendar;
    membershipChangeCostPlanLabel: TLabel;
    membershipChangeMemberNo: TLabeledEdit;
    membershipChangeAvailableCostPlanList: TListBox;
  private

  public
    procedure limit(memberNo: String);
    procedure fill(var outDate:TDate; var pricePlan: TObject);
  end;

var
  MembershipChangeForm: TMembershipChangeForm;

implementation

{$R *.lfm}

{ TMembershipChangeForm }
procedure TMembershipChangeForm.fill(var outDate:TDate; var pricePlan: TObject);
begin
  outDate := membershipCostPlanChangeDate.DateTime;
  outDate := EncodeDate(YearOf(outDate), MonthOf(outDate), 1);
  pricePlan := membershipChangeAvailableCostPlanList.Items.Objects[membershipChangeAvailableCostPlanList.ItemIndex];
end;

procedure TMembershipChangeForm.limit(memberNo: String);
begin
  membershipChangeMemberNo.Text:=memberNo;
end;


end.

