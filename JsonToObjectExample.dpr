program JsonToObjectExample;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  mORMot,
  SynCommons,
  mormot.core.json,
  mormot.core.text;

type
  TAnotherClass = class
  private
    FSomeString: string;
  public
    constructor Create;
  published
    property SomeString: string read FSomeString write FSomeString;
  end;

  TTestClass = class
  private
    FSomeString: string;
    FSomeObject: TObject;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property SomeString: string read FSomeString write FSomeString;
    property SomeObject: TObject read FSomeObject write FSomeObject;
  end;

constructor TAnotherClass.Create;
begin
  FSomeString := 'TSubObject somestring';
end;

constructor TTestClass.Create;
begin
  FSomeString := 'TTestClass somestring';
  FSomeObject := TAnotherClass.Create;
end;

destructor TTestClass.Destroy;
begin
  FSomeObject.Free;
  inherited;
end;

procedure RunTest;
var
  mormotJson,
  mormot2Json: UTF8String;
  aObj: TTestClass;
begin
  aObj := TTestClass.Create;
  try
    mormotJson := SynCommons.ObjectToJSON(aObj);
    mormot2Json := ObjectToJSON(aObj);
    Assert(mormotJson = mormot2Json);
  finally
    aObj.Free;
  end;
end;

begin
  try
    RunTest;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
