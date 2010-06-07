  /*--------------------------------------------------------------------------
  *--------------------------------------------------------------------------
  *
  * Copyright (C) 2010 The PECOS Development Team
  *
  * Please see http://pecos.ices.utexas.edu for more information.
  *
  * This file is part of MASA.
  *
  * MASA is free software: you can redistribute it and/or modify it under
  * the terms of the GNU Lesser General Public License as published by the Free
  * Software Foundation, either version 3 of the License, or (at your option)
  * any later version.
  *
  * MASA is distributed in the hope that it will be useful, but WITHOUT ANY
  * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
  * details.
  *
  * You should have received a copy of the GNU Lesser General Public License along 
  * with MASA.  If not, see <http://www.gnu.org/licenses/>.
  *
  *--------------------------------------------------------------------------
  
  MASA -- Manufactured Analytical Solutions Abstraction Library

  A software interface that provides access to all manufactured solutions to 
  be used by various models throughout the center.
  
  *--------------------------------------------------------------------------
  */  

// this is just a program I have to play around with

#include <masa.h>

using namespace MASA;

void masa_shell_print_avail()
{

  masa_printid();

}

int main()
{
  string blah;
  double sol;

  masa_shell_print_avail();
  cout << endl << endl;
  masa_init("nick","heateq_1d_steady_const");
  masa_init( "bob","heateq_2d_steady_const");
  masa_list_mms();

  masa_select_mms("nick");
  masa_display_param();
  masa_eval_t_source(1.2,1.2,&sol);
  cout << sol << endl;

  masa_select_mms("bob");
  masa_display_param();
  masa_eval_t_source(1,1,&sol);
  cout << sol << endl;

}