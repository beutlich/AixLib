within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSashAngle
  "Window opening with different types of sash, input port with opening angle"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningAreaSash(
    final useInputPort=true,
    redeclare final Modelica.Blocks.Interfaces.RealInput u(
    quantity="Angle", unit="rad", min=0, max=Modelica.Constants.pi/2)
    "Window sash opening angle");
equation
  assert(
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    "With opening angle input, the model can only used for hinged or pivot opening",
    AssertionLevel.error);

  /*Calculate the opening width*/
  /*Hinged or pivot opening*/
  if opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical or
    opnTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal then
    opnAngle = u;
    opnWidth = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.alpha_to_s(
      lenA, lenB, opnAngle);

  /*Exceptions*/
  else
    opnAngle = 0;
    opnWidth = 0;
  end if;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end OpeningAreaSashAngle;
