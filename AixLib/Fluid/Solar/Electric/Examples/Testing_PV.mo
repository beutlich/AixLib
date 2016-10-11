within AixLib.Fluid.Solar.Electric.Examples;
model Testing_PV

  extends Modelica.Icons.Example;

  PVsystem                                pVsystem(
    max_Output_Power=4000,
    NumberOfPanels=5,
    data=DataBase.SolarElectric.SE6M181_14_panels())  "cle"
    annotation (Placement(transformation(extent={{-22,38},{-2,58}})));
  Modelica.Blocks.Interfaces.RealOutput Power
    annotation (Placement(transformation(extent={{52,40},{72,60}})));
public
  AixLib.Building.Components.Weather.Weather Weather(
    Latitude=49.5,
    Longitude=8.5,
    GroundReflection=0.2,
    tableName="wetter",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    Wind_dir=false,
    Air_temp=true,
    Wind_speed=false,
    SOD=AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_RoofN_Roof_S(),
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt"))
    annotation (Placement(transformation(extent={{-93,49},{-68,66}})));

equation
  connect(pVsystem.PV_Power_W, Power)     annotation (Line(
      points={{-3,49},{-3.5,49},{-3.5,50},{62,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Weather.SolarRadiation_OrientedSurfaces[6], pVsystem.ic_total_rad)
    annotation (Line(
      points={{-87,48.15},{-87,47.3},{-23,47.3}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(Weather.AirTemp, pVsystem.Temp_outside) annotation (Line(
      points={{-67.1667,60.05},{-56,60.05},{-56,55},{-22.6,55}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}),
                      graphics),
    experiment(
      StopTime=3.1536e+007,
      Interval=3600,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simulation to test the <a href=\"HVAC.Components.Solar_UC.Electric.PVsystem\">PVsystem</a> model.</p>
</html>",
      revisions="<html>
<p><ul>
<li><i>April 16, 2014 &nbsp;</i> by Ana Constantin:<br/>Formated documentation.</li>
<li><i>October 11, 2016 </i> by Tobias Blacha:<br/>Moved into AixLib</li>
</ul></p>
</html>"));
end Testing_PV;
