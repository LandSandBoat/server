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

#include "augment_trial.h"

#include "common/lua.h"

void Exdata::AugmentTrial::toTable(sol::table& table) const
{
    table["augmentKind"]    = static_cast<uint8_t>(this->AugmentKind);
    table["augmentSubKind"] = static_cast<uint8_t>(this->AugmentSubKind);

    sol::table augments = lua.create_table();
    for (size_t i = 0; i < std::size(this->Augments); ++i)
    {
        sol::table aug  = lua.create_table();
        aug["id"]       = this->Augments[i].Id;
        aug["value"]    = this->Augments[i].Value;
        augments[i + 1] = aug;
    }
    table["augments"]  = augments;
    sol::table trial   = lua.create_table();
    trial["id"]        = this->TrialId;
    trial["completed"] = static_cast<bool>(this->Completed);
    table["trial"]     = trial;
    table["signature"] = Exdata::decodeSignature(this->Signature);
}

void Exdata::AugmentTrial::fromTable(const sol::table& data)
{
    this->AugmentKind    = Exdata::get_or<AugmentKindFlags>(data, "augmentKind", this->AugmentKind);
    this->AugmentSubKind = Exdata::get_or<AugmentSubKindFlags>(data, "augmentSubKind", this->AugmentSubKind);

    if (sol::optional<sol::table> augments = data["augments"])
    {
        for (size_t i = 0; i < std::size(this->Augments); ++i)
        {
            if (sol::optional<sol::table> entry = (*augments)[i + 1])
            {
                this->Augments[i].Id    = Exdata::get_or<uint16_t>(*entry, "id", this->Augments[i].Id);
                this->Augments[i].Value = Exdata::get_or<uint16_t>(*entry, "value", this->Augments[i].Value);
            }
        }
    }

    if (sol::optional<sol::table> trialTable = data["trial"])
    {
        this->TrialId   = Exdata::get_or<uint16_t>(*trialTable, "id", this->TrialId);
        this->Completed = Exdata::get_or<bool>(*trialTable, "completed", this->Completed);
    }

    if (sol::optional<std::string> sig = data["signature"])
    {
        Exdata::encodeSignature(*sig, this->Signature);
    }
}
