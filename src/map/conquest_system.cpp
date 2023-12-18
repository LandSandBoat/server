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

#include "conquest_system.h"

#include "common/mmo.h"
#include "common/vana_time.h"
#include "entities/charentity.h"
#include "message.h"
#include "utils/charutils.h"
#include "utils/zoneutils.h"

#include "packets/conquest_map.h"

#include "latent_effect_container.h"
#include "lua/luautils.h"

namespace conquest
{
    static std::shared_ptr<ConquestData> conquestData;

    std::shared_ptr<ConquestData> GetConquestData()
    {
        if (conquestData == nullptr)
        {
            conquestData = std::make_shared<ConquestData>(_sql);
        }

        return conquestData;
    }

    void HandleZMQMessage(uint8* data)
    {
        uint8 subtype = ref<uint8>(data, 1);
        switch (subtype)
        {
            case CONQUEST_WORLD2MAP_WEEKLY_UPDATE_START:
            {
                HandleWeeklyTallyStart();
                break;
            }
            case CONQUEST_WORLD2MAP_WEEKLY_UPDATE_END:
            {
                const std::size_t headerLength = 2 * sizeof(uint8) + sizeof(std::size_t);
                const std::size_t size         = ref<std::size_t>(data, 2);

                std::vector<region_control_t> regionControls = std::vector<region_control_t>(size);
                for (std::size_t i = 0; i < size; i++)
                {
                    const std::size_t start = headerLength + i * sizeof(region_control_t);

                    region_control_t regionControl{};
                    regionControl.current = ref<uint8>(data, start);
                    regionControl.prev    = ref<uint8>(data, start + 1);

                    regionControls[i] = regionControl;
                }

                HandleWeeklyTallyEnd(regionControls);
                break;
            }
            case CONQUEST_WORLD2MAP_INFLUENCE_POINTS:
            {
                const std::size_t        headerLength      = 2 * sizeof(uint8) + sizeof(bool) + sizeof(std::size_t);
                bool                     shouldUpdateZones = ref<bool>(data, 2);
                const std::size_t        size              = ref<std::size_t>(data, 3);
                std::vector<influence_t> influencePoints   = std::vector<influence_t>(size);
                for (std::size_t i = 0; i < size; i++)
                {
                    const std::size_t start = headerLength + i * sizeof(influence_t);

                    influence_t influence{};
                    influence.sandoria_influence = ref<uint16>(data, start);
                    influence.bastok_influence   = ref<uint16>(data, start + 2);
                    influence.windurst_influence = ref<uint16>(data, start + 4);
                    influence.beastmen_influence = ref<uint16>(data, start + 6);

                    influencePoints[i] = influence;
                }

                HandleInfluenceUpdate(influencePoints, shouldUpdateZones);
                break;
            }
            case CONQUEST_WORLD2MAP_REGION_CONTROL:
            {
                const std::size_t headerLength = 2 * sizeof(uint8) + sizeof(std::size_t);
                const std::size_t size         = ref<std::size_t>(data, 2);

                std::vector<region_control_t> regionControls;
                for (std::size_t i = 0; i < size; i++)
                {
                    const std::size_t start = headerLength + i * sizeof(region_control_t);

                    region_control_t regionControl{};
                    regionControl.current = ref<uint8_t>(data, start);
                    regionControl.prev    = ref<uint8_t>(data, start + 1);
                    regionControls.emplace_back(regionControl);
                }

                GetConquestData()->updateRegionControls(regionControls);
                break;
            }
        }
    }

    void AddInfluencePoints(int points, unsigned int nation, REGION_TYPE region)
    {
        // Send update message to world server
        // Note that we do not update local cache, as it would potentially become out of sync from
        // world server due to other map updates anyway. We wait for eventual consistency.
        const std::size_t headerLength = 2 * sizeof(uint8);
        const std::size_t dataLength   = headerLength + sizeof(int32) + sizeof(uint32) + sizeof(uint8);
        uint8             data[dataLength]{};

        // Regional event type + conquest msg type
        ref<uint8>((uint8*)data, 0) = REGIONAL_EVT_MSG_CONQUEST;
        ref<uint8>((uint8*)data, 1) = CONQUEST_MAP2WORLD_ADD_INFLUENCE_POINTS;

        // Payload
        ref<int32>(data, 2)  = points;
        ref<uint32>(data, 6) = nation;
        ref<uint8>(data, 10) = (uint8)region;

        // Do send the message
        message::send(MSG_MAP2WORLD_REGIONAL_EVENT, data, dataLength);
    }

