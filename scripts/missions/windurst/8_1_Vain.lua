-----------------------------------
-- Vain
-- Windurst M8-1
-----------------------------------
-- !addmission 2 20
-- Rakoh Buuma      : !pos 106 -5 -23 241
-- Mokyokyo         : !pos -55 -8 227 238
-- Janshura-Rashura : !pos -227 -8 184 240
-- Zokima-Rokima    : !pos 0 -16 124 239
-- Moreno-Toeno     : !pos 169 -1.25 159 238
-- Qu'Hau Spring    : !pos 0 -29 64 122
-- Sedal-Godjal     : !pos 185 -3 -116 149
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.VAIN)

mission.reward =
{
    rankPoints = 750,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 20 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

mission.sections =
{
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

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Moreno-Toeno'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(752, 0, xi.ki.STAR_SEEKER)
                    elseif missionStatus <= 3 then
                        return mission:progressEvent(753)
                    elseif missionStatus == 4 then
                        return mission:progressEvent(758)
                    end
                end,
            },

            onEventFinish =
            {
                [752] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                    npcUtil.giveKeyItem(player, xi.ki.STAR_SEEKER)
                    player:addTitle(xi.title.FUGITIVE_MINISTER_BOUNTY_HUNTER)
                end,

                [758] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.BATALLIA_DOWNS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 903
                    end
                end,
            },

            onEventUpdate =
            {
                [903] = function(player, csid, option, npc)
                    if player:getZPos() > -331 then
                        player:updateEvent(0, 0, 0, 0, 0, 3)
                    else
                        player:updateEvent(0, 0, 0, 0, 0, 2)
                    end
                end,
            },
        },

        [xi.zone.BEAUCEDINE_GLACIER] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 116
                    end
                end,
            },

            onEventUpdate =
            {
                [116] = function(player, csid, option, npc)
                    player:updateEvent(0, 0, 0, 0, 0, 4)
                end,
            },
        },

        [xi.zone.BUBURIMU_PENINSULA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 5
                    end
                end,
            },

            onEventUpdate =
            {
                [5] = function(player, csid, option, npc)
                    if
                        player:getPreviousZone() == xi.zone.LABYRINTH_OF_ONZOZO or
                        player:getPreviousZone() == xi.zone.MHAURA
                    then
                        player:updateEvent(0, 0, 0, 0, 0, 7)
                    elseif player:getPreviousZone() == xi.zone.MAZE_OF_SHAKHRAMI then
                        player:updateEvent(0, 0, 0, 0, 0, 6)
                    end
                end,
            },
        },

        [xi.zone.DAVOI] =
        {
            ['Sedal-Godjal'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.CURSE_WAND) and
                        player:getMissionStatus(mission.areaId) == 3 and
                        player:hasKeyItem(xi.ki.MAGIC_DRAINED_STAR_SEEKER)
                    then
                        return mission:progressEvent(120)
                    end
                end,

                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus >= 2 then
                        if player:hasKeyItem(xi.ki.STAR_SEEKER) then
                            return mission:progressEvent(118, 0, xi.item.CURSE_WAND, xi.ki.STAR_SEEKER)
                        elseif
                            player:hasKeyItem(xi.ki.MAGIC_DRAINED_STAR_SEEKER) and
                            missionStatus == 4
                        then
                            return mission:progressEvent(121)
                        else
                            return mission:progressEvent(119, 0, xi.item.CURSE_WAND)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [118] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.STAR_SEEKER)
                    npcUtil.giveKeyItem(player, xi.ki.MAGIC_DRAINED_STAR_SEEKER)
                    player:setMissionStatus(mission.areaId, 3)
                end,

                [120] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:setMissionStatus(mission.areaId, 4)
                end,
            },
        },

        [xi.zone.EAST_RONFAURE] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 23
                    end
                end,
            },

            onEventUpdate =
            {
                [23] = function(player, csid, option, npc)
                    if player:getYPos() >= -22 then
                        player:updateEvent(0, 0, 0, 0, 0, 7)
                    else
                        player:updateEvent(0, 0, 0, 0, 0, 6)
                    end
                end,
            },
        },

        [xi.zone.EAST_SARUTABARUTA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 52
                    end
                end,
            },

            onEventUpdate =
            {
                [52] = function(player, csid, option, npc)
                    if
                        player:getPreviousZone() == xi.zone.WINDURST_WOODS or
                        player:getPreviousZone() == xi.zone.WEST_SARUTABARUTA
                    then
                        if player:getZPos() < 570 then
                            player:updateEvent(0, 0, 0, 0, 0, 1)
                        else
                            player:updateEvent(0, 0, 0, 0, 0, 2)
                        end
                    elseif
                        player:getPreviousZone() == xi.zone.OUTER_HORUTOTO_RUINS and
                        player:getZPos() > 570
                    then
                        player:updateEvent(0, 0, 0, 0, 0, 2)
                    end
                end,
            },
        },

        [xi.zone.KONSCHTAT_HIGHLANDS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 106
                    end
                end,
            },

            onEventUpdate =
            {
                [106] = function(player, csid, option, npc)
                    if player:getZPos() > 855 then
                        player:updateEvent(0, 0, 0, 0, 0, 2)
                    elseif player:getXPos() > 32 and player:getXPos() < 370 then
                        player:updateEvent(0, 0, 0, 0, 0, 1)
                    end
                end,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 125
                    end
                end,
            },

            onEventUpdate =
            {
                [125] = function(player, csid, option, npc)
                    player:updateEvent(0, 0, 0, 0, 0, 2)
                end,
            },
        },

        [xi.zone.MERIPHATAUD_MOUNTAINS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 34
                    end
                end,
            },

            onEventUpdate =
            {
                [34] = function(player, csid, option, npc)
                    if player:getPreviousZone() == xi.zone.SAUROMUGUE_CHAMPAIGN then
                        player:updateEvent(0, 0, 0, 0, 0, 2)
                    elseif player:getPreviousZone() == xi.zone.TAHRONGI_CANYON then
                        player:updateEvent(0, 0, 0, 0, 0, 1)
                    end
                end,
            },
        },

        [xi.zone.NORTH_GUSTABERG] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 246
                    end
                end,
            },

            onEventUpdate =
            {
                [246] = function(player, csid, option, npc)
                    if player:getZPos() > 461 then
                        player:updateEvent(0, 0, 0, 0, 0, 6)
                    elseif player:getXPos() > -240 then
                        player:updateEvent(0, 0, 0, 0, 0, 7)
                    end
                end,
            },
        },

        [xi.zone.PASHHOW_MARSHLANDS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 15
                    end
                end,
            },

            onEventUpdate =
            {
                [15] = function(player, csid, option, npc)
                    if player:getXPos() < 362 then
                        player:updateEvent(0, 0, 0, 0, 0, 2)
                    end
                end,
            },
        },

        [xi.zone.ROLANBERRY_FIELDS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 4
                    end
                end,
            },

            onEventUpdate =
            {
                [4] = function(player, csid, option, npc)
                    if player:getZPos() < 75 then
                        player:updateEvent(0, 0, 0, 0, 0, 1)
                    else
                        player:updateEvent(0, 0, 0, 0, 0, 2)
                    end
                end,
            },
        },

        [xi.zone.ROMAEVE] =
        {
            ['QuHau_Spring'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) >= 1 then
                        return mission:progressEvent(2)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 3
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },

        [xi.zone.SAUROMUGUE_CHAMPAIGN] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 5
                    end
                end,
            },

            onEventUpdate =
            {
                [5] = function(player, csid, option, npc)
                    if player:getPreviousZone() == xi.zone.GARLAIGE_CITADEL then
                        player:updateEvent(0, 0, 0, 0, 0, 2)
                    elseif player:getPreviousZone() == xi.zone.MERIPHATAUD_MOUNTAINS then
                        player:updateEvent(0, 0, 0, 0, 0, 4)
                    elseif
                        player:getPreviousZone() == xi.zone.ROLANBERRY_FIELDS or
                        player:getPreviousZone() == xi.zone.PORT_JEUNO
                    then
                        player:updateEvent(0, 0, 0, 0, 0, 3)
                    end
                end,
            },
        },

        [xi.zone.SOUTH_GUSTABERG] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 37
                    end
                end,
            },

            onEventUpdate =
            {
                [37] = function(player, csid, option, npc)
                    if player:getXPos() > -390 then
                        if player:getZPos() > -301 then
                            player:updateEvent(0, 0, 0, 0, 0, 6)
                        else
                            player:updateEvent(0, 0, 0, 0, 0, 7)
                        end
                    end
                end,
            },
        },

        [xi.zone.TAHRONGI_CANYON] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 37
                    end
                end,
            },

            onEventUpdate =
            {
                [37] = function(player, csid, option, npc)
                    if
                        player:getPreviousZone() == xi.zone.EAST_SARUTABARUTA or
                        player:getPreviousZone() == xi.zone.BUBURIMU_PENINSULA
                    then
                        player:updateEvent(0, 0, 0, 0, 0, 7)
                    elseif player:getPreviousZone() == xi.zone.MAZE_OF_SHAKHRAMI then
                        player:updateEvent(0, 0, 0, 0, 0, 6)
                    end
                end,
            },
        },

        [xi.zone.THE_SANCTUARY_OF_ZITAH] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 4
                    end
                end,
            },

            onEventUpdate =
            {
                [4] = function(player, csid, option, npc)
                    if player:getPreviousZone() == xi.zone.THE_BOYAHDA_TREE then
                        player:updateEvent(0, 0, 0, 0, 0, 7)
                    elseif player:getPreviousZone() == xi.zone.MERIPHATAUD_MOUNTAINS then
                        player:updateEvent(0, 0, 0, 0, 0, 1)
                    end
                end,
            },
        },

        [xi.zone.VALKURM_DUNES] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 5
                    end
                end,
            },

            onEventUpdate =
            {
                [5] = function(player, csid, option, npc)
                    if player:getZPos() > 45 then
                        if player:getZPos() > -301 then
                            player:updateEvent(0, 0, 0, 0, 0, 1)
                        else
                            player:updateEvent(0, 0, 0, 0, 0, 3)
                        end
                    end
                end,
            },
        },

        [xi.zone.WEST_RONFAURE] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 53
                    end
                end,
            },

            onEventUpdate =
            {
                [53] = function(player, csid, option, npc)
                    player:updateEvent(0, 0, 0, 0, 0, 5)
                end,
            },
        },

        [xi.zone.WEST_SARUTABARUTA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 50
                    end
                end,
            },

            onEventUpdate =
            {
                [50] = function(player, csid, option, npc)
                    if player:getZPos() > 470 then
                        player:updateEvent(0, 0, 0, 0, 0, 2)
                    else
                        player:updateEvent(0, 0, 0, 0, 0, 1)
                    end
                end,
            },
        },

        [xi.zone.XARCABARD] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 11
                    end
                end,
            },

            onEventUpdate =
            {
                [11] = function(player, csid, option, npc)
                    if player:getPreviousZone() == xi.zone.BEAUCEDINE_GLACIER then
                        player:updateEvent(0, 0, 0, 0, 0, 2)
                    else
                        player:updateEvent(0, 0, 0, 0, 0, 3)
                    end
                end,
            },
        },
    },
}

return mission
