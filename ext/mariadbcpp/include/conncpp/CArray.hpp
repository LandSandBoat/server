/************************************************************************************
   Copyright (C) 2020 MariaDB Corporation AB

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with this library; if not see <http://www.gnu.org/licenses>
   or write to the Free Software Foundation, Inc.,
   51 Franklin St., Fifth Floor, Boston, MA 02110, USA
*************************************************************************************/


#ifndef _CARRAY_H_
#define _CARRAY_H_

#include "buildconf.hpp"
#include <initializer_list>
#include <vector>


namespace sql
{
  /* Simple C array wrapper template for use to pass arrays from connector */
  template <class T> struct CArray
  {
    T* arr;
    int64_t length;

    operator T*()
    {
      return arr;
    }
    operator const T*() const
    {
      return arr;
    }

    operator bool()
    {
      return arr != nullptr;
    }

    CArray(int64_t len);
    CArray(int64_t len, const T& fillValue);

    /* This constructor takes existing(stack?) array for "storing". Won't delete */
    CArray(T _arr[], size_t len);
    CArray(const T _arr[], size_t len);

    ~CArray();

    T* begin() { return arr; }
    T* end();

    std::size_t size() const { return end() - begin(); }
    const T* begin() const { return arr; }
    const T* end() const;

    CArray(std::initializer_list<T> const& initList);
    CArray(const CArray& rhs);

    CArray() : arr(nullptr), length(0)
    {}

    void assign(const T* _arr, std::size_t size= 0);
    CArray<T>& wrap(T* _arr, std::size_t size);
    CArray<T>& wrap(std::vector<T>& _vector);
    void reserve(std::size_t size);
  };

  MARIADB_EXTERN template struct MARIADB_EXPORTED CArray<char>;
  MARIADB_EXTERN template struct MARIADB_EXPORTED CArray<int32_t>;
  MARIADB_EXTERN template struct MARIADB_EXPORTED CArray<int64_t>;

  typedef CArray<char> bytes;
  typedef CArray<int32_t> Ints;
  typedef CArray<int64_t> Longs;
}
#endif
