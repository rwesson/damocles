module mcmc_handler

    use globals
    use class_line
    use class_freq_grid
    use class_grid
    use electron_scattering
    use input
    use initialise
    use vector_functions
    use class_packet
    use radiative_transfer
    use model_comparison
    use mcmc_sampler
    use driver

    implicit none

    real :: v_max
    real :: likelihood
    real :: likelihood_new

contains

    subroutine mcmc()

        !final parameter list to be explored: max velocity, min velocity, density gradient, dust mass
        !!current list: max velocity

        open(53,file='input/mcmc.in')
        read(53,*)
        read(53,*) param_space%n_points
        close(53)

        open(54,file='output/trace.out',status='unknown')

        do i_mcmc=1,param_space%n_points
            call flush(54)
            call run_damocles()
            print*,v_max,likelihood,i_mcmc
            if (i_mcmc == 1) then
                v_max = dust_geometry%v_max
                likelihood = exp(-chi_sq)
            else
                likelihood_new = exp(-chi_sq)
                if (likelihood_new > likelihood) then
                    !accept
                    print*,'accepted'
                    likelihood = likelihood_new
                    v_max = dust_geometry%v_max
                    write(54,*) dust_geometry%v_max,likelihood
                else
                    !accept with probability likelihood_new/likelihood
                    call init_random_seed
                    call random_number(ran)
                    if (ran < (likelihood_new/likelihood)) then
                        !accept
                        print*,'accepted'
                        likelihood = likelihood_new
                        v_max = dust_geometry%v_max
                        write(54,*) dust_geometry%v_max,likelihood
                    end if
                end if
            end if

        end do


        close(54)

    end subroutine

end module mcmc_handler
