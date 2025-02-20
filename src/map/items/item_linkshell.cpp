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

#include "item_linkshell.h"

#include "common/socket.h"
#include "common/utils.h"

#include <cstring>

CItemLinkshell::CItemLinkshell(uint16 id)
: CItem(id)
{
    setType(ITEM_LINKSHELL);
}

CItemLinkshell::~CItemLinkshell() = default;

uint32 CItemLinkshell::GetLSID()
{
    return ref<uint32>(m_extra, 0x00);
}

void CItemLinkshell::SetLSID(uint32 lsid)
{
    ref<uint32>(m_extra, 0x00) = lsid;
}

LSTYPE CItemLinkshell::GetLSType()
{
    return ref<LSTYPE>(m_extra, 0x08);
}

lscolor_t CItemLinkshell::GetLSColor()
{
    return *(lscolor_t*)(m_extra + 0x06);
}

uint16 CItemLinkshell::GetLSRawColor()
{
    return ref<uint16>(m_extra, 0x06);
}

void CItemLinkshell::SetLSColor(uint16 color)
{
    ref<uint16>(m_extra, 0x06) = color;
}

const std::string CItemLinkshell::getSignature()
{
    char signature[LinkshellStringLength] = {};
    std::memcpy(&signature, m_extra + 0x09, sizeof(signature));

    return signature; // return string copy
}

void CItemLinkshell::setSignature(std::string const& signature)
{
    std::memset(m_extra + 0x09, 0, sizeof(m_extra) - 0x09);
    std::memcpy(m_extra + 0x09, signature.c_str(), signature.size());
}

void CItemLinkshell::SetLSType(LSTYPE value)
{
    ref<LSTYPE>(m_extra, 0x08) = value;
}
