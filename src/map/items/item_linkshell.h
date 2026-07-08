/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#ifndef _CITEMLINKSHELL_H
#define _CITEMLINKSHELL_H

#include "common/cbasetypes.h"

#include "exdata/linkshell.h"
#include "item.h"

// TODO: The LSTYPE definition is wrong here and values are off by 1 compared to what is actually passed
// by the client. The correct values are listed in 0x0e2_set_lsmsg.h in GP_CLI_COMMAND_SET_LSMSG_WRITELEVEL
enum LSTYPE : uint8
{
    LSTYPE_NEW_LINKSHELL,
    LSTYPE_LINKSHELL,
    LSTYPE_PEARLSACK,
    LSTYPE_LINKPEARL,
    LSTYPE_BROKEN,
};

class CItemLinkshell : public CItem
{
public:
    CItemLinkshell(uint16);
    CItemLinkshell(const CItemLinkshell& other);
    virtual ~CItemLinkshell();

    uint32            GetLSID();
    LSTYPE            GetLSType();
    Exdata::lscolor_t GetLSColor();
    uint16            GetLSRawColor();
    void              SetLSID(uint32 lsid);
    void              SetLSColor(uint16 color);
    auto              getSignature() const -> const std::string override;
    void              setSignature(const std::string& signature) override;
    void              SetLSType(LSTYPE value);
};

#endif
