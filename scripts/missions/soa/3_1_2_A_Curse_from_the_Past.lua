-----------------------------------
-- A Curse from the Past
-- Seekers of Adoulin M3-1-2
-----------------------------------
-- !addmission 12 39
-- Rigobertine    : !pos 68.022 -40.150 10.703 257
-- Fontis_Xanira  : !pos 17.350 1 -21.248 256
-- Sunrise_Beacon : !pos 115.167 32 177.887 256
-- Erminold       : !pos 50.949 -40 -90.942 257
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.A_CURSE_FROM_THE_PAST)

mission.reward =
{
    keyItem     = xi.ki.WEATHER_VANE_WINGS,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_PURGATION },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Behsa_Alehgo'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ETERNAL_FLAME) then
                        return mission:event(1523):importantEvent()
                    end
                end,
            },

            ['Erminold'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return mission:progressEvent(1525)
                    end
                end,
            },

            ['Ploh_Trishbahk'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) < 2 then
                        if mission:getVar(player, 'Option') == 0 then
                            return mission:progressEvent(1519)
                        else
                            return mission:event(1520):oncePerZone()
                        end
                    else
                        return mission:event(1524):importantEvent()
                    end
                end,
            },

            ['Rigobertine'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.ETERNAL_FLAME) then
                        return mission:progressEvent(1521)
                    else
                        return mission:event(1522):oncePerZone()
                    end
                end,
            },

            onEventFinish =
            {
                [1519] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 1)
                end,

                [1521] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.ETERNAL_FLAME)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [1525] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Fontis_Xanira'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.VIAL_OF_UNTAINTED_HOLY_WATER) and
                        player:getMissionStatus(mission.areaId) == 1
                    then
                        if player:hasKeyItem(xi.ki.PIECE_OF_A_STONE_WALL) then
                            player:setMissionStatus(mission.areaId, 2)
                        end

                        return mission:keyItem(xi.ki.VIAL_OF_UNTAINTED_HOLY_WATER)
                    end
                end,
            },

            ['Sunrise_Beacon'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.PIECE_OF_A_STONE_WALL) and
                        player:getMissionStatus(mission.areaId) == 1
                    then
                        if player:hasKeyItem(xi.ki.VIAL_OF_UNTAINTED_HOLY_WATER) then
                            player:setMissionStatus(mission.areaId, 2)
                        end

                        return mission:keyItem(xi.ki.PIECE_OF_A_STONE_WALL)
                    end
                end,
            },

            ['Levil'] = mission:event(138),
        },
    },
}

return mission
