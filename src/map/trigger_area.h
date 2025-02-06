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

#pragma once

#include "common/cbasetypes.h"
#include "common/mmo.h"

#include <memory>

class ITriggerArea
{
public:
    ITriggerArea(uint32 triggerAreaID);
    virtual ~ITriggerArea() = default;

    uint32 getTriggerAreaID() const;

    int16 getCount() const;
    int16 addCount(int16 count);
    int16 delCount(int16 count);

    virtual bool isPointInside(position_t pos) const            = 0;
    virtual bool isPointInside(float x, float y, float z) const = 0;

private:
    uint32 m_triggerAreaID;
    int16  m_count; // number of characters in the trigger area
};

class CCuboidTriggerArea final : public ITriggerArea
{
public:
    CCuboidTriggerArea(uint32 triggerAreaID, float xMin, float yMin, float zMin, float xMax, float yMax, float zMax);

    bool isPointInside(float x, float y, float z) const override;
    bool isPointInside(position_t pos) const override;

private:
    float m_xMin;
    float m_yMin;
    float m_zMin;
    float m_xMax;
    float m_yMax;
    float m_zMax;
};

class CCylindricalTriggerArea final : public ITriggerArea
{
public:
    CCylindricalTriggerArea(uint32 triggerAreaID, float xPos, float zPos, float radius);

    bool isPointInside(float x, float y, float z) const override;
    bool isPointInside(position_t pos) const override;

private:
    float m_xPos;
    float m_zPos;
    float m_radius;
};

class CSphericalTriggerArea final : public ITriggerArea
{
public:
    CSphericalTriggerArea(uint32 triggerAreaID, float xPos, float yPos, float zPos, float radius);

    bool isPointInside(float x, float y, float z) const override;
    bool isPointInside(position_t pos) const override;

private:
    float m_xPos;
    float m_yPos;
    float m_zPos;
    float m_radius;
};
