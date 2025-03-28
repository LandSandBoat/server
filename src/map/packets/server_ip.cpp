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

#include "server_ip.h"
#include "entities/charentity.h"
#include "utils/zoneutils.h"

CServerIPPacket::CServerIPPacket(CCharEntity* PChar, uint8 zone_type, IPP zone_ipp)
{
    this->setType(0x0B);
    this->setSize(0x1C);

    ref<uint8>(0x04)  = zone_type;
    ref<uint32>(0x08) = zone_ipp.getIP();
    ref<uint16>(0x0C) = zone_ipp.getPort();
}

auto CServerIPPacket::zoneType() const -> uint8
{
    return ref<uint8>(0x04);
}

auto CServerIPPacket::zoneIPP() const -> IPP
{
    const auto ip   = ref<uint32>(0x08);
    const auto port = ref<uint16>(0x0C);
    return IPP(ip, port);
}
