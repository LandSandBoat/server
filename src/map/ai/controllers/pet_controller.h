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

#include "mob_controller.h"

class CPetController : public CMobController
{
public:
    CPetController(CMobEntity* PPet);

    static constexpr float PetRoamDistance{ 2.1f };
    auto                   DoRoamTick(timer::time_point tick) -> Task<void> override;
    auto                   PetSkill(uint16 targid, uint16 abilityid) const -> bool;

protected:
    auto PetIsHealing() const -> bool;

    auto Tick(timer::time_point tick) -> Task<void> override;
    auto DoBuffTick() -> bool override;
    void HandleEnmity() override;
    auto TryDeaggro() -> bool override;
    void TryLink() override;
    auto Ability(uint16 targid, uint16 abilityid) -> bool override;

private:
    CMobEntity* const PPet;
};