    /************************************************************************
     *    GainInfluencePoints                                                *
     *    +1 point for nation                                               *
     *                                                                      *
     ************************************************************************/

    void GainInfluencePoints(CCharEntity* PChar, uint32 points)
    {
        points += (uint32)(PChar->getMod(Mod::CONQUEST_REGION_BONUS) / 100.0);
        conquest::AddInfluencePoints(points, PChar->profile.nation, PChar->loc.zone->GetRegionID());
    }

    /************************************************************************
     *    LoseInfluencePoints                                                *
     *    -x point for nation                                               *
     *    +x point for beastmen                                              *
     ************************************************************************/

    void LoseInfluencePoints(CCharEntity* PChar)
    {
        // http://wiki.ffo.jp/html/498.html
        if (PChar->GetMLevel() < settings::get<uint8>("map.MINIMUM_LEVEL_CONQUEST_INFUENCE_LOSS"))
        {
            return;
        }

        REGION_TYPE region = PChar->loc.zone->GetRegionID();
        int         points = 0;

        switch (region)
        {
            case REGION_TYPE::RONFAURE:
            case REGION_TYPE::GUSTABERG:
            case REGION_TYPE::SARUTABARUTA:
            {
                points = 10;
                break;
            }
            case REGION_TYPE::ZULKHEIM:
            case REGION_TYPE::KOLSHUSHU:
            case REGION_TYPE::NORVALLEN:
            case REGION_TYPE::DERFLAND:
            case REGION_TYPE::ARAGONEU:
            {
                points = 50;
                break;
            }
            case REGION_TYPE::QUFIMISLAND:
            case REGION_TYPE::LITELOR:
            case REGION_TYPE::KUZOTZ:
            case REGION_TYPE::ELSHIMOLOWLANDS:
            {
                points = 75;
                break;
            }
            case REGION_TYPE::VOLLBOW:
            case REGION_TYPE::VALDEAUNIA:
            case REGION_TYPE::FAUREGANDI:
            case REGION_TYPE::ELSHIMOUPLANDS:
            {
                points = 300;
                break;
            }
            case REGION_TYPE::TULIA:
            case REGION_TYPE::MOVALPOLOS:
            case REGION_TYPE::TAVNAZIA:
            {
                points = 600;
                break;
            }
            default:
            {
                break;
            }
        }

        conquest::AddInfluencePoints(points, NATION_BEASTMEN, region);
    }

    /************************************************************************
     *                                                                       *
     *  GetInfluenceGraphics                                                *
     *                                                                      *
     ************************************************************************/

    uint8 GetInfluenceGraphics(int32 san_inf, int32 bas_inf, int32 win_inf, int32 bst_inf)
    {
        // if all nations and beastmen == 0
        if (san_inf == 0 && bas_inf == 0 && win_inf == 0 && bst_inf == 0)
        {
            return 0;
        }
        // if all nations and beastmen, has same number
        else if (san_inf == bas_inf && san_inf == win_inf && san_inf == bst_inf)
        {
            return 0;
        }
        // if Beast influence > all nations
        else if (bst_inf > san_inf && bst_inf > win_inf && bst_inf > bas_inf)
        {
            return 64;
        }
        else
        {
            uint8 offset = 0;
            int64 total  = san_inf + bas_inf + win_inf;

            // Sandoria
            if (san_inf >= total * 0.65)
            {
                offset = 3;
            }
            else if (san_inf >= total * 0.5)
            {
                offset = 2;
            }
            else if (san_inf >= total * 0.25)
            {
                offset = 1;
            }
            else
            {
                offset = 0;
            }

            // Bastok
            if (bas_inf >= total * 0.65)
            {
                offset += 12;
            }
            else if (bas_inf >= total * 0.5)
            {
                offset += 8;
            }
            else if (bas_inf >= total * 0.25)
            {
                offset += 4;
            }
            else
            {
                offset += 0;
            }

            // Windurst
            if (win_inf >= total * 0.65)
            {
                offset += 48;
            }
            else if (win_inf >= total * 0.5)
            {
                offset += 32;
            }
            else if (win_inf >= total * 0.25)
            {
                offset += 16;
            }
            else
            {
                offset += 0;
            }

            return offset;
        }
    }

