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

#include "base_entity.h"

class CNpcEntity final : public CBaseEntity
{
public:
    CNpcEntity();
    ~CNpcEntity() override;

    uint32 entityFlags() const;                // Returns the current value in m_flags
    void   setEntityFlags(uint32 EntityFlags); // Change the current value in m_flags

    void hideHP(bool hide);
    bool hpHidden() const;

    void setUntargetable(bool untargetable);
    bool GetUntargetable() const override;

    bool triggerable() const;
    void setTriggerable(bool triggerable);

    auto widescan() const -> uint8;
    void setWidescan(uint8 widescan);

    bool alwaysRelevant() const;
    void setAlwaysRelevant(bool alwaysRelevant);

    //
    // CBaseEntity
    //

    bool isWideScannable() override;
    void PostTick() override;

    auto Tick(timer::time_point) -> Task<void> override
    {
        co_return;
    }

    //
    // Public NPC data still referenced directly across the codebase.
    //

    uint32 m_flags{};
    uint8  name_prefix{};

private:
    uint8 widescan_    = 1;
    bool  triggerable_ = false;

    // Spawn this NPC in for players at all times, used for port bastok bridge, "moving" objects (elevators / maybe
    // airships), major zone elements like la theine rainbow, altepa gate pillars, etc.
    bool alwaysRelevant_ = false;
};
