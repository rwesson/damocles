module mcmc_sampler

    use globals
    use class_line
    use class_freq_grid
    use class_grid
    use electron_scattering

    implicit none

    type mcmc_param_space
        integer :: n_points
        integer :: dimension
        real    :: v_max_bounds(2)
        real    :: v_max_init
    end type

    type(mcmc_param_space) param_space

contains

    subroutine mcmc_sample()

        param_space%dimension = 1
        param_space%v_max_bounds(1) = 13000
        param_space%v_max_bounds(2) = 20000
        param_space%v_max_init = 16000

        !velocity test run
        if (i_mcmc==1) then
            dust_geometry%v_max = param_space%v_max_init
        else
            do ii=1,param_space%n_points
                !test uniform distribution for v_max
                call random_number(ran)
                dust_geometry%v_max = param_space%v_max_bounds(1)+ran*(param_space%v_max_bounds(2)-param_space%v_max_bounds(1))
            end do
        end if

    end subroutine

end module mcmc_sampler
