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

#ifndef _ITRIGGER_AREA_H
#define _ITRIGGER_AREA_H

#include "common/cbasetypes.h"
#include "common/mmo.h"

class ITriggerArea
{
public:
    ITriggerArea(uint32 _triggerAreaID);
    virtual ~ITriggerArea() = default;

    uint32 GetTriggerAreaID() const;

    int16 GetCount() const;
    int16 AddCount(int16 count);
    int16 DelCount(int16 count);

    virtual bool IsPointInside(position_t pos) const            = 0;
    virtual bool IsPointInside(float x, float y, float z) const = 0;

    // NOTE: This is only used for a sanity check BEFORE runtime, so it doesn't matter
    //     : that it's a bit janky. If this EVER gets used at runtime it will need to be
    //     : cleaned up!
    virtual bool IntersectsOtherTriggerArea(std::unique_ptr<ITriggerArea> const& other) const = 0;

private:
    uint32 m_TriggerAreaID;
    int16  m_Count; // number of characters in the trigger area
};

class CCuboidTriggerArea : public ITriggerArea
{
public:
    CCuboidTriggerArea(uint32 _triggerAreaID, float _xMin, float _yMin, float _zMin, float _xMax, float _yMax, float _zMax);

    bool IsPointInside(float x, float y, float z) const override;
    bool IsPointInside(position_t pos) const override;
    bool IntersectsOtherTriggerArea(std::unique_ptr<ITriggerArea> const& other) const override;

    float xMin;
    float yMin;
    float zMin;
    float xMax;
    float yMax;
    float zMax;
};

class CCylindricalTriggerArea : public ITriggerArea
{
public:
    CCylindricalTriggerArea(uint32 _triggerAreaID, float _xPos, float _zPos, float _radius);

    bool IsPointInside(float x, float y, float z) const override;
    bool IsPointInside(position_t pos) const override;
    bool IntersectsOtherTriggerArea(std::unique_ptr<ITriggerArea> const& other) const override;

    float xPos;
    float zPos;
    float radius;
};

class CSphericalTriggerArea : public ITriggerArea
{
public:
    CSphericalTriggerArea(uint32 _triggerAreaID, float _xPos, float _yPos, float _zPos, float _radius);

    bool IsPointInside(float x, float y, float z) const override;
    bool IsPointInside(position_t pos) const override;
    bool IntersectsOtherTriggerArea(std::unique_ptr<ITriggerArea> const& other) const override;

    float xPos;
    float yPos;
    float zPos;
    float radius;
};

#endif // _ITRIGGER_AREA_H
