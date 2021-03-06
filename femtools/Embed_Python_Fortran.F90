!    Copyright (C) 2006 Imperial College London and others.
!    
!    Please see the AUTHORS file in the main source directory for a full list
!    of copyright holders.
!
!    Prof. C Pain
!    Applied Modelling and Computation Group
!    Department of Earth Science and Engineering
!    Imperial College London
!
!    amcgsoftware@imperial.ac.uk
!    
!    This library is free software; you can redistribute it and/or
!    modify it under the terms of the GNU Lesser General Public
!    License as published by the Free Software Foundation; either
!    version 2.1 of the License, or (at your option) any later version.
!
!    This library is distributed in the hope that it will be useful,
!    but WITHOUT ANY WARRANTY; without even the implied warranty of
!    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
!    Lesser General Public License for more details.
!
!    You should have received a copy of the GNU Lesser General Public
!    License along with this library; if not, write to the Free Software
!    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
!    USA

#include "fdebug.h"

module embed_python

  use fldebug
  use iso_c_binding
  use global_parameters, only: FIELD_NAME_LEN

  implicit none
  
  interface set_scalar_field_from_python
    module procedure set_scalar_field_from_python_sp

    subroutine set_scalar_field_from_python(function, function_len, dim,&
         & nodes, x, y, z, t, result, stat)
      !! Interface to c wrapper function.
      use iso_c_binding, only: c_double
      implicit none
      integer, intent(in) :: function_len
      character(len = function_len) :: function
      integer, intent(in) :: dim
      integer, intent(in) :: nodes
      real(kind = c_double), dimension(nodes), intent(in) :: x, y, z
      real(kind = c_double), intent(in) :: t
      real(kind = c_double), dimension(nodes), intent(out) :: result
      integer, intent(out) :: stat
    end subroutine set_scalar_field_from_python
  end interface set_scalar_field_from_python
  
  interface set_integer_array_from_python
    module procedure set_integer_array_from_python_sp

    subroutine set_integer_array_from_python(function, function_len, dim, nodes, x, y, z, t, result, stat)
      use iso_c_binding, only: c_double
      implicit none
      integer, intent(in) :: function_len
      character(len = function_len), intent(in) :: function
      integer, intent(in) :: dim
      integer, intent(in) :: nodes
      real(kind = c_double), dimension(nodes), intent(in) :: x
      real(kind = c_double), dimension(nodes), intent(in) :: y
      real(kind = c_double), dimension(nodes), intent(in) :: z
      real(kind = c_double), intent(in) :: t
      integer, dimension(nodes), intent(out) :: result
      integer, intent(out) :: stat
    end subroutine set_integer_array_from_python
  end interface set_integer_array_from_python
    
  interface set_vector_field_from_python
    module procedure set_vector_field_from_python_sp

    subroutine set_vector_field_from_python(function, function_len, dim,&
         & nodes, x, y, z, t, result_dim, result_x, result_y, result_z,&
         & stat)
      !! Interface to c wrapper function.
      use iso_c_binding, only: c_double
      implicit none
      integer, intent(in) :: function_len
      character(len = function_len) :: function
      integer, intent(in) :: dim
      integer, intent(in) :: nodes
      real(kind = c_double), dimension(nodes), intent(in) :: x, y, z
      real(kind = c_double), intent(in) :: t
      integer, intent(in) :: result_dim
      real(kind = c_double), dimension(nodes), intent(out) :: result_x, result_y, result_z
      integer, intent(out) :: stat
    end subroutine set_vector_field_from_python
  end interface set_vector_field_from_python
  
  interface set_tensor_field_from_python
    module procedure set_tensor_field_from_python_sp

    subroutine set_tensor_field_from_python(function, function_len, dim,&
         & nodes, x, y, z, t, result_dim, result, stat)
      !! Interface to c wrapper function.
      use iso_c_binding, only: c_double
      implicit none
      integer, intent(in) :: function_len
      character(len = function_len) :: function
      integer, intent(in) :: dim
      integer, intent(in) :: nodes
      real(kind = c_double), dimension(nodes), intent(in) :: x, y, z
      real(kind = c_double), intent(in) :: t
      integer,dimension(2), intent(in) :: result_dim
      real(kind = c_double), dimension(result_dim(1), result_dim(2), nodes), intent(out) :: result
      integer, intent(out) :: stat
    end subroutine set_tensor_field_from_python
  end interface set_tensor_field_from_python
     
  interface set_particle_sfield_from_python
    module procedure set_particle_sfield_from_python_sp

    subroutine set_particle_sfield_from_python(function, function_len,&
         & nparticles,t, result, stat)
      !! Interface to c wrapper function.
      use iso_c_binding, only: c_double
      implicit none
      integer, intent(in) :: function_len
      character(len = function_len) :: function
      integer, intent(in) :: nparticles
      real(kind = c_double), intent(in) :: t
      real(kind = c_double), dimension(nparticles), intent(out) :: result
      integer, intent(out) :: stat
    end subroutine set_particle_sfield_from_python
  end interface set_particle_sfield_from_python
    
  interface set_particle_vfield_from_python
    module procedure set_particle_vfield_from_python_sp

    subroutine set_particle_vfield_from_python(function, function_len, &
         & nparticles, t, result_x, result_y, result_z,&
         & stat)
      !! Interface to c wrapper function.
      use iso_c_binding, only: c_double
      implicit none
      integer, intent(in) :: function_len
      character(len = function_len) :: function
      integer, intent(in) :: nparticles
      real(kind = c_double), intent(in) :: t
      real(kind = c_double), dimension(nparticles), intent(out) :: result_x, result_y, result_z
      integer, intent(out) :: stat
    end subroutine set_particle_vfield_from_python
  end interface set_particle_vfield_from_python
        
  interface set_detectors_from_python
    module procedure set_detectors_from_python_sp

    subroutine set_detectors_from_python(function, function_len, dim,&
         ndete, t, rdim, result_x, result_y, result_z, stat)
      !! Interface to c wrapper function.
      use iso_c_binding, only: c_double
      implicit none
      integer, intent(in) :: function_len
      character(len = function_len) :: function
      integer, intent(in) :: dim,rdim
      integer, intent(in) :: ndete
      real(kind = c_double), intent(in) :: t
      real(kind = c_double), dimension(ndete), intent(out) :: result_x, result_y, result_z
      integer, intent(out) :: stat
    end subroutine set_detectors_from_python
  end interface set_detectors_from_python

  interface set_particles_from_python 
    module procedure set_particles_from_python_sp
     
     subroutine set_particles_from_python(function, function_len, dim,&
         & ndete, x, y, z, t, dt, result, stat)
      !! Interface to c wrapper function.
      use iso_c_binding, only: c_double
      implicit none
      integer, intent(in) :: function_len
      character(len = function_len) :: function
      integer, intent(in) :: dim
      integer, intent(in) :: ndete
      real(kind = c_double), dimension(ndete), intent(in) :: x
      real(kind = c_double), dimension(ndete), intent(in) :: y
      real(kind = c_double), dimension(ndete), intent(in) :: z
      real(kind = c_double), intent(in) :: t
      real(kind = c_double), intent(in) :: dt
      real(kind = c_double), dimension(ndete), intent(out) :: result
      integer, intent(out) :: stat
     end subroutine set_particles_from_python
  end interface set_particles_from_python

    interface set_particles_from_python_fields
       module procedure set_particles_from_python_fields_sp
     
     subroutine set_particles_from_python_fields(function, function_len, dim,&
          & ndete, x, y, z, t, dt, fld_name_len, nfields, field_names, field_vals, old_nfields, old_field_names, &
          & old_field_vals, old_nattributes, old_att_names, old_attributes, result, stat) bind(c)
      !! Interface to c wrapper function.
      use iso_c_binding, only: c_double, c_char
      use global_parameters, only: FIELD_NAME_LEN
      implicit none
      integer, intent(in) :: function_len
      character(kind=c_char):: function
      integer, intent(in) :: dim, nfields, ndete, old_nfields, old_nattributes
      integer, intent(in) :: fld_name_len
      real(kind = c_double), dimension(ndete), intent(in) :: x
      real(kind = c_double), dimension(ndete), intent(in) :: y
      real(kind = c_double), dimension(ndete), intent(in) :: z
      real(kind = c_double), intent(in) :: t
      real(kind = c_double), intent(in) :: dt
      character(kind = c_char), dimension(FIELD_NAME_LEN,nfields), intent(in) :: field_names
      real(kind = c_double), dimension(nfields,ndete), intent(in) :: field_vals
      character(kind = c_char), dimension(FIELD_NAME_LEN,old_nfields), intent(in) :: old_field_names
      real(kind = c_double), dimension(old_nfields,ndete), intent(in) :: old_field_vals
      character(kind = c_char), dimension(FIELD_NAME_LEN,old_nattributes), intent(in) :: old_att_names
      real(kind = c_double), dimension(old_nattributes,ndete), intent(in) :: old_attributes
      real(kind = c_double), dimension(ndete), intent(out) :: result
      integer, intent(out) :: stat
     end subroutine set_particles_from_python_fields
  end interface set_particles_from_python_fields
    
  interface real_from_python
    module procedure real_from_python_sp, real_from_python_interface

    subroutine real_from_python(function, function_len, t, result, stat)
      use iso_c_binding, only: c_double
      implicit none
      integer, intent(in) :: function_len
      character(len = function_len), intent(in) :: function
      real(kind = c_double), intent(in) :: t
      real(kind = c_double), intent(out) :: result
      integer, intent(out) :: stat
    end subroutine real_from_python
  end interface real_from_python
  
  interface real_vector_from_python
    module procedure real_vector_from_python_interface, real_vector_from_python_sp

    subroutine real_vector_from_python(function, function_len, t, result,&
         & result_len, stat) bind(c)
      use :: iso_c_binding
      implicit none
      integer(c_int), intent(in) :: function_len
      character(kind=c_char,len = 1), intent(in) :: function
      real(kind = c_double), intent(in) :: t
      type(c_ptr), intent(out) :: result
      integer(c_int), intent(out) :: result_len, stat
    end subroutine real_vector_from_python
  end interface real_vector_from_python

  interface integer_vector_from_python
    module procedure integer_vector_from_python_interface

    subroutine integer_vector_from_python(function, function_len, t, result,&
         & result_len, stat) bind(c)
      use :: iso_c_binding
      implicit none
      integer(c_int), intent(in) :: function_len
      character(kind=c_char,len = 1), intent(in) :: function
      real(kind=c_double), intent(in) :: t
      type(c_ptr), intent(out) :: result
      integer(c_int), intent(out) :: result_len, stat
    end subroutine integer_vector_from_python
  end interface integer_vector_from_python

  interface
     subroutine free_c_vector(vector) bind(c)
      use :: iso_c_binding
      implicit none
      type(c_ptr) :: vector
     end subroutine
  end interface

  interface integer_from_python
    module procedure integer_from_python_sp, integer_from_python_interface

    subroutine integer_from_python(function, function_len, t, result, stat)
      use iso_c_binding, only: c_double
      implicit none
      integer, intent(in) :: function_len
      character(len = function_len), intent(in) :: function
      real(kind = c_double), intent(in) :: t
      integer, intent(out) :: result
      integer, intent(out) :: stat
    end subroutine integer_from_python
  end interface integer_from_python

  interface string_from_python
    module procedure string_from_python_sp, string_from_python_interface

    subroutine string_from_python(function, function_len, result_len, t, result, stat)
      use iso_c_binding, only: c_double
      implicit none
      integer, intent(in) :: function_len
      character(len = function_len), intent(in) :: function
      integer, intent(inout) :: result_len
      real(kind = c_double), intent(in) :: t
      character(len = result_len), intent(out) :: result
      integer, intent(out) :: stat
    end subroutine string_from_python
  end interface string_from_python
  
  private
  
  public :: set_scalar_field_from_python, set_integer_array_from_python, &
    & set_vector_field_from_python, set_tensor_field_from_python, &
    & set_particle_sfield_from_python, set_particle_vfield_from_python, &
    & set_detectors_from_python, real_from_python, real_vector_from_python, &
    & integer_from_python, string_from_python, integer_vector_from_python, &
    & set_particles_from_python_fields, set_particles_from_python

