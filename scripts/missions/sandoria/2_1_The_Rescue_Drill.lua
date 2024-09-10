-----------------------------------
-- The Rescue Drill
-- San d'Oria M2-1
-----------------------------------
-- !addmission 0 3
-- Ambrotien    : !pos 93.419 -0.001 -57.347 230
-- Grilau       : !pos -241.987 6.999 57.887 231
-- Endracion    : !pos -110 1 -34 230
-- Augevinne    : !pos -361 39 266 102
-- Deaufrain    : !pos -304 28 339 102
-- Equesobillot : !pos -287 9 284 102
-- Galaihaurat  : !pos -482 -7 222 102
-- Laurisse     : !pos -292 28 143 102
-- Narvecaint   : !pos -263 22 129 102
-- Vicorpasse   : !pos -344 37 266 102
-- Yaucevouchat : !pos -318 39 183 102
-- Ruillont     : !pos -70 1 607 193
-----------------------------------
local laTheinePlateauID  = zones[xi.zone.LA_THEINE_PLATEAU]
local ordellesCavesID    = zones[xi.zone.ORDELLES_CAVES]
local southernSandoriaID = zones[xi.zone.SOUTHERN_SAN_DORIA]
local northernSandoriaID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_RESCUE_DRILL)

mission.reward =
{
    rankPoints = 300,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 3 then
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

    -- Initially attempted to split this section up based on missionStatus.  This proved readable
    -- at first, but then got very messy as time went on.  Would suggest revisiting this in the
    -- future for a potential refactor.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Ambrotien'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 11 then
                        return mission:progressEvent(2005)
                    else
                        return mission:messageText(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 36)
                    end
                end,
            },

            ['Endracion'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 11 then
                        return mission:progressEvent(1005)
                    else
                        return mission:messageText(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 36)
                    end
                end,
            },

            onEventFinish =
            {
                [1005] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.RESCUE_TRAINING_CERTIFICATE)
                    end
                end,

                [2005] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.RESCUE_TRAINING_CERTIFICATE)
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Grilau'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 11 then
                        return mission:progressEvent(1005)
                    else
                        return mission:messageText(northernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 36)
                    end
                end,
            },

            onEventFinish =
            {
                [1005] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.RESCUE_TRAINING_CERTIFICATE)
                    end
                end,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Augevinne'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus >= 5 and missionStatus <= 7 then
                        return mission:progressEvent(103)
                    elseif missionStatus == 8 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 21)
                    elseif missionStatus >= 9 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 26)
                    else
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 6)
                    end
                end,
            },

            ['Deaufrain'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 3 then
                        return mission:progressEvent(102)
                    elseif missionStatus == 4 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 4)
                    elseif missionStatus == 8 then
                        if mission:getVar(player, 'Option') == 3 then
                            return mission:progressEvent(113)
                        else
                            return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 21)
                        end
                    elseif missionStatus == 9 then
                        if mission:getVar(player, 'Option') == 3 then
                            return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 25)
                        else
                            return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 26)
                        end
                    elseif missionStatus >= 10 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 30)
                    else
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL)
                    end
                end,
            },

            ['Equesobillot'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(player:getNation())

                    if missionStatus == 2 then
                        return mission:progressEvent(101)
                    elseif missionStatus == 3 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 3)
                    elseif missionStatus == 8 then
                        if mission:getVar(player, 'Option') == 2 then
                            return mission:progressEvent(112)
                        else
                            return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 21)
                        end
                    elseif missionStatus == 9 then
                        if mission:getVar(player, 'Option') == 2 then
                            return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 25)
                        else
                            return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 26)
                        end
                    elseif missionStatus >= 10 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 30)
                    else
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL)
                    end
                end,
            },

            ['Galaihaurat'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(110)
                    elseif missionStatus == 2 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 16)
                    elseif missionStatus == 8 then
                        if mission:getVar(player, 'Option') == 1 then
                            return mission:progressEvent(114)
                        else
                            return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 21)
                        end
                    elseif missionStatus == 9 then
                        if mission:getVar(player, 'Option') == 1 then
                            return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 25)
                        else
                            return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 26)
                        end
                    elseif missionStatus >= 10 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 30)
                    else
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL)
                    end
                end,
            },

            ['Laurisse'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 5 then
                        return mission:progressEvent(106)
                    elseif missionStatus >= 6 and missionStatus <= 7 then
                        return mission:progressEvent(109)
                    elseif missionStatus == 8 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 21)
                    elseif missionStatus >= 9 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 26)
                    else
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL)
                    end
                end,
            },

            ['Narvecaint'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 6 then
                        return mission:progressEvent(107)
                    elseif missionStatus == 7 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 14)
                    elseif missionStatus == 8 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 21)
                    elseif missionStatus >= 9 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 26)
                    else
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL)
                    end
                end,
            },

            ['Vicorpasse'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 4 then
                        return mission:progressEvent(108)
                    elseif missionStatus >= 5 and missionStatus <= 7 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 19)
                    elseif missionStatus == 8 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 21)
                    elseif missionStatus == 9 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 26)
                    elseif missionStatus == 10 then
                        return mission:progressEvent(115)
                    elseif missionStatus == 11 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 29, xi.ki.RESCUE_TRAINING_CERTIFICATE)
                    else
                        return mission:progressEvent(5)
                    end
                end,
            },

            ['Yaucevouchat'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus >= 5 and missionStatus <= 7 then
                        return mission:progressEvent(104)
                    elseif missionStatus == 8 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 21)
                    elseif missionStatus >= 9 then
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 26)
                    else
                        return mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 7)
                    end
                end,
            },

            onEventFinish =
            {
                [101] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                end,

                [102] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                end,

                [106] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 6)
                end,

                [107] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 7)
                end,

                [108] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 5)
                end,

                [110] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,

                [112] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.BRONZE_SWORD) then
                        player:setMissionStatus(mission.areaId, 9)
                    end
                end,

                [113] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.BRONZE_SWORD) then
                        player:setMissionStatus(mission.areaId, 9)
                    end
                end,

                [114] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.BRONZE_SWORD) then
                        player:setMissionStatus(mission.areaId, 9)
                    end
                end,

                [115] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.RESCUE_TRAINING_CERTIFICATE)
                    player:setMissionStatus(mission.areaId, 11)
                end,
            },
        },

        [xi.zone.ORDELLES_CAVES] =
        {
            ['Ruillont'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        player:getMissionStatus(mission.areaId) == 9 and
                        npcUtil.tradeHasExactly(trade, xi.item.BRONZE_SWORD)
                    then
                        return mission:progressEvent(2)
                    end
                end,

                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus >= 2 and missionStatus <= 7 then
                        return mission:progressEvent(1)
                    elseif
                        missionStatus >= 10 or
                        player:hasCompletedMission(mission.areaId, mission.missionId)
                    then
                        return mission:messageText(ordellesCavesID.text.RUILLONT_INITIAL_DIALOG + 9)
                    elseif missionStatus >= 8 then
                        return mission:messageText(ordellesCavesID.text.RUILLONT_INITIAL_DIALOG)
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', math.random(1, 3))
                    player:setMissionStatus(mission.areaId, 8)
                end,

                [2] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 10)
                    player:confirmTrade()
                end,
            },
        },
    },

    -- Player has completed Mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Galaihaurat'] = mission:messageText(laTheinePlateauID.text.RESCUE_DRILL + 39):replaceDefault()
        },
    },
}

return mission