    uint8 GetInfluenceGraphics(REGION_TYPE region)
    {
        int32 sandoria = GetConquestData()->getInfluence(region, NATION_SANDORIA);
        int32 bastok   = GetConquestData()->getInfluence(region, NATION_BASTOK);
        int32 windurst = GetConquestData()->getInfluence(region, NATION_WINDURST);
        int32 beastmen = GetConquestData()->getInfluence(region, NATION_BEASTMEN);

        return GetInfluenceGraphics(sandoria, bastok, windurst, beastmen);
    }

    // TODO: figure out what the beastmen-less numbers are for
    uint8 GetInfluenceRanking(int32 san_inf, int32 bas_inf, int32 win_inf, int32 bst_inf)
    {
        uint8 ranking = 63;
        if (san_inf >= bas_inf)
        {
            ranking -= 1;
        }

        if (san_inf >= win_inf)
        {
            ranking -= 1;
        }

        if (bas_inf >= san_inf)
        {
            ranking -= 4;
        }

        if (bas_inf >= win_inf)
        {
            ranking -= 4;
        }

        if (win_inf >= san_inf)
        {
            ranking -= 16;
        }

        if (win_inf >= bas_inf)
        {
            ranking -= 16;
        }

        return ranking;
    }

    uint8 GetInfluenceRanking(int32 san_inf, int32 bas_inf, int32 win_inf)
    {
        return GetInfluenceRanking(san_inf, bas_inf, win_inf, 0);
    }

    /************************************************************************
     *   UpdateConquestGM                                                    *
     *  Update region control                                               *
     *   just used by GM command                                                *
     ************************************************************************/

    void UpdateConquestGM(ConquestUpdate type)
    {
        if (type == Conquest_Tally_Start)
        {
            // Notify world server that we want to force a weekly update
            const std::size_t dataLen = 2 * sizeof(uint8);
            uint8             data[dataLen]{};

            // Create ZMQ message with header and no other payload
            ref<uint8>((uint8*)data, 0) = REGIONAL_EVT_MSG_CONQUEST;
            ref<uint8>((uint8*)data, 1) = CONQUEST_MAP2WORLD_GM_WEEKLY_UPDATE;

            // Send to world
            message::send(MSG_MAP2WORLD_REGIONAL_EVENT, data, dataLen);
        }
        else if (type == Conquest_Update)
        {
            // Fetch most recent data from world server
            const std::size_t dataLen = 2 * sizeof(uint8);
            uint8             data[dataLen]{};

            // Create ZMQ message with header and no payload
            ref<uint8>((uint8*)data, 0) = REGIONAL_EVT_MSG_CONQUEST;
            ref<uint8>((uint8*)data, 1) = CONQUEST_MAP2WORLD_GM_CONQUEST_UPDATE;

            // Send to world
            message::send(MSG_MAP2WORLD_REGIONAL_EVENT, data, dataLen);
        }
        else if (type == Conquest_Tally_End)
        {
            // Call conquest callbacks with cached data
            conquest::HandleWeeklyTallyEnd(GetConquestData()->getRegionControls());
        }
    }

    /************************************************************************
     *   HandleWeekConquestUpdateStart                                      *
     *   Calls map handlers for when conquest update starts                 *
     *   called 1 time per week                                             *
     *   This does NOT update the DB. World server is responsible for that. *
     ************************************************************************/

