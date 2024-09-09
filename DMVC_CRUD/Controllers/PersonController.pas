unit PersonController;

interface

uses
  MVCFramework, MVCFramework.Commons, MVCFramework.Serializer.Commons, System.Generics.Collections,PersonModel,MVCFramework.SQLGenerators.MSSQL;

type
  [MVCPath('/api')]
  TPersonController = class(TMVCController)
  public

    [MVCPath('/people')]
    [MVCHTTPMethod([httpGET])]
    function GetPeople: TObjectList<TPerson>;

    [MVCPath('/people/($ID)')]
    [MVCHTTPMethod([httpGET])]
    function GetPerson(ID: Integer): TPerson;

    [MVCPath('/people')]
    [MVCHTTPMethod([httpPOST])]
    function CreatePerson([MVCFromBody] Person: TPerson): IMVCResponse;

    [MVCPath('/people')]
    [MVCHTTPMethod([httpPUT])]
    function UpdatePerson([MVCFromBody] Person: TPerson): IMVCResponse;

    [MVCPath('/people/($ID)')]
    [MVCHTTPMethod([httpDELETE])]
    function DeletePerson(ID: Integer): IMVCResponse;

  end;

implementation

uses
  System.SysUtils, MVCFramework.Logger, System.StrUtils,MVCFramework.ActiveRecord;

function TPersonController.GetPeople: TObjectList<TPerson>;
begin
   Result := TObjectList<TPerson>.Create(True);
  try
   Result.AddRange(TMVCActiveRecord.SelectRQL<TPerson>('',100));
  except
  end;
end;

function TPersonController.GetPerson(ID: Integer): TPerson;
begin
  Result :=  TMVCActiveRecord.GetByPK<TPerson>(ID);
end;

function TPersonController.CreatePerson([MVCFromBody] Person: TPerson): IMVCResponse;
begin
  Person.Insert;
  Render201Created('/Person/' + Person.ID.ToString);
end;

function TPersonController.UpdatePerson([MVCFromBody] Person: TPerson): IMVCResponse;
begin
  var personold := TMVCActiveRecord.GetByPK<TPerson>(Person.ID);
  try
    Context.Request.BodyFor<TPerson>(Personold);
    personold.Update;
    Render204NoContent();
  finally
    personold.Free;
  end;

end;

function TPersonController.DeletePerson(ID: Integer): IMVCResponse;
begin
  var person := TMVCActiveRecord.GetByPK<TPerson>(ID);
  try
    person.Delete;
    Render204NoContent();
  finally
    person.Free;
  end;
end;

end.
