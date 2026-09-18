-----------------------------------
-- The Chamber of Oracles
-- Zilart M7
-----------------------------------
-- !addmission 3 14
-- !pos 200.3419 -2.25 37.12 168
-----------------------------------
local oraclesID = zones[xi.zone.CHAMBER_OF_ORACLES]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CHAMBER_OF_ORACLES)

mission.reward =
{
    keyItem     = xi.keyItem.PRISMATIC_FRAGMENT,
    title       = xi.title.LIGHTWEAVER,
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER },
}

local function handleActiveOnTrigger(player, keyItemId, statusIncrease)
    local missionStatus = player:getMissionStatus(xi.mission.log_id.ZILART)

    if missionStatus == 255 then -- Execute cutscene if the player is interrupted.
        return mission:event(1)
    elseif bit.band(missionStatus, statusIncrease) == 0 then
        -- Fragments are not removed until the final cutscene ends.
        player:setMissionStatus(xi.mission.log_id.ZILART, missionStatus + statusIncrease)
        player:messageSpecial(oraclesID.text.YOU_PLACE_THE, keyItemId)

        if player:getMissionStatus(xi.mission.log_id.ZILART) == 255 then
            return mission:event(1)
        end
    else
        return mission:messageSpecial(oraclesID.text.IS_SET_IN_THE_PEDESTAL, keyItemId)
    end
end

mission.sections =
{
    -- Section: Mission not Active or Completed
    {
        check = function(player, currentMission, missionStatus, vars)
            return not player:hasCompletedMission(mission.areaId, mission.missionId) and
                currentMission ~= mission.missionId
        end,

        [xi.zone.CHAMBER_OF_ORACLES] =
        {
            ['Pedestal_of_Darkness']  = mission:messageSpecial(oraclesID.text.PLACED_INTO_THE_PEDESTAL),
            ['Pedestal_of_Earth']     = mission:messageSpecial(oraclesID.text.PLACED_INTO_THE_PEDESTAL),
            ['Pedestal_of_Fire']      = mission:messageSpecial(oraclesID.text.PLACED_INTO_THE_PEDESTAL),
            ['Pedestal_of_Ice']       = mission:messageSpecial(oraclesID.text.PLACED_INTO_THE_PEDESTAL),
            ['Pedestal_of_Light']     = mission:messageSpecial(oraclesID.text.PLACED_INTO_THE_PEDESTAL),
            ['Pedestal_of_Lightning'] = mission:messageSpecial(oraclesID.text.PLACED_INTO_THE_PEDESTAL),
            ['Pedestal_of_Water']     = mission:messageSpecial(oraclesID.text.PLACED_INTO_THE_PEDESTAL),
            ['Pedestal_of_Wind']      = mission:messageSpecial(oraclesID.text.PLACED_INTO_THE_PEDESTAL),
        },
    },

    -- Section: Mission is Active
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CHAMBER_OF_ORACLES] =
        {
            ['Pedestal_of_Darkness'] =
            {
                onTrigger = function(player, npc)
                    return handleActiveOnTrigger(player, xi.keyItem.DARK_FRAGMENT, 2)
                end,
            },

            ['Pedestal_of_Earth'] =
            {
                onTrigger = function(player, npc)
                    return handleActiveOnTrigger(player, xi.keyItem.EARTH_FRAGMENT, 4)
                end,
            },

            ['Pedestal_of_Fire'] =
            {
                onTrigger = function(player, npc)
                    return handleActiveOnTrigger(player, xi.keyItem.FIRE_FRAGMENT, 1)
                end,
            },

            ['Pedestal_of_Ice'] =
            {
                onTrigger = function(player, npc)
                    return handleActiveOnTrigger(player, xi.keyItem.ICE_FRAGMENT, 8)
                end,
            },

            ['Pedestal_of_Light'] =
            {
                onTrigger = function(player, npc)
                    return handleActiveOnTrigger(player, xi.keyItem.LIGHT_FRAGMENT, 16)
                end,
            },

            ['Pedestal_of_Lightning'] =
            {
                onTrigger = function(player, npc)
                    return handleActiveOnTrigger(player, xi.keyItem.LIGHTNING_FRAGMENT, 32)
                end,
            },

            ['Pedestal_of_Water'] =
            {
                onTrigger = function(player, npc)
                    return handleActiveOnTrigger(player, xi.keyItem.WATER_FRAGMENT, 64)
                end,
            },

            ['Pedestal_of_Wind'] =
            {
                onTrigger = function(player, npc)
                    return handleActiveOnTrigger(player, xi.keyItem.WIND_FRAGMENT, 128)
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    for fragment = xi.keyItem.FIRE_FRAGMENT, xi.keyItem.DARK_FRAGMENT do
                        player:delKeyItem(fragment)
                    end

                    mission:complete(player)
                end,
            },
        },
    },

    -- Section: Mission has been Completed
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.CHAMBER_OF_ORACLES] =
        {
            ['Pedestal_of_Darkness']  = mission:messageSpecial(oraclesID.text.HAS_LOST_ITS_POWER, xi.keyItem.DARK_FRAGMENT),
            ['Pedestal_of_Earth']     = mission:messageSpecial(oraclesID.text.HAS_LOST_ITS_POWER, xi.keyItem.EARTH_FRAGMENT),
            ['Pedestal_of_Fire']      = mission:messageSpecial(oraclesID.text.HAS_LOST_ITS_POWER, xi.keyItem.FIRE_FRAGMENT),
            ['Pedestal_of_Ice']       = mission:messageSpecial(oraclesID.text.HAS_LOST_ITS_POWER, xi.keyItem.ICE_FRAGMENT),
            ['Pedestal_of_Light']     = mission:messageSpecial(oraclesID.text.HAS_LOST_ITS_POWER, xi.keyItem.LIGHT_FRAGMENT),
            ['Pedestal_of_Lightning'] = mission:messageSpecial(oraclesID.text.HAS_LOST_ITS_POWER, xi.keyItem.LIGHTNING_FRAGMENT),
            ['Pedestal_of_Water']     = mission:messageSpecial(oraclesID.text.HAS_LOST_ITS_POWER, xi.keyItem.WATER_FRAGMENT),
            ['Pedestal_of_Wind']      = mission:messageSpecial(oraclesID.text.HAS_LOST_ITS_POWER, xi.keyItem.WIND_FRAGMENT),
        },
    },
}

return mission
