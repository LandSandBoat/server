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

#include "entities/charentity.h"
#include "status_effect.h"

namespace puppetutils
{

void LoadAutomaton(CCharEntity* PChar);
void SaveAttachments(CCharEntity* PChar);
void SaveAutomaton(CCharEntity* PChar);
auto UnlockAttachment(CCharEntity* PChar, const CItem* PItem) -> bool;
auto HasAttachment(const CCharEntity* PChar, const CItem* PItem) -> bool;
void setAttachment(CCharEntity* PChar, uint8 slotId, uint8 attachment);
void setFrame(CCharEntity* PChar, AutomatonFrame frame);
void setHead(CCharEntity* PChar, AutomatonHead head);
auto getSkillCap(const CCharEntity* PChar, SKILLTYPE skill, uint8 level) -> uint16;
void TrySkillUP(CAutomatonEntity* PAutomaton, SKILLTYPE SkillID, uint8 lvl);
void CheckAttachmentsForManeuver(const CCharEntity* PChar, EFFECT maneuver, bool gain);
void EquipAttachments(CAutomatonEntity* PAutomaton);
void UpdateAttachments(const CCharEntity* PChar);
void PreLevelRestriction(const CCharEntity* PChar);
void PostLevelRestriction(const CCharEntity* PChar);

}; // namespace puppetutils
