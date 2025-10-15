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

#include "0x061_clistatus.h"

#include <cstring>

#include "entities/charentity.h"
#include "items/item_weapon.h"
#include "modifier.h"
#include "roe.h"
#include "utils/charutils.h"

GP_SERV_COMMAND_CLISTATUS::GP_SERV_COMMAND_CLISTATUS(CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.statusdata.hpmax    = PChar->GetMaxHP();
    packet.statusdata.mpmax    = PChar->GetMaxMP();
    packet.statusdata.mjob_no  = PChar->GetMJob();
    packet.statusdata.mjob_lv  = PChar->GetMLevel();
    packet.statusdata.sjob_no  = PChar->GetSJob();
    packet.statusdata.sjob_lv  = PChar->GetSLevel();
    packet.statusdata.exp_now  = PChar->jobs.exp[PChar->GetMJob()];
    packet.statusdata.exp_next = charutils::GetExpNEXTLevel(PChar->jobs.job[PChar->GetMJob()]);

    std::memcpy(packet.statusdata.bp_base, &PChar->stats, sizeof(packet.statusdata.bp_base));

    // Hasso gives STR only if main weapon is two handed
    if (const auto* weapon = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[SLOT_MAIN]); weapon && weapon->isTwoHanded())
    {
        packet.statusdata.bp_adj[0] = std::clamp<int16>(PChar->getMod(Mod::STR) + PChar->getMod(Mod::TWOHAND_STR), -999 + PChar->stats.STR, 999 - PChar->stats.STR);
    }
    else
    {
        packet.statusdata.bp_adj[0] = std::clamp<int16>(PChar->getMod(Mod::STR), -999 + PChar->stats.STR, 999 - PChar->stats.STR);
    }
    packet.statusdata.bp_adj[1] = std::clamp<int16>(PChar->getMod(Mod::DEX), -999 + PChar->stats.DEX, 999 - PChar->stats.DEX);
    packet.statusdata.bp_adj[2] = std::clamp<int16>(PChar->getMod(Mod::VIT), -999 + PChar->stats.VIT, 999 - PChar->stats.VIT);
    packet.statusdata.bp_adj[3] = std::clamp<int16>(PChar->getMod(Mod::AGI), -999 + PChar->stats.AGI, 999 - PChar->stats.AGI);
    packet.statusdata.bp_adj[4] = std::clamp<int16>(PChar->getMod(Mod::INT), -999 + PChar->stats.INT, 999 - PChar->stats.INT);
    packet.statusdata.bp_adj[5] = std::clamp<int16>(PChar->getMod(Mod::MND), -999 + PChar->stats.MND, 999 - PChar->stats.MND);
    packet.statusdata.bp_adj[6] = std::clamp<int16>(PChar->getMod(Mod::CHR), -999 + PChar->stats.CHR, 999 - PChar->stats.CHR);

    packet.statusdata.atk = PChar->ATT(SLOT_MAIN);
    packet.statusdata.def = PChar->DEF();

    packet.statusdata.def_elem[0] = PChar->getMod(Mod::FIRE_MEVA);
    packet.statusdata.def_elem[1] = PChar->getMod(Mod::ICE_MEVA);
    packet.statusdata.def_elem[2] = PChar->getMod(Mod::WIND_MEVA);
    packet.statusdata.def_elem[3] = PChar->getMod(Mod::EARTH_MEVA);
    packet.statusdata.def_elem[4] = PChar->getMod(Mod::THUNDER_MEVA);
    packet.statusdata.def_elem[5] = PChar->getMod(Mod::WATER_MEVA);
    packet.statusdata.def_elem[6] = PChar->getMod(Mod::LIGHT_MEVA);
    packet.statusdata.def_elem[7] = PChar->getMod(Mod::DARK_MEVA);

    packet.statusdata.designation = PChar->profile.title;
    packet.statusdata.rank        = PChar->profile.rank[PChar->profile.nation];
    packet.statusdata.rankbar     = PChar->profile.rankpoints;
    packet.statusdata.BindZoneNo  = PChar->profile.home_point.destination;
    packet.statusdata.nation      = PChar->profile.nation;

    packet.statusdata.su_lv        = PChar->getMod(Mod::SUPERIOR_LEVEL);
    packet.statusdata.highest_ilvl = charutils::getMaxItemLevel(PChar);
    packet.statusdata.ilvl         = charutils::getItemLevelDifference(PChar);
    packet.statusdata.ilvl_mhand   = charutils::getMainhandItemLevel(PChar);
    packet.statusdata.ilvl_ranged  = charutils::getRangedItemLevel(PChar);

    uint8 unityRank                      = PChar->profile.unity_leader > 0 ? roeutils::RoeSystem.unityLeaderRank[PChar->profile.unity_leader - 1] : 0;
    packet.statusdata.unity_info.Faction = PChar->profile.unity_leader;
    packet.statusdata.unity_info.Unknown = unityRank;
    packet.statusdata.unity_info.Points  = charutils::GetPoints(PChar, "unity_accolades");
    packet.statusdata.unity_points1      = charutils::GetPoints(PChar, "current_accolades") / 1000;
    packet.statusdata.unity_points2      = charutils::GetPoints(PChar, "prev_accolades") / 1000;
}
