-----------------------------------
-- Darkness Rising
-- Bastok M5-1
-----------------------------------
-- No active missions, Rank 4, !addkeyitem 70
-- Argus   : !pos 132.157 7.496 -2.187 236
-- Cleades : !pos -358 -10 -168 235
-- Malduc  : !pos 66.200 -14.999 4.426 237
-- Rashid  : !pos -8.444 -2 -123.575 234
-- Naji    : !pos 64 -14 -4 237
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.DARKNESS_RISING)

mission.reward =
{
    rankPoints = 600,
}

-- The message KI is removed here to still preserve this mission should a player decline and
-- then choose to change nations.  By retaining it until this point, we'll still have a point
-- of reference to return to should missionStatus be reset.
--
-- NOTE: This function is only called if a player has declined the mission previously.  Should
-- This option be selected, they will still have to speak to Naji afterwards.
local handleAcceptMission = function(player, csid, option, npc)
    if option == 14 then
        mission:begin(player)
        player:setMissionStatus(mission.areaId, 9)
        player:delKeyItem(xi.ki.MESSAGE_TO_JEUNO_BASTOK)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

mission.sections =
{
    -- Player meets requirements, but has not started the mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId and
                player:getRank(player:getNation()) == 5 and
                not player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Cleades'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(1007)
                    end
                end,
            },

            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Rashid'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(1007)
                    end
                end,
            },

            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Malduc'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(1007)
                    end
                end,
            },

            ['Naji'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(720)
                    end
                end,
            },

            onEventFinish =
            {
                [720] = function(player, csid, option, npc)
                    if option == 0 then
                        mission:begin(player)
                        player:delKeyItem(xi.ki.MESSAGE_TO_JEUNO_BASTOK)
                        npcUtil.giveKeyItem(player, xi.ki.NEW_FEIYIN_SEAL)
                        player:setMissionStatus(mission.areaId, 10)
                    else
                        player:setMissionStatus(mission.areaId, 8)
                    end
                end,

                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(1007)
                    end
                end,
            },

            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },
    },

    -- Mission has been accepted
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.METALWORKS] =
        {
            ['Naji'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 9 then
                        return mission:progressEvent(721)
                    elseif
                        player:getMissionStatus(mission.areaId) == 12 and
                        player:hasKeyItem(xi.ki.BURNT_SEAL)
                    then
                        return mission:progressEvent(722)
                    end
                end,
            },

            onEventFinish =
            {
                [721]  = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.NEW_FEIYIN_SEAL)
                    player:setMissionStatus(mission.areaId, 10)
                end,

                [722] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.BURNT_SEAL)
                    end
                end,
            },
        },

        [xi.zone.FEIYIN] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 10 then
                        return 1
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 11)
                end,
            },
        },

        [xi.zone.QUBIA_ARENA] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 11 and
                        player:getLocalVar('battlefieldWin') == xi.battlefield.id.RANK_5_MISSION
                    then
                        npcUtil.giveKeyItem(player, xi.ki.BURNT_SEAL)
                        player:setMissionStatus(mission.areaId, 12)
                        player:delKeyItem(xi.ki.NEW_FEIYIN_SEAL)
                    end
                end,
            },
        },
    },
}

return mission
