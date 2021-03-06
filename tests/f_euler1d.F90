!! -*-f90-*-
!!-----------------------------------------------------------------------bl-
!!--------------------------------------------------------------------------
!!
!! MASA - Manufactured Analytical Solutions Abstraction Library
!!
!! Copyright (C) 2010,2011,2012 The PECOS Development Team
!!
!! This library is free software; you can redistribute it and/or
!! modify it under the terms of the Version 2.1 GNU Lesser General
!! Public License as published by the Free Software Foundation.
!!
!! This library is distributed in the hope that it will be useful,
!! but WITHOUT ANY WARRANTY; without even the implied warranty of
!! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
!! Lesser General Public License for more details.
!!
!! You should have received a copy of the GNU Lesser General Public
!! License along with this library; if not, write to the Free Software
!! Foundation, Inc. 51 Franklin Street, Fifth Floor,
!! Boston, MA  02110-1301  USA
!!
!!-----------------------------------------------------------------------el-
!!
!! f_euler1d.f90: Fortran Euler 1d test
!!
!! $Id: masa.f90 13217 2010-09-11 04:30:16Z nick $
!! -------------------------------------------------------------------------
!! -------------------------------------------------------------------------

program main
  use euler_source_interface
  use masa

  implicit none

  ! threshold calculation
  real(8) :: thresh = 1e-15

  ! solutions
  real(8) ::ufield,ufield2,ufield3
  real(8) ::efield,efield2,efield3
  real(8) ::rho,rho2,rho3

  real(8) ::exact_u,exact_u2,exact_u3
  real(8) ::exact_v,exact_v2,exact_v3
  real(8) ::exact_p,exact_p2,exact_p3
  real(8) ::exact_rho,exact_rho2,exact_rho3

  ! variables 
  real(8) :: u_0
  real(8) :: u_x
  real(8) :: u_y
  real(8) :: v_0
  real(8) :: v_x
  real(8) :: v_y
  real(8) :: rho_0
  real(8) :: rho_x
  real(8) :: rho_y
  real(8) :: p_0
  real(8) :: p_x
  real(8) :: p_y
  real(8) :: a_px
  real(8) :: a_py
  real(8) :: a_rhox
  real(8) :: a_rhoy
  real(8) :: a_ux
  real(8) :: a_uy
  real(8) :: a_vx
  real(8) :: a_vy
  real(8) :: Gamma
  real(8) :: mu
  real(8) :: L

  ! declarations
  real(8) :: value, val
  real(8) :: out,out1=1
  real(8) :: x
  real(8) :: y
  real(8) :: fsol
  ! problem size
  integer i,j,k
  integer ::  nx = 71
  integer ::  ny = 93  
  integer ::  lx=3
  integer ::  ly=1 
  real(8) ::  dx 
  real(8) ::  dy


  ! initialize the problem
  dx = real(lx)/real(nx)

  call masa_init('mytest','euler_1d')

  ! initialize the default parameters
  call masa_init_param()

  ! intialize the various parameters required for Euler 2D
  u_0 = masa_get_param("u_0")
  u_x = masa_get_param("u_x")

  rho_0 = masa_get_param("rho_0")
  rho_x = masa_get_param("rho_x")

  p_0 = masa_get_param("p_0")
  p_x = masa_get_param("p_x")

  a_px = masa_get_param("a_px")

  a_rhox = masa_get_param("a_rhox")

  a_ux = masa_get_param("a_ux")

  Gamma = masa_get_param("Gamma")
  mu    = masa_get_param("mu")
  L     = masa_get_param("L")

  ! call the sanity check routine 
  ! (tests that all variables have been initialized)
  call masa_sanity_check()

  ! evaluate source terms (2D)
  do i=0, nx

     x = i * dx

     ! evalulate source terms
     ufield = masa_eval_1d_source_rho_u  (x)
     efield = masa_eval_1d_source_rho_e  (x)
     rho    = masa_eval_1d_source_rho(x)

     !evaluate analytical terms
     exact_u = masa_eval_1d_exact_u        (x)
     exact_p = masa_eval_1d_exact_p        (x)
     exact_rho = masa_eval_1d_exact_rho    (x)

     ! hacking at this source
     ! check against maple
     ufield2 = eval_1d_source_u  (x,u_0,u_x,rho_0,rho_x,p_0,p_x,a_px,a_rhox,a_ux,L)
     rho2    = eval_1d_source_rho(x,u_0,u_x,rho_0,rho_x,p_0,p_x,a_px,a_rhox,a_ux,L)
     efield2 = eval_1d_source_e  (x,u_0,u_x,rho_0,rho_x,p_0,p_x,a_px,a_rhox,a_ux,Gamma,mu,L)

     exact_u2   = eval_1d_exact_u  (x,u_0,u_x,a_ux,L)
     exact_rho2 = eval_1d_exact_rho(x,rho_0,rho_x,a_rhox,L)
     exact_p2   = eval_1d_exact_p  (x,p_0,p_x,a_px,L)

#ifdef MASA_STRICT_REGRESSION
     ufield3 = abs(ufield-ufield2)
     efield3 = abs(efield-efield2)
     rho3    = abs(rho-rho2)

     exact_u3   = abs(exact_u-exact_u2)
     exact_rho3 = abs(exact_rho-exact_rho2)
     exact_p3   = abs(exact_p-exact_p2)

#else

     ufield3 = abs(ufield-ufield2)/abs(ufield2)
     efield3 = abs(efield-efield2)/abs(efield2)
     rho3    = abs(rho-rho2)/abs(rho2)

     exact_u3   = abs(exact_u-exact_u2)/abs(exact_u2)
     exact_rho3 = abs(exact_rho-exact_rho2)/abs(exact_rho2)
     exact_p3   = abs(exact_p-exact_p2)/abs(exact_p2)

#endif

     ! just need error checker
     if(ufield3 .gt. thresh) then
        write(6,*) "FortMASA FATAL ERROR: euler-1d"
        write(6,*) "U Field"
        write(6,*) "exceeded by: ", ufield3
        write(6,*) "masa:        ", ufield
        write(6,*) "maple:       ", ufield2
        write(6,*) "@ x:       ",x
        call exit(1)
     endif

     if(efield3 .gt. thresh) then
        write(6,*) "FortMASA FATAL ERROR: euler-1d"
        write(6,*) "E Field"
        write(6,*) "exceeded by: ", efield3
        write(6,*) "masa:        ", efield
        write(6,*) "maple:       ", efield2
        write(6,*) "@ x:       ",x
        call exit(1)
     endif

     if(rho3 .gt. thresh) then
        write(6,*) "FortMASA FATAL ERROR: euler-1d"
        write(6,*) "Rho Field"
        call exit(1)
     endif

     ! analytical terms now
     if(exact_u3 .gt. thresh) then
        write(6,*) "FortMASA FATAL ERROR: euler-1d"
        write(6,*) "U an"
        call exit(1)
     endif

     if(exact_p3 .gt. thresh) then
        write(6,*) "FortMASA FATAL ERROR: euler-1d"
        write(6,*) "P an"
        call exit(1)
     endif

     if(exact_rho3 .gt. thresh) then
        write(6,*) "FortMASA FATAL ERROR: euler-1d"
        write(6,*) "Rho an"
        call exit(1)
     endif

  enddo
  
  ! steady as she goes (exit with success)
  call exit(0)

end program main
