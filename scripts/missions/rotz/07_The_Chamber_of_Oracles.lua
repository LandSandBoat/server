-----------------------------------
-- The Chamber of Oracles
-- Zilart M7
-----------------------------------
-- !addmission 3 14
-- !pos 200.3419 -2.25 37.12 168
-----------------------------------
require('scripts/globals/interaction/mission')
require("scripts/globals/keyitems")
require('scripts/globals/missions')
require("scripts/globals/titles")
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/Chamber_of_Oracles/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CHAMBER_OF_ORACLES)

mission.reward =
{
    keyItem = xi.ki.PRISMATIC_FRAGMENT,
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER },
    title = xi.title.LIGHTWEAVER,
}

local function handleActiveOnTrigger(player, keyItemId, statusIncrease)
    local missionStatus = player:getMissionStatus(xi.mission.log_id.ZILART)

    if player:hasKeyItem(keyItemId) then
        player:delKeyItem(keyItemId)
        player:setMissionStatus(xi.mission.log_id.ZILART, missionStatus + statusIncrease)
        player:messageSpecial(ID.text.YOU_PLACE_THE, keyItemId)

        if missionStatus == 255 then
            return mission:event(1)
        end
    elseif missionStatus == 255 then -- Execute cutscene if the player is interrupted.
        return mission:event(1)
    else
        return mission:messageSpecial(ID.text.IS_SET_IN_THE_PEDESTAL, keyItemId)
    end
end

mission.sections =
{
    -- Section: Mission not Active or Completed
    {
        check = function(player, currentMission, missionStatus, vars)
            return not player:hasCompletedMission(mission.areaId, mission.missionId) and currentMission ~= mission.missionId
        end,

        [xi.zone.CHAMBER_OF_ORACLES] = {
            ['Pedestal_of_Darkness']  = mission:messageSpecial(ID.text.PLACED_INTO_THE_PEDESTAL),
            ['Pedestal_of_Earth']     = mission:messageSpecial(ID.text.PLACED_INTO_THE_PEDESTAL),
            ['Pedestal_of_Fire']      = mission:messageSpecial(ID.text.PLACED_INTO_THE_PEDESTAL),
            ['Pedestal_of_Ice']       = mission:messageSpecial(ID.text.PLACED_INTO_THE_PEDESTAL),
            ['Pedestal_of_Light']     = mission:messageSpecial(ID.text.PLACED_INTO_THE_PEDESTAL),
            ['Pedestal_of_Lightning'] = mission:messageSpecial(ID.text.PLACED_INTO_THE_PEDESTAL),
            ['Pedestal_of_Water']     = mission:messageSpecial(ID.text.PLACED_INTO_THE_PEDESTAL),
            ['Pedestal_of_Wind']      = mission:messageSpecial(ID.text.PLACED_INTO_THE_PEDESTAL),
        },
    },

    -- Section: Mission is Active
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CHAMBER_OF_ORACLES] = {
            ['Pedestal_of_Darkness'] =
            {
                onTrigger = function(player, npc)
                    return handleActiveOnTrigger(player, xi.ki.DARK_FRAGMENT, 2)
                end,
            },

            ['Pedestal_of_Earth'] =
            {
                onTrigger = function(player, npc)
                    return handleActiveOnTrigger(player, xi.ki.EARTH_FRAGMENT, 4)
                end,
            },

            ['Pedestal_of_Fire'] =
            {
                onTrigger = function(player, npc)
                    return handleActiveOnTrigger(player, xi.ki.FIRE_FRAGMENT, 1)
                end,
            },

            ['Pedestal_of_Ice'] =
            {
                onTrigger = function(player, npc)
                    return handleActiveOnTrigger(player, xi.ki.ICE_FRAGMENT, 8)
                end,
            },

            ['Pedestal_of_Light'] =
            {
                onTrigger = function(player, npc)
                    return handleActiveOnTrigger(player, xi.ki.LIGHT_FRAGMENT, 16)
                end,
            },

            ['Pedestal_of_Lightning'] =
            {
                onTrigger = function(player, npc)
                    return handleActiveOnTrigger(player, xi.ki.LIGHTNING_FRAGMENT, 32)
                end,
            },

            ['Pedestal_of_Water'] =
            {
                onTrigger = function(player, npc)
                    return handleActiveOnTrigger(player, xi.ki.WATER_FRAGMENT, 64)
                end,
            },

            ['Pedestal_of_Wind'] =
            {
                onTrigger = function(player, npc)
                    return handleActiveOnTrigger(player, xi.ki.WIND_FRAGMENT, 128)
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    mission:complete(player)
                    player:setMissionStatus(xi.mission.log_id.ZILART, 0)
                end,
            },
        },
    },

    -- Section: Mission has been Completed
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.CHAMBER_OF_ORACLES] = {
            ['Pedestal_of_Darkness']  = mission:messageSpecial(ID.text.HAS_LOST_ITS_POWER, xi.ki.DARK_FRAGMENT),
            ['Pedestal_of_Earth']     = mission:messageSpecial(ID.text.HAS_LOST_ITS_POWER, xi.ki.EARTH_FRAGMENT),
            ['Pedestal_of_Fire']      = mission:messageSpecial(ID.text.HAS_LOST_ITS_POWER, xi.ki.FIRE_FRAGMENT),
            ['Pedestal_of_Ice']       = mission:messageSpecial(ID.text.HAS_LOST_ITS_POWER, xi.ki.ICE_FRAGMENT),
            ['Pedestal_of_Light']     = mission:messageSpecial(ID.text.HAS_LOST_ITS_POWER, xi.ki.LIGHT_FRAGMENT),
            ['Pedestal_of_Lightning'] = mission:messageSpecial(ID.text.HAS_LOST_ITS_POWER, xi.ki.LIGHTNING_FRAGMENT),
            ['Pedestal_of_Water']     = mission:messageSpecial(ID.text.HAS_LOST_ITS_POWER, xi.ki.WATER_FRAGMENT),
            ['Pedestal_of_Wind']      = mission:messageSpecial(ID.text.HAS_LOST_ITS_POWER, xi.ki.WIND_FRAGMENT),
        },
    },
}

return mission
