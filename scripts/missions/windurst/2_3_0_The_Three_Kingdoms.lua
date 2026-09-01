-----------------------------------
-- The Three Kingdoms
-- Windurst M2-3
-----------------------------------
-- !addmission 2 5
-- Rakoh Buuma      : !pos 106 -5 -23 241
-- Mokyokyo         : !pos -55 -8 227 238
-- Janshura-Rashura : !pos -227 -8 184 240
-- Zokima-Rokima    : !pos 0 -16 124 239
-- Kupipi           : !pos 2 0.1 30 242
-- Heruze-Moruze    : !pos -56 -3 36 231
-- Kasaroro         : !pos -72 -3 34 231
-- Patt-Pott        : !pos 23 -17 42 237
-----------------------------------
local northernSandoriaID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS)

mission.reward =
{
    rank    = 3,
    gil     = 3000,
    keyItem = xi.ki.ADVENTURERS_CERTIFICATE,
    title   = xi.title.CERTIFIED_ADVENTURER,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 5 then
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
            ['Janshura-Rashura'] = mission:progressEvent(138),
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Zokima-Rokima'] = mission:progressEvent(134),
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Dagoza-Beruza'] = mission:event(213),
            ['Mokyokyo']      = mission:progressEvent(215),
            ['Panna-Donna']   = mission:event(212),
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Rakoh_Buuma'] = mission:progressEvent(177),
        },

        [xi.zone.HEAVENS_TOWER] =
        {
            ['Kupipi'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        if xi.settings.main.ENABLE_TRUST_QUESTS == 1 then
                            local needsSemihTrust = (not player:hasSpell(xi.magic.spell.SEMIH_LAFIHNA) and not player:findItem(xi.item.CIPHER_OF_SEMIHS_ALTER_EGO)) and 1 or 0

                            return mission:progressEvent(95, 0, 0, 0, xi.ki.LETTER_TO_THE_CONSULS_WINDURST, 0, 0, 0, needsSemihTrust)
                        else
                            return mission:progressEvent(95, 0, 0, 0, xi.ki.LETTER_TO_THE_CONSULS_WINDURST)
                        end
                    elseif missionStatus == 11 then
                        return mission:progressEvent(101, 0, 0, xi.ki.ADVENTURERS_CERTIFICATE)
                    -- Kupipi alternates two lines. The toggle advances in onEventFinish.
                    elseif player:getLocalVar('KupipiRepeatLine') == 0 then
                        return mission:progressEvent(97)
                    else
                        return mission:progressEvent(98)
                    end
                end,
            },

            onEventFinish =
            {
                [95] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_THE_CONSULS_WINDURST)

                    if
                        xi.settings.main.ENABLE_TRUST_QUESTS == 1 and
                        not player:hasSpell(xi.magic.spell.SEMIH_LAFIHNA) and
                        not player:findItem(xi.item.CIPHER_OF_SEMIHS_ALTER_EGO)
                    then
                        npcUtil.giveItem(player, xi.item.CIPHER_OF_SEMIHS_ALTER_EGO)
                    end
                end,

                -- onTrigger also runs on clicks where the action is discarded for the NPC's own file.
                [97] = function(player, csid, option, npc)
                    player:setLocalVar('KupipiRepeatLine', 1)
                end,

                [98] = function(player, csid, option, npc)
                    player:setLocalVar('KupipiRepeatLine', 0)
                end,

                [101] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.KINDRED_REPORT)
                    end
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Mih_Ketto'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    -- Both consuls have been visited.
                    if missionStatus == 11 then
                        return mission:event(268)
                    -- Carrying the letter of introduction.
                    elseif missionStatus > 0 then
                        return mission:event(266)
                    end
                end,
            },

            ['Moyoyo'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    -- Both consuls have been visited.
                    if missionStatus == 11 then
                        return mission:event(265)
                    -- Carrying the letter of introduction.
                    elseif missionStatus > 0 then
                        return mission:event(263)
                    end
                end,
            },

            ['Patt-Pott'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 1 then
                        return mission:progressEvent(254)
                    elseif missionStatus == 6 then
                        return mission:progressEvent(256)
                    elseif missionStatus == 7 then
                        return mission:progressEvent(258)
                    elseif missionStatus == 11 then
                        return mission:progressEvent(259)
                    end
                end,
            },

            ['Topuru-Kuperu'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    -- Both consuls have been visited.
                    if missionStatus == 11 then
                        return mission:event(262)
                    -- Carrying the letter of introduction.
                    elseif missionStatus > 0 then
                        return mission:event(260)
                    end
                end,
            },

            onEventFinish =
            {
                [254] = function(player, csid, option, npc)
                    player:delMission(mission.areaId, mission.missionId)
                    player:addMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK)
                    player:setMissionStatus(mission.areaId, 3)
                end,

                -- The second consul visited takes the letter.
                [256] = function(player, csid, option, npc)
                    player:delMission(mission.areaId, mission.missionId)
                    player:addMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2)
                    player:delKeyItem(xi.ki.LETTER_TO_THE_CONSULS_WINDURST)
                    player:setMissionStatus(mission.areaId, 8)
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Heruze-Moruze'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        local onPathUntraveled = player:getCurrentMission(xi.mission.log_id.ROV) == xi.mission.id.rov.THE_PATH_UNTRAVELED and 1 or 0

                        return mission:progressEvent(582, { [7] = onPathUntraveled })
                    end
                end,
            },

            ['Kasaroro'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 2 then
                        return mission:progressEvent(546)
                    elseif missionStatus == 6 then
                        return mission:messageText(northernSandoriaID.text.KASARORO_DIALOG + 7)
                    elseif missionStatus == 7 then
                        return mission:progressEvent(547)
                    elseif missionStatus == 11 then
                        player:showText(npc, northernSandoriaID.text.KASARORO_DIALOG + 20)
                        return mission:noAction()
                    end
                end,
            },

            onEventFinish =
            {
                [546] = function(player, csid, option, npc)
                    player:delMission(mission.areaId, mission.missionId)
                    player:addMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA)
                    player:setMissionStatus(mission.areaId, 3)
                end,

                -- The second consul visited takes the letter.
                [547] = function(player, csid, option, npc)
                    player:delMission(mission.areaId, mission.missionId)
                    player:addMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA2)
                    player:delKeyItem(xi.ki.LETTER_TO_THE_CONSULS_WINDURST)
                    player:setMissionStatus(mission.areaId, 8)
                end,

                [582] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:hasCompletedMission(mission.areaId, mission.missionId) and
                player:getNation() == xi.nation.WINDURST
        end,

        [xi.zone.HEAVENS_TOWER] =
        {
            ['Kupipi'] = mission:event(102),
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Kasaroro'] = mission:event(604):replaceDefault(),
        },
    },
}

return mission
