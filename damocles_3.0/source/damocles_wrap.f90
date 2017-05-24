!----------------------------------------------------------------------------!
!  this subroutine is only called if the python mcmc wrapper is being used.  !
!  the logical lg_mcmc is set to true and input parameters passed from the   !
!  python routine.                                                           !
!----------------------------------------------------------------------------!
subroutine run_damocles_wrap(mcmc_v_max,mcmc_rho_index,mcmc_likelihood)

    use globals
    use input
    use initialise
    use vector_functions
    use driver

    implicit none

    real :: mcmc_v_max
    real :: mcmc_rho_index
    real :: mcmc_likelihood

!f2py   intent(in) mcmc_v_max
!f2py   intent(in) mcmc_rho_index
!f2py   intent(out) mcmc_likelihood
!f2py   depend(mcmc_v_max) mcmc_chi2

    lg_mcmc = .true.
    dust_geometry%v_max = mcmc_v_max*10000
    dust_geometry%rho_power = mcmc_rho_index
    call run_damocles()
    mcmc_likelihood=exp(-chi_sq/2)

end subroutine