    void HandleWeeklyTallyStart()
    {
        TracyZoneScoped;

        uint8 ranking            = conquest::GetBalance();
        bool  isConquestAlliance = conquest::IsAlliance();
        // clang-format off
        zoneutils::ForEachZone([ranking, isConquestAlliance](CZone* PZone)
        {
            // only find chars for zones that have had conquest updated
            REGION_TYPE regionId = PZone->GetRegionID();
            if (regionId <= REGION_TYPE::DYNAMIS)
            {
                // Cities do not have owner or influence
                uint8 influence = 0;
                uint8 owner = 0;
                if (regionId <= REGION_TYPE::TAVNAZIA) {
                    influence = conquest::GetInfluenceGraphics(PZone->GetRegionID());
                    owner     = conquest::GetRegionOwner(PZone->GetRegionID());
                }

                luautils::OnConquestUpdate(PZone, Conquest_Tally_Start, influence, owner, ranking, isConquestAlliance);
            }
        });
        // clang-format on
    }

    /************************************************************************
     *   HandleWeekConquestUpdateEnd                                        *
     *   Calls map handlers for when conquest update ends                   *
     *   Called in response to world msg after actual db is updated         *
     *   This does NOT update the DB. World server is responsible for that. *
     ************************************************************************/
    void HandleWeeklyTallyEnd(std::vector<region_control_t> const& regionControls)
    {
        TracyZoneScoped;

        // 1-  Update local cache
        GetConquestData()->updateRegionControls(regionControls);

        // 2- Update zones based on the new data
        // update conquest overseers
        for (uint8 i = 0; i <= 18; i++)
        {
            luautils::SetRegionalConquestOverseers(i);
        }

        uint8 ranking            = conquest::GetBalance();
        bool  isConquestAlliance = conquest::IsAlliance();

        // clang-format off
        zoneutils::ForEachZone([ranking, isConquestAlliance](CZone* PZone)
        {
            REGION_TYPE regionId = PZone->GetRegionID();
            if (regionId <= REGION_TYPE::DYNAMIS)
            {
                // Cities do not have owner or influence
                uint8 influence = 0;
                uint8 owner = 0;
                if (regionId <= REGION_TYPE::TAVNAZIA) {
                    influence = conquest::GetInfluenceGraphics(PZone->GetRegionID());
                    owner     = conquest::GetRegionOwner(PZone->GetRegionID());
                }

                luautils::OnConquestUpdate(PZone, Conquest_Tally_End, influence, owner, ranking, isConquestAlliance);
                PZone->ForEachChar([](CCharEntity* PChar)
                {
                    PChar->pushPacket(new CConquestPacket(PChar));
                    PChar->PLatentEffectContainer->CheckLatentsZone();
                });
            }
        });
        // clang-format on

        ShowDebug("Conquest Weekly Update is finished");
    }

    /************************************************************************
     *                                                                       *
     *  HandleInfluenceUpdate                                                *
     *  Called when influence updates are received from the world server.    *
     *                                                                       *
     ************************************************************************/

    void HandleInfluenceUpdate(std::vector<influence_t> const& influences, bool shouldUpdateZones)
    {
        TracyZoneScoped;

        GetConquestData()->updateInfluencePoints(influences);

        if (shouldUpdateZones)
        {
            uint8 ranking            = conquest::GetBalance();
            bool  isConquestAlliance = conquest::IsAlliance();

            // clang-format off
            zoneutils::ForEachZone([ranking, isConquestAlliance](CZone* PZone)
            {
                // only find chars for zones that have had conquest updated
                REGION_TYPE regionId = PZone->GetRegionID();
                if (regionId <= REGION_TYPE::DYNAMIS)
                {
                    // Cities do not have owner or influence
                    uint8 influence = 0;
                    uint8 owner = 0;
                    if (regionId <= REGION_TYPE::TAVNAZIA) {
                        influence = conquest::GetInfluenceGraphics(PZone->GetRegionID());
                        owner     = conquest::GetRegionOwner(PZone->GetRegionID());
                    }

                    luautils::OnConquestUpdate(PZone, Conquest_Update, influence, owner, ranking, isConquestAlliance);
                    PZone->ForEachChar([](CCharEntity* PChar)
                    {
                        PChar->PLatentEffectContainer->CheckLatentsZone();
                    });
                }
            });
            // clang-format on
        }
    }

