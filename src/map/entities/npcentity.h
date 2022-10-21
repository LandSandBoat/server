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

#ifndef _NPCENTITY_H
#define _NPCENTITY_H

#include "common/cbasetypes.h"
#include "common/taskmgr.h"

#include "baseentity.h"

class CNpcEntity : public CBaseEntity
{
public:
    uint32       m_flags;
    uint8        name_prefix;
    uint8        widescan;
    bool         m_triggerable = false;
    uint32       getEntityFlags() const;             // Returns the current value in m_flags
    void         setEntityFlags(uint32 EntityFlags); // Change the current value in m_flags
    void         HideHP(bool hide);
    bool         IsHPHidden() const;
    void         SetUntargetable(bool untargetable);
    bool         GetUntargetable() const override;
    bool         IsTriggerable() const;
    virtual bool isWideScannable() override;
    virtual void PostTick() override;
    virtual void Tick(time_point) override
    {
    }

    CNpcEntity();
    ~CNpcEntity();

private:
};

#endif
