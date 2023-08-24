-----------------------------------
-- The Shadow Awaits
-- Windurst M5-2
-----------------------------------
-- !addmission 2 15
-- Rakoh Buuma      : !pos 106 -5 -23 241
-- Mokyokyo         : !pos -55 -8 227 238
-- Janshura-Rashura : !pos -227 -8 184 240
-- Zokima-Rokima    : !pos 0 -16 124 239
-- Vestal Chamber   : !pos 0.1 -49 37 242
-- Zubaba           : !pos 15 -27 18 242
-- Thone Room Door  : !pos -111 -6 0 165
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_SHADOW_AWAITS)

mission.reward =
{
    gil = 20000,
    rank = 6,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 15 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
        npcUtil.giveKeyItem(player, xi.ki.STAR_CRESTED_SUMMONS_1)
    end
end

mission.sections =
{
    -- Player has no active missions
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId
        end,

        [xi.zone.PORT_WINDURST] =
        {
            onEventFinish =
            {
                [78] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            onEventFinish =
            {
                [93] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            onEventFinish =
            {
                [111] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            onEventFinish =
            {
                [114] = handleAcceptMission,
            },
        },
    },

    -- Player has accepted the mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.HEAVENS_TOWER] =
        {
            ['_6q2'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.STAR_CRESTED_SUMMONS_1) then
                        return mission:progressEvent(214)
                    elseif player:hasKeyItem(xi.ki.SHADOW_FRAGMENT) then
                        return mission:progressEvent(216)
                    end
                end,
            },

            ['Zubaba'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.STAR_CRESTED_SUMMONS_1) then
                        return mission:progressEvent(157)
                    elseif player:hasKeyItem(xi.ki.SHADOW_FRAGMENT) then
                        return mission:progressEvent(194)
                    end
                end,
            },

            onEventFinish =
            {
                [214] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                    player:addTitle(xi.title.STAR_ORDAINED_WARRIOR)
                    player:delKeyItem(xi.ki.STAR_CRESTED_SUMMONS_1)
                end,

                [216] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.SHADOW_FRAGMENT)
                    end
                end,
            },
        },

        [xi.zone.THRONE_ROOM] =
        {
            ['_4l1'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return mission:progressEvent(6)
                    end
                end
            },

            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 3 and
                        player:getLocalVar('battlefieldWin') == 160
                    then
                        if
                            player:getCurrentMission(xi.mission.log_id.ZILART) ~= xi.mission.id.zilart.THE_NEW_FRONTIER and
                            not player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_NEW_FRONTIER)
                        then
                            -- Don't add missions we already completed. Players who change nation will hit this.
                            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_NEW_FRONTIER)
                        end

                        return mission:progressEvent(7)
                    end
                end,

                [6] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                end,

                [7] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                    player:setPos(378, -12, -20, 125, 161)
                end,
            },
        },

        [xi.zone.CASTLE_ZVAHL_BAILEYS] =
        {
            afterZoneIn =
            {
                function(player)
                    if
                        player:getMissionStatus(mission.areaId) == 4 and
                        not player:hasKeyItem(xi.ki.SHADOW_FRAGMENT)
                    then
                        npcUtil.giveKeyItem(player, xi.ki.SHADOW_FRAGMENT)
                    end
                end,
            },
        },
    },
}

return mission