    /************************************************************************
     *                                                                       *
     *  GetBalance                                                          *
     *   Ranking for the 3 nations                                           *
     ************************************************************************/

    uint8 GetBalance(uint8 sandoria, uint8 bastok, uint8 windurst, uint8 sandoria_prev, uint8 bastok_prev, uint8 windurst_prev)
    {
        // Based on the below values, it seems to be in pairs of bits.
        // Order is Windurst, Bastok, San d'Oria
        // 01 for first place, 10 for second, 11 for third.
        // 45 = 0b101101 = Windurst in second, Bastok in third, San d'Oria in first
        // 30 = 0b011110 = Windurst in first, Bastok in third, San d'Oria in second

        uint8 ranking = 63;
        if (sandoria >= bastok)
        {
            ranking -= 1;
        }

        if (sandoria >= windurst)
        {
            ranking -= 1;
        }

        if (bastok >= sandoria)
        {
            ranking -= 4;
        }

        if (bastok >= windurst)
        {
            ranking -= 4;
        }

        if (windurst >= sandoria)
        {
            ranking -= 16;
        }

        if (windurst >= bastok)
        {
            ranking -= 16;
        }

        if (GetAlliance(sandoria_prev, bastok_prev, windurst_prev) != 0)
        {
            // there was an alliance last conquest week, so the allied nations will be tied for first (unless they didn't pass the other nation)
            if (sandoria_prev > bastok_prev && sandoria_prev > windurst_prev && (ranking & 0x03) != 0x01)
            {
                ranking = 0x17;
            }
            else if (bastok_prev > sandoria_prev && bastok_prev > windurst_prev && (ranking & 0x0C) != 0x04)
            {
                ranking = 0x1D;
            }
            else if (windurst_prev > bastok_prev && windurst_prev > sandoria_prev && (ranking & 0x30) != 0x10)
            {
                ranking = 0x35;
            }
        }

        return ranking;
    }

    uint8 GetBalance()
    {
        uint8 sandoria = GetConquestData()->getRegionControlCount(NATION_SANDORIA);
        uint8 bastok   = GetConquestData()->getRegionControlCount(NATION_BASTOK);
        uint8 windurst = GetConquestData()->getRegionControlCount(NATION_WINDURST);

        uint8 sandoria_prev = GetConquestData()->getPrevRegionControlCount(NATION_SANDORIA);
        uint8 bastok_prev   = GetConquestData()->getPrevRegionControlCount(NATION_BASTOK);
        uint8 windurst_prev = GetConquestData()->getPrevRegionControlCount(NATION_WINDURST);

        return GetBalance(sandoria, bastok, windurst, sandoria_prev, bastok_prev, windurst_prev);
    }

    uint8 GetAlliance(uint8 sandoria, uint8 bastok, uint8 windurst)
    {
        if (((sandoria > (bastok + windurst) && sandoria > bastok && sandoria > windurst) && sandoria > 9) ||
            ((bastok > (sandoria + windurst) && bastok > sandoria && bastok > windurst) && bastok > 9) ||
            ((windurst > (sandoria + bastok) && windurst > bastok && windurst > sandoria) && windurst > 9))
        {
            return 1;
        }
        return 0;
    }

