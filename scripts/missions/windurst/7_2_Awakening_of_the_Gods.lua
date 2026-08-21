-----------------------------------
-- Awakening of the Gods
-- Windurst M7-2
-----------------------------------
-- !addmission 2 19
-- Rakoh Buuma      : !pos 106 -5 -23 241
-- Mokyokyo         : !pos -55 -8 227 238
-- Janshura-Rashura : !pos -227 -8 184 240
-- Zokima-Rokima    : !pos 0 -16 124 239
-- Leepe-Hoppe      : !pos 13 -9 -197 238
-- Kerutoto         : !pos 13 -5 -157 238
-- Jakoh Wahcondalo : !pos 101 -16 -115 250
-- Romaa Mihgo      : !pos 29 -13.023 -176.5 250
-- Vanono           : !pos -23.140 -5 -23.101 250
-- Granite Door     : !pos 340 0.1 329 159
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.AWAKENING_OF_THE_GODS)

mission.reward =
{
    gil  = 60000,
    rank = 8,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 19 then
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

        [xi.zone.PORT_WINDURST] =
        {
            ['Janshura-Rashura'] = mission:event(474),

            ['Nine_of_Clubs'] = mission:event(475),

            ['Puo_Rhen'] = mission:event(477),

            ['Ten_of_Clubs'] = mission:event(476),
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Chawo_Shipeynyo'] = mission:event(369),

            ['Keo-Koruo'] = mission:event(368),

            ['Pakke-Pokke'] = mission:event(367),

            ['Zokima-Rokima'] = mission:event(366),
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Dagoza-Beruza'] = mission:event(731),

            ['Kenapa-Keppa'] = mission:event(740),

            ['Kerutoto'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:event(737)
                    elseif missionStatus == 1 then
                        return mission:progressEvent(736)
                    elseif missionStatus >= 2 then
                        return mission:event(738)
                    end
                end,
            },

            ['Leepe-Hoppe'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(734)
                    elseif missionStatus == 1 then
                        return mission:event(735)
                    elseif missionStatus >= 2 and missionStatus <= 4 then
                        return mission:event(739)
                    elseif missionStatus == 5 and player:hasKeyItem(xi.ki.BOOK_OF_THE_GODS) then
                        return mission:progressEvent(742)
                    end
                end,
            },

            ['Mokyokyo'] = mission:event(730),

            ['Ohbiru-Dohbiru'] = mission:event(741),

            ['Panna-Donna'] = mission:event(732),

            ['Ten_of_Hearts'] = mission:event(733),

            onEventFinish =
            {
                [734] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [736] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,

                [742] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Miiri-Wohri'] = mission:event(575),

            ['Rakoh_Buuma'] = mission:event(574),

            ['Sola_Jaab'] = mission:event(576),

            ['Tih_Pikeh'] = mission:event(577),
        },

        [xi.zone.KAZHAM] =
        {
            ['Jakoh_Wahcondalo'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return mission:event(265)
                    end
                end,
            },

            ['Romaa_Mihgo'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 2 then
                        return mission:progressEvent(266)
                    elseif missionStatus == 3 or missionStatus == 4 then
                        return mission:event(267)
                    elseif missionStatus >= 5 then
                        return mission:event(263)
                    end
                end,
            },

            ['Vanono'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 3 then
                        return mission:progressEvent(264)
                    elseif missionStatus > 3 then
                        return mission:event(268)
                    end
                end,
            },

            onEventFinish =
            {
                [264] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                end,

                [266] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                end,
            }
        },

        [xi.zone.TEMPLE_OF_UGGALEPIH] =
        {
            ['_4fx'] =
            {
                onTrade = function(player, npc, trade)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if
                        npcUtil.tradeMatches(trade, { { xi.item.CURSED_KEY, 1 } }) and
                        player:getZPos() < 332 and
                        missionStatus >= 3 and
                        missionStatus <= 4
                    then
                        -- TODO: The decompiled event shows a param[7]. Might be based on race?
                        return mission:progressCutscene(23, 0, 0, 1, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [23] = function(player, csid, option, npc)
                    player:tradeComplete()
                    player:delKeyItem(xi.ki.BLANK_BOOK_OF_THE_GODS)
                    player:setMissionStatus(mission.areaId, 5)
                    npcUtil.giveKeyItem(player, xi.ki.BOOK_OF_THE_GODS)
                end,
            }
        },
    },
}

return mission
