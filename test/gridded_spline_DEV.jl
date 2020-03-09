using .Interpolations

@testset "gridded spline" begin
    x = [1, 3, 7, 14]
    y = [1., 1.5, 1.3, 2.4]

    #=
    Take Scipy as reference: it supports both equally spaced and gridded spline.

    x = np.arange(4)+1
    y = np.array([1., 1.5, 1.3, 2.4])
    spline = interpolate.CubicSpline(x,y, bc_type='natural')
    x_int = np.arange(1,4.1,0.1)
    evenly_scipy = spline(x_int)
    =#
    evenly_scipy = [1.     , 1.07706, 1.15248, 1.22462, 1.29184, 1.3525 , 1.40496,
           1.44758, 1.47872, 1.49674, 1.5    , 1.4878 , 1.4632 , 1.4302 ,
           1.3928 , 1.355  , 1.3208 , 1.2942 , 1.2792 , 1.2798 , 1.3    ,
           1.34274, 1.40672, 1.48958, 1.58896, 1.7025 , 1.82784, 1.96262,
           2.10448, 2.25106, 2.4    ]

    itp_spline = interpolate(y, BSpline(Cubic(Line(OnGrid()))))
    evenly_jl = itp_spline.(1:0.1:4)
    @test all(evenly_scipy .≈ evenly_jl)

    #=
    x = np.array([1, 3, 7, 14])
    y = np.array([1., 1.5, 1.3, 2.4])
    spline = interpolate.CubicSpline(x,y, bc_type='natural')
    x_int = np.arange(1,14.1,0.1)
    gridded_scipy = spline(x_int)
    =#
    gridded_scipy = [1.        , 1.03097581, 1.06186175, 1.09256797, 1.12300461,
           1.1530818 , 1.18270968, 1.21179839, 1.24025806, 1.26799885,
           1.29493088, 1.32096429, 1.34600922, 1.36997581, 1.39277419,
           1.41431452, 1.43450691, 1.45326152, 1.47048848, 1.48609793,
           1.5       , 1.51213102, 1.52253203, 1.53127025, 1.5384129 ,
           1.54402722, 1.54818041, 1.55093972, 1.55237235, 1.55254554,
           1.5515265 , 1.54938246, 1.54618065, 1.54198828, 1.53687258,
           1.53090078, 1.52414009, 1.51665775, 1.50852097, 1.49979698,
           1.490553  , 1.48085625, 1.47077396, 1.46037336, 1.44972166,
           1.43888609, 1.42793387, 1.41693223, 1.40594839, 1.39504957,
           1.384303  , 1.37377589, 1.36353548, 1.35364899, 1.34418364,
           1.33520665, 1.32678525, 1.31898666, 1.31187811, 1.30552681,
           1.3       , 1.29535156, 1.29158209, 1.28867885, 1.2866291 ,
           1.2854201 , 1.2850391 , 1.28547339, 1.2867102 , 1.28873682,
           1.29154049, 1.29510848, 1.29942804, 1.30448645, 1.31027097,
           1.31676884, 1.32396735, 1.33185374, 1.34041527, 1.34963922,
           1.35951284, 1.37002339, 1.38115813, 1.39290433, 1.40524924,
           1.41818013, 1.43168427, 1.4457489 , 1.46036129, 1.47550871,
           1.49117841, 1.50735765, 1.52403371, 1.54119383, 1.55882528,
           1.57691532, 1.59545122, 1.61442023, 1.63380961, 1.65360663,
           1.67379855, 1.69437263, 1.71531613, 1.73661631, 1.75826043,
           1.78023576, 1.80252956, 1.82512908, 1.84802159, 1.87119435,
           1.89463463, 1.91832967, 1.94226675, 1.96643313, 1.99081606,
           2.01540281, 2.04018065, 2.06513682, 2.09025859, 2.11553323,
           2.14094799, 2.16649014, 2.19214694, 2.21790565, 2.24375352,
           2.26967783, 2.29566583, 2.32170479, 2.34778196, 2.37388461,
           2.4       ]

    itp_spline_grid = interpolate((x,), y, Gridded(Cubic(Line(OnGrid()))))
    gridded_jl = itp_spline_grid.(1:0.1:14)

    @test_broken all(gridded_scipy .≈ gridded_jl)

end
