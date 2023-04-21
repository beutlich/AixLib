﻿within AixLib.ThermalZones.HighOrder.Components.Shadow;
model ShadowEff "Shadow effect of shield"
  parameter Modelica.Units.SI.Length L_Shield = 0.3 "Horizontal length of the sun shield";
  parameter Modelica.Units.SI.Length H_Window_min = 0.1 "Distance from shield to upper border of window";
  parameter Modelica.Units.SI.Length H_Window_max = 1.1 "Distance from shield to lower border of window";
  parameter Modelica.Units.NonSI.Angle_deg azi_deg = -54 "Surface azimuth, S=0°, W=90°, N=180°, E=-90°";

  BoundaryConditions.WeatherData.Bus weaBus "Weather bus"
    annotation (Placement(transformation(extent={{-120,60},{-80,100}}),
        iconTransformation(extent={{-120,60},{-80,100}})));
  Utilities.Interfaces.SolarRad_in solarRad_in
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Utilities.Interfaces.SolarRad_out solarRad_out
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  ShadowLength shadowLength(azi_deg=azi_deg, L_Shield=L_Shield)
    annotation (Placement(transformation(extent={{-40,-20},{0,20}})));

protected
  Modelica.Units.SI.TransmissionCoefficient g_Shadow(min=0.0,max=1.0) "shadow coefficient: 0=full shadowed, 1=no shadow";

equation
  if shadowLength.With_Shadow then
    g_Shadow = min(max((H_Window_max-shadowLength.H_Shadow)/(H_Window_max-H_Window_min), 0), 1);
  else
    g_Shadow = 1;
  end if;
  solarRad_out.I = solarRad_out.I_dir + solarRad_out.I_diff;
  solarRad_out.I_dir = solarRad_in.I_dir*g_Shadow;
  solarRad_out.I_diff = solarRad_in.I_diff;
  solarRad_out.I_gr = solarRad_in.I_gr;
  solarRad_out.AOI = solarRad_in.AOI;

  connect(shadowLength.weaBus, weaBus) annotation (Line(
      points={{-40,0},{-74,0},{-74,80},{-100,80}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{40,40},{48,-80}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{40,40},{48,80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,88},{100,80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{40,-80},{48,-92}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,98},{40,10}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Rectangle(
          extent={{40,-92},{100,-100}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,8},{40,-80}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-60,54},{40,-34}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled})}),                    Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ShadowEff;
