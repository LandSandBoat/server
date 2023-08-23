-----------------------------------
-- Three Paths
-- Promathia 5-3
-----------------------------------
-- !addmission 6 530
-- Cid : !pos -12 -12 1 237

-- Louverance's Path
-- Despachiaire : !pos 108 -40 -83 26
-- Perih Vashai : !pos 117 -3 92 241
-- Warmachine   : !pos -345.236 -3.188 -976.563 4
-- Yoran-Oran   : !pos -109.987 -14 203.338 239
-- Tarnotik     : !pos 160.896 10.999 -55.659 11

-- Tenzen's Path
-- qm3          : !pos -179.693 8.845 254.327 102
-- Grate (J-8)  : !pos 241 5 -20 111
-- Monberaux    : !pos -42 0 -2 244
-- Pherimociel  : !pos -31.627 1.002 67.956 243
-- qm4          : !pos 426.315 8.563 -163.337 105
-- _545         : !pos 460 -2.488 125.77 184
-- Grate (H-10) : !pos 60 5 -359 111

-- Ulmia's Path
-- Hinaree    : !pos -301.535 -10.199 97.698 230
-- Chasalvige : !pos 96.432 -0.520 134.046 231
-- Kerutoto   : !pos 13 -5 -157 238
-- Yoran-Oran : !pos -109.987 -14 203.338 239
-- Bearclaw Pinnacle (HP2) : !pos 379 23 -62.6 5
-----------------------------------
local lowerDelkfuttsID = zones[xi.zone.LOWER_DELKFUTTS_TOWER]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS)

mission.reward =
{
    title       = xi.title.TREADER_OF_AN_ICY_PAST,
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG },
}

local eventArgOffset =
{
    [xi.mission.status.COP.LOUVERANCE] = 1,
    [xi.mission.status.COP.TENZEN]     = 2,
    [xi.mission.status.COP.ULMIA]      = 4,
}

local function getCidEventArg(player)
    local eventArg = 0

    for pathArg = xi.mission.status.COP.LOUVERANCE, xi.mission.status.COP.ULMIA do
        if
            player:getMissionStatus(mission.areaId, pathArg) == 14
        then
            eventArg = eventArg + eventArgOffset[pathArg]
        end
    end

    return eventArg
end

local function isMissionComplete(player)
    for pathArg = xi.mission.status.COP.LOUVERANCE, xi.mission.status.COP.ULMIA do
        if player:getMissionStatus(mission.areaId, pathArg) ~= 14 then
            return false
        end
    end

    return true
end

