-----------------------------------
-- The Queen of the Dance
-- Wings of the Goddess Mission 4
-----------------------------------
-- !addmission 5 3
-- Lion Springs Door : !pos 96 0 106 80
-- Turlough          : !pos -58.697 0.000 103.553 244
-----------------------------------
require('scripts/missions/wotg/helpers')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.THE_QUEEN_OF_THE_DANCE)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.WHILE_THE_CAT_IS_AWAY },
}

mission.sections =
{
    -- 0: Try to enter without a ticket
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0 and
                xi.wotg.helpers.meetsMission4Reqs(player)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Lion_Springs'] = mission:progressEvent(68, 80, 4224267, 1756, utils.MAX_UINT32 - 1540096, utils.MAX_UINT32 - 1239549952, 427798150, 3, 4095),

            onEventFinish =
            {
                [68] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },
    },

    -- 1: Go to the future to get a ticket
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Lion_Springs'] = mission:event(69),
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Turlough'] = mission:progressEvent(10172),

            onEventFinish =
            {
                [10172] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.MAYAKOV_SHOW_TICKET)
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },
    },

    -- 2+: Come back and use your ticket
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus >= 2
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Lion_Springs'] = mission:progressEvent(70, 1, 0, 2964, 0, 66453367, 8366690, 4095, 131140),

            onZoneIn = function(player, prevZone)
                local missionStatus = player:getMissionStatus(mission.areaId)

                if missionStatus == 3 then
                    return 152
                elseif missionStatus == 4 then
                    return 153
                end
            end,

            onEventUpdate =
            {
                [152] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(1, 0, 1756, 0, 66453367, 8366690, 4095, 131140)
                    end
                end,

                [153] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(1, 0, 1756, 0, 66451386, 11124900, 4095, 131140)
                    end
                end,
            },

            onEventFinish =
            {
                [70] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                    player:setPos(100.801, 1, 103.211, 31, xi.zone.SOUTHERN_SAN_DORIA_S)
                end,

                [152] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                    player:setPos(100.801, 1, 103.211, 31, xi.zone.SOUTHERN_SAN_DORIA_S)
                end,

                [153] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.MAYAKOV_SHOW_TICKET)
                    end
                end,
            },
        },
    },
}

return mission
