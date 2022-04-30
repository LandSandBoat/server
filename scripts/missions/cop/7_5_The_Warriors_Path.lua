-----------------------------------
-- The Warrior's Path
-- Promathia 7-5
-----------------------------------
-- !addmission 6 748
-- Iron Gate : !pos 612 132 774 32
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/titles')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------
local altaieuID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH)

mission.reward =
{
    title = xi.title.SEEKER_OF_THE_LIGHT,
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.GARDEN_OF_ANTIQUITY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.SEALIONS_DEN] =
        {
            ['_0w0'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(32)
                    end
                end,
            },

            ['Sueleen'] = mission:event(28),

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 2 then
                        return 34
                    end
                end,
            },

            onEventUpdate =
            {
                [32] = function(player, csid, option, npc)
                    if option == 0 then
                        player:updateEvent(32, 0, 0, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [32] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,

                [34] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 3)
                    player:setPos(-422.100, 0, -532.092, 220, xi.zone.ALTAIEU)
                end,

                [32001] = function(player, csid, option, npc)
                    if
                        mission:getVar(player, 'Status') == 1 and
                        player:getLocalVar('battlefieldWin') == 993
                    then
                        mission:setVar(player, 'Status', 2)
                        player:setPos(612.057, 132.664, 776.920, 188, xi.zone.SEALIONS_DEN)
                    end
                end,
            },
        },

        [xi.zone.ALTAIEU] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 3 then
                        return 1 -- Event Options 1 and 2 come for update requests, no observed responses
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    -- Nag'molada steals one random light
                    local copCragLights =
                    {
                        xi.ki.LIGHT_OF_HOLLA,
                        xi.ki.LIGHT_OF_DEM,
                        xi.ki.LIGHT_OF_MEA,
                    }

                    local stolenLight = math.random(#copCragLights)

                    player:delKeyItem(xi.ki.MYSTERIOUS_AMULET_DRAINED)
                    player:delKeyItem(copCragLights[stolenLight])

                    player:messageSpecial(altaieuID.text.AMULET_SHATTERED, xi.ki.MYSTERIOUS_AMULET)
                    player:messageSpecial(altaieuID.text.LIGHT_STOLEN, copCragLights[stolenLight])
                    npcUtil.giveKeyItem(player, xi.ki.LIGHT_OF_ALTAIEU)

                    mission:complete(player)
                    mission:setVar(player, 'Option', 1)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId) and
                mission:getVar(player, 'Option') == 1
        end,

        [xi.zone.SEALIONS_DEN] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 18
                end,
            },

            onEventFinish =
            {
                [18] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 0)
                end,
            },
        },
    },
}

return mission
