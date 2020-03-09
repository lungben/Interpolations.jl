x = [1, 3, 7, 14]
y = [1., 1.5, 1.3, 2.4]

# current functionality
itp_lin_grid = interpolate((x,), y, Gridded(Linear()))
itp_lin_grid(2)
itp_spline = interpolate(y, BSpline(Cubic(Line(OnGrid()))))

#new
itp_spline_grid = interpolate((x,), y, Gridded(Cubic(Line(OnGrid()))))
