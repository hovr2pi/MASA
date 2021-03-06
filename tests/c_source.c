// -*-c++-*-
//
//-----------------------------------------------------------------------bl-
//--------------------------------------------------------------------------
//
// MASA - Manufactured Analytical Solutions Abstraction Library
//
// Copyright (C) 2010,2011,2012 The PECOS Development Team
//
// This library is free software; you can redistribute it and/or
// modify it under the terms of the Version 2.1 GNU Lesser General
// Public License as published by the Free Software Foundation.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library; if not, write to the Free Software
// Foundation, Inc. 51 Franklin Street, Fifth Floor,
// Boston, MA  02110-1301  USA
//
//-----------------------------------------------------------------------el-
// $Author: nick $
// $Id: c_misc.c 18051 2011-02-25 00:46:40Z nick $
//
// c_source.c :program that tests source terms
//
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------

#include<tests.h>

int main()
{
  double out;
  double x = 0;
  int    i = 1;

  // reroute stdout for regressions: TODO remove when logger mechanism
  // is used inside masa; these tests currently just verify functions
  // run successfully.
  freopen("/dev/null","w",stdout);

  masa_init("source term","euler_2d");


  // 1D
  out = masa_eval_1d_source_u(x);
  nancheck(out);

  out = masa_eval_1d_source_e(x);
  nancheck(out);

  out = masa_eval_1d_grad_u(x);
  nancheck(out);
  out = masa_eval_1d_grad_p(x);
  nancheck(out);

  out = masa_eval_1d_grad_rho(x);
  nancheck(out);

  // 2D

  out = masa_eval_2d_source_u(x,x);
  nancheck(out);
  out = masa_eval_2d_source_v(x,x);
  nancheck(out);
  out = masa_eval_2d_source_e(x,x);
  nancheck(out);
  out = masa_eval_2d_source_rho_w(x,x);
  nancheck(out);

  out = masa_eval_2d_grad_u(x,x,i);
  nancheck(out);
  out = masa_eval_2d_grad_v(x,x,i);
  nancheck(out);
  out = masa_eval_2d_grad_w(x,x,i);
  nancheck(out);
  out = masa_eval_2d_grad_p(x,x,i);
  nancheck(out);
  out = masa_eval_2d_grad_rho(x,x,i);
  nancheck(out);

  // 3D

  out = masa_eval_3d_source_u(x,x,x);
  nancheck(out);
  out = masa_eval_3d_source_v(x,x,x);
  nancheck(out);
  out = masa_eval_3d_source_w(x,x,x);
  nancheck(out);
  out = masa_eval_3d_source_e(x,x,x);
  nancheck(out);

  //tests passed
  return 0;

}