mission.sections =
{
    -- Cid reminder dialogue, common to all paths
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrigger = function(player, npc)
                    -- We don't want to default return this, as it could cause competing events in multiple sections.  Also,
                    -- cannot use oncePerZone, as we need to reset this dialogue option should the player complete a section.
                    if
                        mission:getLocalVar(player, 'cidOption') == 0 and
                        player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) ~= 12 and
                        player:getMissionStatus(mission.areaId, xi.mission.status.COP.TENZEN) ~= 12 and
                        player:getMissionStatus(mission.areaId, xi.mission.status.COP.ULMIA) ~= 9
                    then
                        return mission:event(851, getCidEventArg(player)):setPriority(995)
                    end
                end,
            },

            onEventFinish =
            {
                [851] = function(player, csid, option, npc)
                    mission:setLocalVar(player, 'cidOption', 1)
                end,
            },
        },
    },

    -- Louverance's Path
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) <= 14
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) == 0 then
                        return mission:event(118):importantEvent()
                    else
                        return mission:event(134)
                    end
                end,
            },

            onEventFinish =
            {
                [118] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2, xi.mission.status.COP.LOUVERANCE)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE)

                    if missionStatus == 2 then
                        return mission:event(686):importantEvent()
                    elseif missionStatus == 3 then
                        return mission:event(687):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [686] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3, xi.mission.status.COP.LOUVERANCE)
                end,
            },
        },

        [xi.zone.BIBIKI_BAY] =
        {
            ['Warmachine'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) == 3 then
                        return mission:progressEvent(33)
                    end
                end,
            },

            onEventFinish =
            {
                [33] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 6, xi.mission.status.COP.LOUVERANCE)
                end,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Yoran-Oran'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) == 6 then
                        return mission:event(481):importantEvent()
                    end
                end,
            },
        },

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Tarnotik'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) == 11 then
                        return mission:event(34):importantEvent()
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) == 6 then
                        return 1
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 8, xi.mission.status.COP.LOUVERANCE)
                end,
            },
        },

        [xi.zone.MINE_SHAFT_2716] =
        {
            ['_0d0'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) == 11 and
                        npcUtil.tradeHasExactly(trade, xi.item.GOLD_KEY)
                    then
                        return mission:progressEvent(3)
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    player:confirmTrade()
                    -- NOTE: This event transports you to the BCNM exit, and is handled by the client.
                    -- POS: -87.410 180 499.929 127 13
                    player:setMissionStatus(mission.areaId, 12, xi.mission.status.COP.LOUVERANCE)
                end,

                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == 736 and
                        player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE) == 8
                    then
                        player:setMissionStatus(mission.areaId, 9, xi.mission.status.COP.LOUVERANCE)
                    end
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.LOUVERANCE)

                    if missionStatus == 9 then
                        return mission:progressEvent(852)
                    elseif missionStatus == 12 then
                        return mission:progressEvent(853, getCidEventArg(player))
                    end
                end,
            },

            onEventFinish =
            {
                [852] = function(player, csid, option, npc)
                    mission:setLocalVar(player, 'cidOption', 0)
                    player:setMissionStatus(mission.areaId, 11, xi.mission.status.COP.LOUVERANCE)
                end,

                [853] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 14, xi.mission.status.COP.LOUVERANCE)
                    player:addTitle(xi.title.COMPANION_OF_LOUVERANCE)

                    if isMissionComplete(player) then
                        mission:complete(player)
                    else
                        mission:setLocalVar(player, 'cidOption', 0)
                    end
                end,
            },
        },
    },

    -- Tenzen's Path
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:getMissionStatus(mission.areaId, xi.mission.status.COP.TENZEN) <= 14
        end,

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['qm3'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.TENZEN) == 0 then
                        return mission:event(203):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [203] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2, xi.mission.status.COP.TENZEN)
                end,
            },
        },

        [xi.zone.PSOXJA] =
        {
            ['_09g'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.TENZEN) == 2 then
                        return mission:progressEvent(3)
                    end
                end,
            },

            ['_09h'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.TENZEN) == 11 then
                        return mission:progressEvent(5)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if
                        player:getXPos() == 220 and
                        player:getMissionStatus(mission.areaId, xi.mission.status.COP.TENZEN) == 9
                    then
                        return 4
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3, xi.mission.status.COP.TENZEN)
                end,

                [4] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 11, xi.mission.status.COP.TENZEN)
                end,

                [5] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 12, xi.mission.status.COP.TENZEN)
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Monberaux'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.TENZEN)

                    if missionStatus == 3 then
                        return mission:progressEvent(74)
                    elseif missionStatus == 5 then
                        return mission:event(5):importantEvent()
                    elseif missionStatus == 6 then
                        return mission:event(6):importantEvent()
                    elseif missionStatus == 8 then
                        return mission:event(7):importantEvent()
                    end
                end,
            },

            ['Rosaline'] = mission:event(96),

            onEventFinish =
            {
                [74] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.ENVELOPE_FROM_MONBERAUX)
                    player:setMissionStatus(mission.areaId, 5, xi.mission.status.COP.TENZEN)
                end,
            },
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Pherimociel'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.TENZEN) == 5 then
                        return mission:progressEvent(58)
                    end
                end,
            },

            onEventFinish =
            {
                [58] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 6, xi.mission.status.COP.TENZEN)
                end,
            },
        },

        [xi.zone.BATALLIA_DOWNS] =
        {
            ['qm4'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.TENZEN) == 6 then
                        if mission:getVar(player, 'Option') == 1 then
                            return mission:progressEvent(1)
                        else
                            return mission:progressEvent(0)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 1)
                end,

                [1] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.DELKFUTT_RECOGNITION_DEVICE)
                    mission:setVar(player, 'Option', 0)
                    player:setMissionStatus(mission.areaId, 8, xi.mission.status.COP.TENZEN)
                end,
            },
        },

        [xi.zone.LOWER_DELKFUTTS_TOWER] =
        {
            ['_545'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.TENZEN)

                    if
                        missionStatus == 8 and
                        player:hasKeyItem(xi.ki.DELKFUTT_RECOGNITION_DEVICE)
                    then
                        if
                            mission:getLocalVar(player, 'hasKilled') == 0 and
                            npcUtil.popFromQM(player, npc, lowerDelkfuttsID.mob.DISASTER_IDOL, { hide = 0 })
                        then
                            return mission:messageSpecial(lowerDelkfuttsID.text.SOMETHING_HUGE_BEARING_DOWN)
                        elseif mission:getLocalVar(player, 'hasKilled') == 1 then
                            return mission:progressEvent(25)
                        end
                    end
                end,
            },

            ['Disaster_Idol'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if mission:getLocalVar(player, 'hasKilled') == 0 then
                        mission:setLocalVar(player, 'hasKilled', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [25] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 9, xi.mission.status.COP.TENZEN)
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.TENZEN) == 12 then
                        return mission:progressEvent(854, getCidEventArg(player))
                    end
                end,
            },

            onEventFinish =
            {
                [854] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 14, xi.mission.status.COP.TENZEN)
                    player:addTitle(xi.title.TENZENS_ALLY)

                    if isMissionComplete(player) then
                        mission:complete(player)
                    else
                        mission:setLocalVar(player, 'cidOption', 0)
                    end
                end,
            },
        },
    },

    -- Ulmia's Path
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:getMissionStatus(mission.areaId, xi.mission.status.COP.ULMIA) <= 14
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hinaree'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.ULMIA)

                    if missionStatus == 0 then
                        return mission:progressEvent(22)
                    elseif missionStatus == 2 then
                        return mission:event(25):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [22] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2, xi.mission.status.COP.ULMIA)
                end,
            },
        },

        [xi.zone.PORT_SAN_DORIA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.ULMIA) == 2 then
                        return 4
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3, xi.mission.status.COP.ULMIA)
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Chasalvige'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.ULMIA)

                    if missionStatus == 3 then
                        return mission:progressEvent(762)
                    elseif missionStatus == 4 then
                        return mission:event(763):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [762] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4, xi.mission.status.COP.ULMIA)
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kerutoto'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.ULMIA)

                    if missionStatus == 4 then
                        return mission:progressEvent(876)
                    elseif missionStatus == 6 then
                        return mission:event(882):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [876] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 6, xi.mission.status.COP.ULMIA)
                end,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Yoran-Oran'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId, xi.mission.status.COP.ULMIA)

                    if missionStatus == 6 then
                        return mission:progressEvent(473)
                    elseif missionStatus == 7 then
                        return mission:event(479):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [473] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 7, xi.mission.status.COP.ULMIA)
                end,
            },
        },

        [xi.zone.BONEYARD_GULLY] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == 672 and
                        player:getMissionStatus(mission.areaId, xi.mission.status.COP.ULMIA) == 7
                    then
                        player:setMissionStatus(mission.areaId, 8, xi.mission.status.COP.ULMIA)
                    end
                end,
            },
        },

        [xi.zone.BEARCLAW_PINNACLE] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == 640 and
                        player:getMissionStatus(mission.areaId, xi.mission.status.COP.ULMIA) == 8
                    then
                        player:setMissionStatus(mission.areaId, 9, xi.mission.status.COP.ULMIA)
                    end
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId, xi.mission.status.COP.ULMIA) == 9 then
                        return mission:progressEvent(855, getCidEventArg(player))
                    end
                end,
            },

            onEventFinish =
            {
                [855] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 14, xi.mission.status.COP.ULMIA)
                    player:addTitle(xi.title.ULMIAS_SOULMATE)

                    if isMissionComplete(player) then
                        mission:complete(player)
                    else
                        mission:setLocalVar(player, 'cidOption', 0)
                    end
                end,
            },
        },
    },
}

return mission
