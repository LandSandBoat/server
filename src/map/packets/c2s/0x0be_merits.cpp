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

#include "0x0be_merits.h"

#include "entities/charentity.h"
#include "packets/char_status.h"
#include "packets/char_sync.h"
#include "packets/s2c/0x029_battle_message.h"
#include "packets/s2c/0x061_clistatus.h"
#include "packets/s2c/0x062_clistatus2.h"
#include "packets/s2c/0x063_miscdata_merits.h"
#include "packets/s2c/0x063_miscdata_monstrosity.h"
#include "packets/s2c/0x08c_merit.h"
#include "packets/s2c/0x0ac_command_data.h"
#include "packets/s2c/0x119_abil_recast.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_MERITS::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_MERITS_KIND>(Kind)
        .oneOf<GP_CLI_COMMAND_MERITS_PARAM1>(Param1);
}

void GP_CLI_COMMAND_MERITS::process(MapSession* PSession, CCharEntity* PChar) const
{
    switch (static_cast<GP_CLI_COMMAND_MERITS_KIND>(Kind))
    {
        case GP_CLI_COMMAND_MERITS_KIND::ChangeMode:
        {
            // Note: While the client restricts the ability to change mode during besieged and when level restricted
            //     : Retail server will still honor an injected request and change the mode.
            if (db::preparedStmt("UPDATE char_exp SET mode = ? WHERE charid = ? LIMIT 1", Param1, PChar->id))
            {
                PChar->MeritMode = Param1;
                PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MERITS>(PChar);
                PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MONSTROSITY1>(PChar);
                PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MONSTROSITY2>(PChar);
            }
        }
        break;

        case GP_CLI_COMMAND_MERITS_KIND::EditMode:
        {
            if (PChar->inMogHouse()) // Note: This has been verified as allowed in a shared mog house.
            {
                if (const auto merit = static_cast<MERIT_TYPE>(Param2 << 1); PChar->PMeritPoints->IsMeritExist(merit))
                {
                    const Merit_t* PMerit = PChar->PMeritPoints->GetMerit(merit);

                    switch (static_cast<GP_CLI_COMMAND_MERITS_PARAM1>(Param1))
                    {
                        case GP_CLI_COMMAND_MERITS_PARAM1::Lower:
                            PChar->PMeritPoints->LowerMerit(merit);
                            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, Param2, PMerit->count, MsgBasic::MERIT_DECREASE);
                            break;
                        case GP_CLI_COMMAND_MERITS_PARAM1::Raise:
                            PChar->PMeritPoints->RaiseMerit(merit);
                            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, Param2, PMerit->count, MsgBasic::MERIT_INCREASE);
                            break;
                    }

                    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MERITS>(PChar);
                    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MONSTROSITY1>(PChar);
                    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MONSTROSITY2>(PChar);
                    PChar->pushPacket<GP_SERV_COMMAND_MERIT>(PChar, merit);

                    charutils::SaveCharExp(PChar, PChar->GetMJob());
                    PChar->PMeritPoints->SaveMeritPoints(PChar->id);

                    charutils::BuildingCharSkillsTable(PChar);
                    charutils::CalculateStats(PChar);
                    charutils::CheckValidEquipment(PChar);
                    charutils::BuildingCharAbilityTable(PChar);
                    charutils::BuildingCharTraitsTable(PChar);

                    PChar->UpdateHealth();
                    PChar->addHP(PChar->GetMaxHP());
                    PChar->addMP(PChar->GetMaxMP());
                    PChar->pushPacket<CCharStatusPacket>(PChar);
                    PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS>(PChar);
                    PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS2>(PChar);
                    PChar->pushPacket<GP_SERV_COMMAND_ABIL_RECAST>(PChar);
                    PChar->pushPacket<GP_SERV_COMMAND_COMMAND_DATA>(PChar);
                    charutils::SendExtendedJobPackets(PChar);
                    PChar->pushPacket<CCharSyncPacket>(PChar);
                }
            }
        }
        break;
    }
}
