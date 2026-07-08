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

#pragma once

#include "0x063_miscdata.h"
#include "base.h"

enum class UNITY_RESULTSET : uint8_t
{
    PreviousWeek = 0x00,
    CurrentWeek  = 0x01,
};

enum class UNITY_DATATYPE : uint8_t
{
    Base    = 0x00,
    Members = 0x01,
    Points  = 0x02,
    // 0x03-0x0F: Various flags/empty data (use Base class)
    // 0x10-0x13: Data values
    Personal = 0x14,
    // 0x15-0x1F: More data values
};

namespace GP_SERV_COMMAND_MISCDATA
{

// Type 0x07: Unity Info (data: 136 bytes, total: 140 bytes)
// Multiple subtypes
namespace UNITY
{

// Base/Empty packets (dataType 0x00, 0x03-0x0F)
class BASE final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, BASE>
{
public:
    struct PacketData
    {
        GP_SERV_COMMAND_MISCDATA_TYPE type;      // PS2: type
        uint16_t                      unknown06; // PS2: (New; did not exist.)
        UNITY_RESULTSET               resultSet; // Previous week or current week
        UNITY_DATATYPE                dataType;  // Type of Unity data
        uint8_t                       padding[6];
        // For dataType 0x00 (BASE) only:
        uint32_t timestamp; // Earth seconds since Vana'diel epoch (Jan 1, 2002 00:00:00 UTC)
                            // PreviousWeek: When the Unity week ended/rankings finalized
                            // CurrentWeek: 0 (week still ongoing)
        // For dataType 0x03-0x0F: This field is unused (part of padding)
        uint8_t padding2[128];
    };

    BASE(UNITY_RESULTSET resultSet, UNITY_DATATYPE dataType);
};

// Member count packets (dataType 0x01)
class MEMBERS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, MEMBERS>
{
public:
    struct PacketData
    {
        GP_SERV_COMMAND_MISCDATA_TYPE type;      // PS2: type
        uint16_t                      unknown06; // PS2: (New; did not exist.)
        UNITY_RESULTSET               resultSet; // Previous week or current week
        UNITY_DATATYPE                dataType;  // Always MEMBERS
        uint8_t                       padding[6];
        uint16_t                      statusFlag;  // Data readiness: 0x0000 (zone-in), 0x0108 (menu)
        uint32_t                      members[11]; // Total contributing members per unity
        uint8_t                       padding2[86];
    };

    MEMBERS(UNITY_RESULTSET resultSet, const std::pair<int32, double> unityData[11]);
};

// Point count packets (dataType 0x02)
class POINTS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, POINTS>
{
public:
    struct PacketData
    {
        GP_SERV_COMMAND_MISCDATA_TYPE type;      // PS2: type
        uint16_t                      unknown06; // PS2: (New; did not exist.)
        UNITY_RESULTSET               resultSet; // Previous week or current week
        UNITY_DATATYPE                dataType;  // Always POINTS
        uint8_t                       padding[6];
        uint16_t                      statusFlag; // Data readiness: 0x0000 (zone-in), 0x0207 (PreviousWeek menu), 0x0208 (CurrentWeek menu)
        uint32_t                      points[11]; // Total points per unity
        uint8_t                       padding2[86];
    };

    POINTS(UNITY_RESULTSET resultSet, const std::pair<int32, double> unityData[11]);
};

// Personal ranking points (dataType 0x14)
class PERSONAL final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, PERSONAL>
{
public:
    struct PacketData
    {
        GP_SERV_COMMAND_MISCDATA_TYPE type;      // PS2: type
        uint16_t                      unknown06; // PS2: (New; did not exist.)
        UNITY_RESULTSET               resultSet; // Previous week or current week
        UNITY_DATATYPE                dataType;  // Always PERSONAL
        uint8_t                       padding[6];
        uint16_t                      rankingPoints; // Player's personal Unity ranking points
        uint8_t                       padding2[130];
    };

    PERSONAL(UNITY_RESULTSET resultSet, uint16_t rankingPoints);
};

// Generic 2-byte data packets (dataTypes 0x10-0x13, 0x15-0x1F)
class DATA final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, DATA>
{
public:
    struct PacketData
    {
        GP_SERV_COMMAND_MISCDATA_TYPE type;      // PS2: type
        uint16_t                      unknown06; // PS2: (New; did not exist.)
        UNITY_RESULTSET               resultSet; // Previous week or current week
        uint8_t                       dataType;  // Raw value for types 0x10-0x13, 0x15-0x1F
        uint8_t                       padding[6];
        uint16_t                      value; // Can be ASCII, flags, or numeric data
        uint8_t                       padding2[130];
    };

    DATA(UNITY_RESULTSET resultSet, uint8_t dataType, uint16_t value);
};

} // namespace UNITY
} // namespace GP_SERV_COMMAND_MISCDATA
