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

#include "item.h"

struct lscolor_t
{
    uint8 R : 4;
    uint8 G : 4;
    uint8 B : 4;
    uint8 A : 4;
};

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
    virtual ~CItemLinkshell();

    uint32                    GetLSID();
    LSTYPE                    GetLSType();
    lscolor_t                 GetLSColor();
    uint16                    GetLSRawColor();
    void                      SetLSID(uint32 lsid);
    void                      SetLSColor(uint16 color);
    virtual const std::string getSignature();
    virtual void              setSignature(std::string signature);
    void                      SetLSType(LSTYPE value);

private:
};

#endif
