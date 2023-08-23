-----------------------------------
-- The Shadow Lord
-- San d'Oria M5-2
-----------------------------------
-- !addmission 0 15
-- Ambrotien            : !pos 93.419 -0.001 -57.347 230
-- Grilau               : !pos -241.987 6.999 57.887 231
-- Endracion            : !pos -110 1 -34 230
-- Halver               : !pos 2 0.1 0.1 233
-- Door: Prince Royal's : !pos -38 -3 73 233
-- Door: Great Hall     : !pos 0 -1 13 233
-----------------------------------
local chateauID = zones[xi.zone.CHATEAU_DORAGUILLE]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_SHADOW_LORD)

mission.reward =
{
    gil  = 20000,
    rank = 6,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 15 then
        mission:begin(player)
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

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            onEventFinish =
            {
                [1009] = handleAcceptMission,
                [2009] = handleAcceptMission,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            onEventFinish =
            {
                [1009] = handleAcceptMission,
            },
        },
    },

    -- Player has accepted the mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(546)
                    elseif missionStatus == 1 then
                        return mission:messageText(chateauID.text.PRINCE_TRION_CHAMBERS)
                    elseif missionStatus == 2 then
                        return mission:messageText(chateauID.text.WHAT_TRION_WILL_SAY)
                    elseif
                        missionStatus == 4 and
                        player:hasKeyItem(xi.ki.SHADOW_FRAGMENT)
                    then
                        return mission:progressEvent(548)
                    end
                end,
            },

            ['_6h0'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(547)
                    end
                end,
            },

            onEventFinish =
            {
                [546] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [547] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,

                [548] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.SHADOW_FRAGMENT)
                        mission:setVar(player, 'hallEvent', 1)
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
                    npcUtil.giveKeyItem(player, xi.ki.SHADOW_FRAGMENT)
                    player:setMissionStatus(mission.areaId, 4)
                    player:setPos(378, -12, -20, 125, 161)
                end,
            },
        },
    },

    -- Optional Great Hall event after completion.
    {
        check = function(player, currentMission, missionStatus, vars)
            return mission:getVar(player, 'hallEvent') == 1
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['_6h4']     = mission:progressEvent(61),
            ['Arsha']    = mission:progressEvent(85),
            ['Chupaile'] = mission:progressEvent(86),
            ['Halver']   = mission:messageText(chateauID.text.HIS_MAJESTY_AWAITS),

            onEventFinish =
            {
                [61] = function(player, csid, option, npc)
                    mission:setVar(player, 'hallEvent', 0)
                end,
            },
        },
    },

    -- Optional Dialogue after Completion
    {
        check = function(player, currentMission, missionStatus, vars)
            return (currentMission == mission.missionId and player:getMissionStatus(mission.areaId) >= 4) or
                (
                    currentMission == xi.mission.id.sandoria.NONE and
                    player:hasCompletedMission(mission.areaId, mission.missionId) and
                    not player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.LEAUTES_LAST_WISHES)
                )
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'hallEvent') == 0 then
                        return mission:messageText(chateauID.text.KNEW_YOU_WERE_THE_ONE)
                    end
                end,
            },

            ['Aramaviont'] = mission:event(12),
            ['Curilla']    = mission:event(56),
            ['Milchupain'] = mission:event(33),
            ['Rahal']      = mission:event(77),
        },
    },
}

return mission
