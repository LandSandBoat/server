/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "0x063_miscdata_unity.h"

GP_SERV_COMMAND_MISCDATA::UNITY::BASE::BASE(const UNITY_RESULTSET resultSet, const UNITY_DATATYPE dataType)
{
    auto& packet = this->data();

    packet.type      = GP_SERV_COMMAND_MISCDATA_TYPE::Unity;
    packet.unknown06 = sizeof(PacketData);
    packet.resultSet = resultSet;
    packet.dataType  = dataType;

    // Set timestamp for BASE packets (type 0x00)
    // This is the Vana'diel timestamp of when Unity rankings were last finalized
    if (dataType == UNITY_DATATYPE::Base && resultSet == UNITY_RESULTSET::PreviousWeek)
    {
        // TODO: Get actual last Unity reset timestamp
        // For now, use current Vana'diel time as placeholder
        packet.timestamp = earth_time::vanadiel_timestamp();
    }
}

GP_SERV_COMMAND_MISCDATA::UNITY::MEMBERS::MEMBERS(const UNITY_RESULTSET resultSet, const std::pair<int32, double> unityData[11])
{
    auto& packet = this->data();

    packet.type       = GP_SERV_COMMAND_MISCDATA_TYPE::Unity;
    packet.unknown06  = sizeof(PacketData);
    packet.resultSet  = resultSet;
    packet.dataType   = UNITY_DATATYPE::Members;
    packet.statusFlag = 0x0108; // Data ready flag (bit 3 and 8 set)

    for (uint8 i = 0; i < 11; i++)
    {
        packet.members[i] = unityData[i].first;
    }
}

GP_SERV_COMMAND_MISCDATA::UNITY::POINTS::POINTS(const UNITY_RESULTSET resultSet, const std::pair<int32, double> unityData[11])
{
    auto& packet = this->data();

    packet.type      = GP_SERV_COMMAND_MISCDATA_TYPE::Unity;
    packet.unknown06 = sizeof(PacketData);
    packet.resultSet = resultSet;
    packet.dataType  = UNITY_DATATYPE::Points;

    // Set status flag based on result set
    // PreviousWeek: 0x0207 (bits 0-2, 9)
    // CurrentWeek:  0x0208 (bit 3, 9)
    packet.statusFlag = (resultSet == UNITY_RESULTSET::PreviousWeek) ? 0x0207 : 0x0208;

    for (uint8 i = 0; i < 11; i++)
    {
        packet.points[i] = unityData[i].second;
    }
}

GP_SERV_COMMAND_MISCDATA::UNITY::PERSONAL::PERSONAL(const UNITY_RESULTSET resultSet, const uint16_t rankingPoints)
{
    auto& packet = this->data();

    packet.type          = GP_SERV_COMMAND_MISCDATA_TYPE::Unity;
    packet.unknown06     = sizeof(PacketData);
    packet.resultSet     = resultSet;
    packet.dataType      = UNITY_DATATYPE::Personal;
    packet.rankingPoints = rankingPoints;
}

GP_SERV_COMMAND_MISCDATA::UNITY::DATA::DATA(const UNITY_RESULTSET resultSet, const uint8_t dataType, const uint16_t value)
{
    auto& packet = this->data();

    packet.type      = GP_SERV_COMMAND_MISCDATA_TYPE::Unity;
    packet.unknown06 = sizeof(PacketData);
    packet.resultSet = resultSet;
    packet.dataType  = dataType;
    packet.value     = value;
}
