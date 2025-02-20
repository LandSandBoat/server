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

#ifndef _PUPUTILS_H
#define _PUPUTILS_H

#include "entities/charentity.h"
#include "items/item_puppet.h"
#include "status_effect.h"

namespace puppetutils
{
    void   LoadAutomaton(CCharEntity* PChar);
    void   SaveAutomaton(CCharEntity* PChar);
    bool   UnlockAttachment(CCharEntity* PChar, CItem* PItem);
    bool   HasAttachment(CCharEntity* PChar, CItem* PItem);
    void   setAttachment(CCharEntity* PChar, uint8 slotId, uint8 attachment);
    void   setFrame(CCharEntity* PChar, uint8 frame);
    void   setHead(CCharEntity* PChar, uint8 head);
    uint16 getSkillCap(CCharEntity* PChar, SKILLTYPE skill, uint8 level);
    void   TrySkillUP(CAutomatonEntity* PAutomaton, SKILLTYPE SkillID, uint8 lvl);
    void   CheckAttachmentsForManeuver(CCharEntity* PChar, EFFECT maneuver, bool gain);
    void   EquipAttachments(CAutomatonEntity* PAutomaton);
    void   UpdateAttachments(CCharEntity* PChar);
    void   PreLevelRestriction(CCharEntity* PChar);
    void   PostLevelRestriction(CCharEntity* PChar);
}; // namespace puppetutils

#endif
