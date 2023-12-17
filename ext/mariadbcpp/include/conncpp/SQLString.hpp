/************************************************************************************
   Copyright (C) 2020, 2021 MariaDB Corporation AB

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

#ifndef _SQLSTRING_H_
#define _SQLSTRING_H_

#include <memory>
#include <string>

#include "buildconf.hpp"

namespace sql
{
class StringImp;

#pragma warning(push)
#pragma warning(disable:4251)

class MARIADB_EXPORTED SQLString final {

  friend class StringImp;

  std::unique_ptr<StringImp> theString;
public:
  SQLString(const SQLString&);
  SQLString(SQLString&&); //Move constructor
  SQLString(const std::string& str) : SQLString(str.c_str(), str.length()) {}
  SQLString(const char* str);
  SQLString(const char* str, std::size_t count);
  SQLString();
  ~SQLString();

  static constexpr std::size_t npos{static_cast<std::size_t>(-1)};
  const char * c_str() const;
  SQLString& operator=(const SQLString&);
  //operator std::string() { return std::string(this->c_str(), this->length()); }
  operator const char* () const;
  SQLString& operator=(const char * right);
  bool operator <(const SQLString&) const;

  bool empty() const;
  int compare(const SQLString& str) const;
  int compare(std::size_t pos1, std::size_t count1, const char* s, std::size_t count2) const;
  int caseCompare(const SQLString& other) const;
  SQLString & append(const SQLString& addition);
  SQLString & append(const char * const addition);
  SQLString & append(const char * const addition, std::size_t len);
  SQLString & append(char c);
  SQLString substr(std::size_t pos= 0, size_t count=npos) const;
  std::size_t find_first_of(const SQLString& str, std::size_t pos = 0) const;
  std::size_t find_first_of(const char* str, std::size_t pos = 0) const;
  std::size_t find_first_of(const char ch, std::size_t pos = 0) const;
  std::size_t find_last_of(const SQLString& str, std::size_t pos=npos) const;
  std::size_t find_last_of(const char* str, std::size_t pos=npos) const;
  std::size_t find_last_of(const char ch, std::size_t pos=npos) const;
  std::size_t size() const;
  std::size_t length() const;
  void reserve(std::size_t n= 0);
  char& at(std::size_t pos);
  const char& at(std::size_t pos) const;
  std::string::iterator begin();
  std::string::iterator end();
  std::string::const_iterator begin() const;
  std::string::const_iterator end() const;
  std::string::const_iterator cbegin() const { return begin(); }
  std::string::const_iterator cend() const { return end(); }
  void clear();

  /* Few extensions to mimic some java's String functionality. Probably should be moved to standalone functions */
  int64_t hashCode() const;
  bool startsWith(const SQLString &str) const;
  bool endsWith(const SQLString &str) const;
  SQLString& toUpperCase();
  SQLString& toLowerCase();
  SQLString& ltrim();
  SQLString& rtrim();
  SQLString& trim();
};

MARIADB_EXPORTED SQLString operator+(const SQLString& str1, const SQLString & str2);
//SQLString operator+(const SQLString & str1, const char* str2);
MARIADB_EXPORTED bool operator==(const SQLString& str1, const SQLString & str2);
MARIADB_EXPORTED bool operator==(const SQLString& str1, const char* str2);
MARIADB_EXPORTED bool operator==(const char* str1, const SQLString& str2);
inline bool operator==(const SQLString& str1, const std::string& str2) { return str1.compare(0, str1.length(), str2.c_str(), str2.length()) == 0; }
inline bool operator==(const std::string& str1, const SQLString& str2) { return str2.compare(0, str2.length(), str1.c_str(), str1.length()) == 0; }
MARIADB_EXPORTED bool operator!=(const SQLString& str1, const SQLString & str2);
MARIADB_EXPORTED bool operator!=(const SQLString& str1, const char* str2);
MARIADB_EXPORTED bool operator!=(const char* str1, const SQLString& str2);
inline bool operator!=(const SQLString& str1, const std::string& str2) { return !(str1 == str2); }
inline bool operator!=(const std::string& str1, const SQLString& str2) { return !(str1 == str2); }

MARIADB_EXPORTED std::ostream& operator<<(std::ostream& stream, const SQLString& str);
}
#pragma warning(pop)
#endif