contains


  subroutine set_scalar_field_from_python_sp(function, function_len, dim, &
    & nodes, x, y, z, t, result, stat)
    integer, intent(in) :: function_len
    character(len = function_len) :: function
    integer, intent(in) :: dim
    integer, intent(in) :: nodes
    real(kind = c_float), dimension(nodes), intent(in) :: x
    real(kind = c_float), dimension(:), intent(in) :: y
    real(kind = c_float), dimension(:), intent(in) :: z
    real(kind = c_float), intent(in) :: t
    real(kind = c_float), dimension(nodes), intent(out) :: result
    integer, intent(out) :: stat

    real(kind = c_double), dimension(nodes) :: lresult

    call set_scalar_field_from_python(function, function_len, dim, &
      & nodes, real(x, kind = c_double), real(y, kind = c_double), real(z, kind = c_double), real(t, kind = c_double), lresult, stat)
    result = lresult

  end subroutine set_scalar_field_from_python_sp

  subroutine set_integer_array_from_python_sp(function, function_len, dim, nodes, x, y, z, t, result, stat)
    integer, intent(in) :: function_len
    character(len = function_len), intent(in) :: function
    integer, intent(in) :: dim
    integer, intent(in) :: nodes
    real(kind = c_float), dimension(nodes), intent(in) :: x
    real(kind = c_float), dimension(:), intent(in) :: y
    real(kind = c_float), dimension(:), intent(in) :: z
    real(kind = c_float), intent(in) :: t
    integer, dimension(nodes), intent(out) :: result
    integer, intent(out) :: stat

    call set_integer_array_from_python(function, function_len, dim, nodes, real(x, kind = c_double), real(y, kind = c_double), real(z, kind = c_double), real(t, kind = c_double), result, stat)

  end subroutine set_integer_array_from_python_sp

  subroutine set_vector_field_from_python_sp(function, function_len, dim, &
    & nodes, x, y, z, t, result_dim, result_x, result_y, result_z, &
    & stat)
    integer, intent(in) :: function_len
    character(len = function_len) :: function
    integer, intent(in) :: dim
    integer, intent(in) :: nodes
    real(kind = c_float), dimension(nodes), intent(in) :: x
    real(kind = c_float), dimension(:), intent(in) :: y
    real(kind = c_float), dimension(:), intent(in) :: z
    real(kind = c_float), intent(in) :: t
    integer, intent(in) :: result_dim
    real(kind = c_float), dimension(nodes), intent(out) :: result_x
    real(kind = c_float), dimension(:), intent(out) :: result_y
    real(kind = c_float), dimension(:), intent(out) :: result_z
    integer, intent(out) :: stat
   
    real(kind = c_double), dimension(size(result_x)) :: lresult_x
    real(kind = c_double), dimension(size(result_y)) :: lresult_y
    real(kind = c_double), dimension(size(result_z)) :: lresult_z

    call set_vector_field_from_python(function, function_len, dim, &
      & nodes, real(x, kind = c_double), real(y, kind = c_double), real(z, kind = c_double), real(t, kind = c_double), result_dim, lresult_x, lresult_y, lresult_z, &
      & stat)
    result_x = lresult_x
    result_y = lresult_y
    result_z = lresult_z

  end subroutine set_vector_field_from_python_sp

  subroutine set_tensor_field_from_python_sp(function, function_len, dim, &
    & nodes, x, y, z, t, result_dim, result, stat)
    integer, intent(in) :: function_len
    character(len = function_len) :: function
    integer, intent(in) :: dim
    integer, intent(in) :: nodes
    real(kind = c_float), dimension(nodes), intent(in) :: x
    real(kind = c_float), dimension(:), intent(in) :: y
    real(kind = c_float), dimension(:), intent(in) :: z
    real(kind = c_float), intent(in) :: t
    integer, dimension(2), intent(in) :: result_dim
    real(kind = c_float), dimension(:, :, :), intent(out) :: result
    integer, intent(out) :: stat

    real(kind = c_double), dimension(size(result, 1), size(result, 2), size(result, 3)) :: lresult

    call set_tensor_field_from_python(function, function_len, dim, &
      & nodes, real(x, kind = c_double), real(y, kind = c_double), real(z, kind = c_double), real(t, kind = c_double), result_dim, lresult, stat)
    result = lresult

  end subroutine set_tensor_field_from_python_sp

  subroutine set_detectors_from_python_sp(function, function_len, dim, &
    & ndete, t, rdim, result_x, result_y, result_z, stat)
    integer, intent(in) :: function_len
    character(len = function_len) :: function
    integer, intent(in) :: dim,rdim
    integer, intent(in) :: ndete
    real(kind = c_float), intent(in) :: t
    real(kind = c_float), dimension(ndete), intent(out) :: result_x
    real(kind = c_float), dimension(:), intent(out) :: result_y
    real(kind = c_float), dimension(:), intent(out) :: result_z
    integer, intent(out) :: stat

    real(kind = c_double), dimension(size(result_x)) :: lresult_x
    real(kind = c_double), dimension(size(result_y)) :: lresult_y
    real(kind = c_double), dimension(size(result_z)) :: lresult_z

    call set_detectors_from_python(function, function_len, dim, &
      & ndete, real(t, kind = c_double), rdim, lresult_x, lresult_y, lresult_z, stat)
    result_x = lresult_x
    result_y = lresult_y
    result_z = lresult_z

  end subroutine set_detectors_from_python_sp

  !Subroutine to call c_wrapper function set_particles_from_python
  subroutine set_particles_from_python_sp(function, function_len, dim, &
       & ndete,x, y, z, t, dt, result, stat)
    integer, intent(in) :: function_len
    character(len = function_len) :: function
    integer, intent(in) :: dim, ndete
    real(kind = c_float), dimension(ndete), intent(in) :: x
    real(kind = c_float), dimension(:), intent(in) :: y
    real(kind = c_float), dimension(:), intent(in) :: z
    real(kind = c_float), intent(in) :: t
    real(kind = c_float), intent(in) :: dt
    real(kind = c_float), dimension(ndete), intent(out) :: result
    integer, intent(out) :: stat

    real(kind = c_double), dimension(ndete) :: lresult
    call set_particles_from_python(function, function_len, dim, ndete, &
         & real(x, kind = c_double), real(y, kind = c_double), real(z, kind = c_double), real(t, kind = c_double), real(dt, kind = c_double), lresult, stat)
    result = lresult
  end subroutine set_particles_from_python_sp

  !Subroutine to call c_wrapper function set_particles_from_python_fields
  subroutine set_particles_from_python_fields_sp(function, function_len, dim, &
       & ndete, x, y, z, t, dt, nfields, field_names, field_vals, old_nfields, old_field_names, old_field_vals, old_nattributes, old_att_names, old_attributes, result, stat)
    integer, intent(in) :: function_len
    character(len = *) :: function
    integer, intent(in) :: dim, nfields, ndete, old_nfields, old_nattributes
    real(kind = c_double), dimension(ndete), intent(in) :: x
    real(kind = c_double), dimension(:), intent(in) :: y
    real(kind = c_double), dimension(:), intent(in) :: z
    real(kind = c_double), intent(in) :: t
    real(kind = c_double), intent(in) :: dt
    character(kind = c_char), dimension(FIELD_NAME_LEN,nfields), intent(in) :: field_names
    real(kind = c_double), dimension(nfields,ndete), intent(in) :: field_vals
    character(kind = c_char), dimension(FIELD_NAME_LEN,old_nfields), intent(in) :: old_field_names
    real(kind = c_double), dimension(old_nfields,ndete), intent(in) :: old_field_vals
    character(kind = c_char), dimension(FIELD_NAME_LEN,old_nattributes), intent(in) :: old_att_names
    real(kind = c_double), dimension(old_nattributes,ndete), intent(in) :: old_attributes
    real(kind = c_double), dimension(ndete), intent(out) :: result
    integer, intent(out) :: stat

    real(kind = c_double), dimension(ndete) :: lresult
    call set_particles_from_python_fields(function, function_len, dim, ndete, &
         & real(x, kind = c_double), real(y, kind = c_double), real(z, kind = c_double), real(t, kind = c_double), real(dt, kind = c_double), &
         & FIELD_NAME_LEN, nfields, field_names, real(field_vals, kind = c_double), old_nfields, old_field_names, real(old_field_vals, kind = c_double), &
         & old_nattributes, old_att_names, real(old_attributes, kind = c_double), lresult, stat)
    result = lresult
  end subroutine set_particles_from_python_fields_sp

  subroutine set_particle_sfield_from_python_sp(function, function_len,&
    & nparticles,t, result, stat)
    integer, intent(in) :: function_len
    character(len = function_len) :: function
    integer, intent(in) :: nparticles
    real(kind = c_float), intent(in) :: t
    real(kind = c_float), dimension(nparticles), intent(out) :: result
    integer, intent(out) :: stat

    real(kind = c_double), dimension(nparticles) :: lresult

    call set_particle_sfield_from_python(function, function_len,&
      & nparticles, real(t, kind = c_double), lresult, stat)
    result = lresult

  end subroutine set_particle_sfield_from_python_sp
    
  subroutine set_particle_vfield_from_python_sp(function, function_len, &
    & nparticles, t, result_x, result_y, result_z,&
    & stat)
    integer, intent(in) :: function_len
    character(len = function_len) :: function
    integer, intent(in) :: nparticles
    real(kind = c_float), intent(in) :: t
    real(kind = c_float), dimension(nparticles), intent(out) :: result_x
    real(kind = c_float), dimension(:), intent(out) :: result_y
    real(kind = c_float), dimension(:), intent(out) :: result_z
    integer, intent(out) :: stat

    real(kind = c_double), dimension(size(result_x)) :: lresult_x
    real(kind = c_double), dimension(size(result_y)) :: lresult_y
    real(kind = c_double), dimension(size(result_z)) :: lresult_z

    call set_particle_vfield_from_python(function, function_len, &
      & nparticles, real(t, kind = c_double), lresult_x, lresult_y, lresult_z,&
      & stat)
    result_x = lresult_x
    result_y = lresult_y
    result_z = lresult_z

  end subroutine set_particle_vfield_from_python_sp

  subroutine real_from_python_sp(function, function_len, t, result, stat)
    integer, intent(in) :: function_len
    character(len = function_len), intent(in) :: function
    real(kind = c_float), intent(in) :: t
    real(kind = c_float), intent(out) :: result
    integer, intent(out) :: stat

    real(kind = c_double) :: lresult

    call real_from_python(function, function_len, real(t, kind = c_double), lresult, stat)
    result = lresult

  end subroutine real_from_python_sp

  subroutine real_from_python_interface(function, current_time, result, stat)
    character(len = *), intent(in) :: function
    real, intent(in) :: current_time
    real, intent(out) :: result
    integer, optional, intent(out) :: stat

    integer :: lstat

    if(present(stat)) stat = 0

    call real_from_python(function, len_trim(function), current_time, result, lstat)

    if(lstat /= 0) then
      if(present(stat)) then
        stat = lstat
        return
      else
        ewrite(-1, *) "Python error, Python string was:"
        ewrite(-1, *) trim(function)
        FLExit("Dying!")
      end if
    end if

  end subroutine real_from_python_interface
 
  subroutine real_vector_from_python_sp(function, current_time,  result, stat)
    character(len = *), intent(in) :: function
    real(kind=c_float), intent(in) :: current_time
    real(kind=c_float), dimension(:), pointer, intent(out) :: result
    integer, optional, intent(out) :: stat

    real(kind=c_double), dimension(:), pointer :: lresult
    
    call real_vector_from_python(function, real(current_time, kind=c_double),&
         & lresult, stat)

    allocate(result(size(lresult)))

    result=lresult

    deallocate(lresult)

  end subroutine real_vector_from_python_sp

  subroutine real_vector_from_python_interface(function, current_time,  result, stat)
    character(len = *), intent(in) :: function
    real(kind=c_double), intent(in) :: current_time
    real(kind=c_double), dimension(:), pointer, intent(out) :: result
    integer, optional, intent(out) :: stat

    
    type(c_ptr) :: c_result
    integer(kind=c_int) :: c_result_len
    real, dimension(:), pointer :: tmp_result
    integer(kind=c_int) :: lstat

    if(present(stat)) stat = 0

    call real_vector_from_python(function, &
         int(len_trim(function), kind=c_int), &
         real(current_time, kind=c_double), c_result, c_result_len, lstat)

    if(lstat /= 0) then
      if(present(stat)) then
        stat = lstat
        return
      else
        ewrite(-1, *) "Python error, Python string was:"
        ewrite(-1, *) trim(function)
        FLExit("Dying!")
      end if
    end if

    call c_f_pointer(c_result, tmp_result, (/c_result_len/))

    allocate(result(c_result_len))

    result=tmp_result

    call free_c_vector(c_result)

  end subroutine real_vector_from_python_interface  

  subroutine integer_vector_from_python_interface(function, current_time,  result, stat)
    character(len = *), intent(in) :: function
    real, intent(in) :: current_time
    integer, dimension(:), pointer, intent(out) :: result
    integer, optional, intent(out) :: stat

    
    type(c_ptr) :: c_result
    integer(kind=c_int) :: c_result_len
    integer, dimension(:), pointer :: tmp_result
    integer(kind=c_int) :: lstat

    if(present(stat)) stat = 0

    call integer_vector_from_python(function, &
         int(len_trim(function), kind=c_int), &
         real(current_time, kind=c_double), c_result, c_result_len, lstat)

    if(lstat /= 0) then
      if(present(stat)) then
        stat = lstat
        return
      else
        ewrite(-1, *) "Python error, Python string was:"
        ewrite(-1, *) trim(function)
        FLExit("Dying!")
      end if
    end if

    call c_f_pointer(c_result, tmp_result, (/c_result_len/))

    allocate(result(c_result_len))

    result=tmp_result

    call free_c_vector(c_result)

  end subroutine integer_vector_from_python_interface  

  subroutine integer_from_python_sp(function, function_len, t, result, stat)
    integer, intent(in) :: function_len
    character(len = function_len), intent(in) :: function
    real(kind = c_float), intent(in) :: t
    integer, intent(out) :: result
    integer, intent(out) :: stat

    call integer_from_python(function, function_len, real(t, kind = c_double), result, stat)

  end subroutine integer_from_python_sp
 
  subroutine integer_from_python_interface(function, current_time, result, stat)
    character(len = *), intent(in) :: function
    real, intent(in) :: current_time
    integer, intent(out) :: result
    integer, optional, intent(out) :: stat

    integer :: lstat

    if(present(stat)) stat = 0

    call integer_from_python(function, len_trim(function), current_time, result, lstat)

    if(lstat /= 0) then
      if(present(stat)) then
        stat = lstat
        return
      else
        ewrite(-1, *) "Python error, Python string was:"
        ewrite(-1, *) trim(function)
        FLExit("Dying!")
      end if
    end if

  end subroutine integer_from_python_interface
  
  subroutine string_from_python_sp(function, function_len, result_len, t, result, stat)
    integer, intent(in) :: function_len
    character(len = function_len), intent(in) :: function
    integer, intent(inout) :: result_len
    real(kind = c_float), intent(in) :: t
    character(len = result_len), intent(out) :: result
    integer, intent(out) :: stat

    call string_from_python(function, function_len, result_len, real(t, kind = c_double), result, stat)

  end subroutine string_from_python_sp

  subroutine string_from_python_interface(function, t, result, stat)
    character(len = *), intent(in) :: function
    real, intent(in) :: t
    character(len = *), intent(out) :: result
    integer, optional, intent(out) :: stat

    integer :: lstat, result_len

    if(present(stat)) stat = 0
    result_len = len(result)

    call string_from_python(function, len_trim(function), result_len, t, result, lstat)
  
    if(lstat /= 0) then
      if(present(stat)) then
        stat = lstat
        return
      else
        ewrite(-1, *) "Python error, Python string was:"
        ewrite(-1, *) trim(function)
        FLExit("Dying!")
      end if
    end if

    result(result_len + 1:) = ""

  end subroutine string_from_python_interface

end module embed_python
