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

#include "common/utils.h"
#include "exdata/linkshell.h"

CItemLinkshell::CItemLinkshell(const uint16 id)
: CItem(id)
{
    setType(ITEM_LINKSHELL);
}

CItemLinkshell::CItemLinkshell(const CItemLinkshell& other)
: CItem(other)
{
}

CItemLinkshell::~CItemLinkshell() = default;

uint32 CItemLinkshell::GetLSID()
{
    return this->exdata<Exdata::Linkshell>().GroupId;
}

void CItemLinkshell::SetLSID(const uint32 lsid)
{
    this->exdata<Exdata::Linkshell>().GroupId = lsid;
}

LSTYPE CItemLinkshell::GetLSType()
{
    return static_cast<LSTYPE>(this->exdata<Exdata::Linkshell>().Flag);
}

auto CItemLinkshell::GetLSColor() -> Exdata::lscolor_t
{
    return this->exdata<Exdata::Linkshell>().Color;
}

uint16 CItemLinkshell::GetLSRawColor()
{
    uint16 raw = 0;
    std::memcpy(&raw, &this->exdata<Exdata::Linkshell>().Color, sizeof(raw));
    return raw;
}

void CItemLinkshell::SetLSColor(const uint16 color)
{
    std::memcpy(&this->exdata<Exdata::Linkshell>().Color, &color, sizeof(color));
}

auto CItemLinkshell::getSignature() const -> const std::string
{
    auto& name                           = this->exdata<Exdata::Linkshell>().Name;
    char  decoded[LinkshellStringLength] = {};
    DecodeStringLinkshell(std::string(reinterpret_cast<const char*>(name), sizeof(name)), decoded);
    return decoded;
}

void CItemLinkshell::setSignature(const std::string& signature)
{
    auto& name                           = this->exdata<Exdata::Linkshell>().Name;
    char  encoded[LinkshellStringLength] = {};
    EncodeStringLinkshell(signature, encoded);
    std::memset(name, 0, sizeof(name));
    std::memcpy(name, encoded, std::min(sizeof(encoded), sizeof(name)));
}

void CItemLinkshell::SetLSType(const LSTYPE value)
{
    this->exdata<Exdata::Linkshell>().Flag = static_cast<uint8_t>(value);
}