    uint8 GetAlliance(uint8 sandoria, uint8 bastok, uint8 windurst, uint8 sandoria_prev, uint8 bastok_prev, uint8 windurst_prev)
    {
        if (sandoria > (bastok + windurst) && sandoria > bastok && sandoria > windurst)
        {
            uint8 ranking = GetBalance(sandoria, bastok, windurst, sandoria_prev, bastok_prev, windurst_prev);
            if ((ranking & 0x03) == 0x01)
            {
                return 1;
            }
        }
        else if (bastok > (sandoria + windurst) && bastok > sandoria && bastok > windurst)
        {
            uint8 ranking = GetBalance(sandoria, bastok, windurst, sandoria_prev, bastok_prev, windurst_prev);
            if ((ranking & 0x0C) == 0x04)
            {
                return 1;
            }
        }
        else if (windurst > (sandoria + bastok) && windurst > bastok && windurst > sandoria)
        {
            uint8 ranking = GetBalance(sandoria, bastok, windurst, sandoria_prev, bastok_prev, windurst_prev);
            if ((ranking & 0x30) == 0x10)
            {
                return 1;
            }
        }
        return 0;
    }

    bool IsAlliance()
    {
        uint8 sandoria = GetConquestData()->getRegionControlCount(NATION_SANDORIA);
        uint8 bastok   = GetConquestData()->getRegionControlCount(NATION_BASTOK);
        uint8 windurst = GetConquestData()->getRegionControlCount(NATION_WINDURST);

        uint8 sandoria_prev = GetConquestData()->getPrevRegionControlCount(NATION_SANDORIA);
        uint8 bastok_prev   = GetConquestData()->getPrevRegionControlCount(NATION_BASTOK);
        uint8 windurst_prev = GetConquestData()->getPrevRegionControlCount(NATION_WINDURST);

        return GetAlliance(sandoria, bastok, windurst, sandoria_prev, bastok_prev, windurst_prev) == 1;
    }

    /************************************************************************
     *                                                                       *
     *  Gets the number of Vanadiel days left for tally                      *
     *                                                                       *
     ************************************************************************/

    uint8 GetNexTally()
    {
        auto  weekday    = CVanaTime::getInstance()->getSysWeekDay();
        uint8 dayspassed = (weekday == 0 ? 6 : weekday - 1) * 25;
        dayspassed += ((CVanaTime::getInstance()->getSysHour() * 60 + CVanaTime::getInstance()->getSysMinute()) * 25) / 1440;
        return (uint8)(175 - dayspassed);
    }

    /************************************************************************
     *                                                                       *
     *  Get the nation that owns the given ration                            *
     *                                                                       *
     ************************************************************************/

    uint8 GetRegionOwner(REGION_TYPE region)
    {
        return GetConquestData()->getRegionOwner(region);
    }

    /************************************************************************
     *                                                                       *
     *  Adds conquest points to the character based on the exp gained.       *
     *  Sends an update to world server with the influence change.           *
     *                                                                       *
     ************************************************************************/

    // TODO: Take into account the added points for the weekly tally
    // NOTE: This todo was an old comment. Unsure if it's still valid
    uint32 AddConquestPoints(CCharEntity* PChar, uint32 exp)
    {
        // NOTE: No need to send CConquestPacket,
        // The client itself requests this packet after a fixed period of time

        REGION_TYPE region = PChar->loc.zone->GetRegionID();

        if (region != REGION_TYPE::UNKNOWN)
        {
            // 10% if region control is player's nation
            // 15% otherwise

            double percentage = PChar->profile.nation == GetRegionOwner(region) ? 0.1 : 0.15;
            percentage += PChar->getMod(Mod::CONQUEST_BONUS) / 100.0;
            uint32 points = (uint32)(exp * percentage);

            charutils::AddPoints(PChar, charutils::GetConquestPointsName(PChar).c_str(), points);
            GainInfluencePoints(PChar, points / 2);
        }
        return 0; // added conquest points
    }

    // GetConquestInfluence(region,nation)
    // AddConquestInfluence(region,nation)
    // ResetConquestInfluence()
    // UpdateConquestInfluence()

    // gain/loss influence
    // Dying in the Outlands decrease your Allegiance influence and increase the influence of the Beastmen hordes instead.
    // Gain: XP/CP, Garrison quests, Expeditionary Forces, trade items to Outpost Vendors (influence only)

    // Region control
    // 0: sandoria
    // 1: bastok
    // 2: windurst
    // 3: beastmen
}; // namespace conquest
