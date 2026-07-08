/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "enums/exdata.h"

#include "exdata/base.h"

#include "exdata/appraisable.h"
#include "exdata/assault_log.h"
#include "exdata/augment_bundle.h"
#include "exdata/augment_mezzotint.h"
#include "exdata/augment_standard.h"
#include "exdata/augment_trial.h"
#include "exdata/betting_slip.h"
#include "exdata/brenner_book.h"
#include "exdata/chocobo_card.h"
#include "exdata/chocobo_egg.h"
#include "exdata/crafting_set.h"
#include "exdata/escutcheon.h"
#include "exdata/evolith.h"
#include "exdata/fish.h"
#include "exdata/flower_pot.h"
#include "exdata/furniture.h"
#include "exdata/glowing_lamp.h"
#include "exdata/honeymoon_ticket.h"
#include "exdata/legion_pass.h"
#include "exdata/linkshell.h"
#include "exdata/lottery_ticket.h"
#include "exdata/mannequin.h"
#include "exdata/meeble_grimoire.h"
#include "exdata/perpetual_hourglass.h"
#include "exdata/race_certificate.h"
#include "exdata/serialized.h"
#include "exdata/soul_plate.h"
#include "exdata/soul_reflector.h"
#include "exdata/tabula.h"
#include "exdata/timer_info.h"
#include "exdata/weapon_unlock.h"
#include "exdata/worn_item.h"

class CItem;

namespace Exdata
{

auto getType(const CItem* item) -> Type;

auto toTable(const CItem* item, sol::table& table) -> bool;
auto fromTable(CItem* item, const sol::table& data) -> bool;

} // namespace Exdata
