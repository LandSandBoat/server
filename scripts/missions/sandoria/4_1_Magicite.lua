-----------------------------------
-- Magicite
-- San d'Oria M4-1
-----------------------------------
-- !addmission 0 13
-- Nelcabrit             : !pos -32 9 -49 243
-- _6r5 (Embassy)        : !pos -31.107 7.501 -65.061 243
-- _6r9 (Audience Chmbr) : !pos 0 -5 66 243
-- Aldo                  : !pos 20 3 -58 245
-- Paya-Sabya            : !pos 9 1 70 244
-- Geebeh                : !pos 11 1 68 244
-- Muckvix               : !pos -26.824 4.601 -137.082 245
-- Magicite (Orastone)   : !pos -344 25 43 152
-- Magicite (Optistone)  : !pos -160 -8 8 150
-- Magicite (Aurastone)  : !pos 11 25 -81 148
-----------------------------------
local ruludeID     = zones[xi.zone.RULUDE_GARDENS]
local upperJeunoID = zones[xi.zone.UPPER_JEUNO]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.MAGICITE)

mission.reward =
{
    rank = 5,
    gil = 10000,
    keyItem = xi.ki.MESSAGE_TO_JEUNO_SANDORIA,
}

mission.sections =
{
    -- Player has no active missions
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId and
                player:getRank(mission.areaId) == 4
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nelcabrit'] =
            {
                onTrigger = function(player, npc)
                    if xi.mission.getMissionRankPoints(player, xi.mission.id.sandoria.MAGICITE) then
                        return mission:progressEvent(45)
                    end

                    return mission:event(49)
                end,
            },

            ['_6r5'] =
            {
                onTrigger = function(player, npc)
                    if not xi.mission.getMissionRankPoints(player, xi.mission.id.sandoria.MAGICITE) then
                        return
                    end

                    if player:hasKeyItem(xi.ki.ARCHDUCAL_AUDIENCE_PERMIT) then
                        return mission:progressEvent(130, 1)
                    end

                    return mission:progressEvent(130, 0)
                end,
            },

            onEventFinish =
            {
                -- Both menu answers carry on into the rest of the scene.
                -- Only a cancelled event leaves the mission unstarted.
                [130] = function(player, csid, option, npc)
                    if option == utils.EVENT_CANCELLED_OPTION then
                        return
                    end

                    mission:begin(player)
                    player:setMissionStatus(mission.areaId, 1)
                    player:messageText(npc, ruludeID.text.YOU_ACCEPT_THE_MISSION, false, 6)
                    npcUtil.giveKeyItem(player, xi.ki.ARCHDUCAL_AUDIENCE_PERMIT)
                end,
            },
        },
    },

    -- Section 1: Mandatory pre-requisites. Necessary steps required even when having completed this mission for another nation.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:getMissionStatus(mission.areaId) <= 2
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['_6r9'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(128)
                    end
                end,
            },

            ['Nelcabrit'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:event(133)
                    end

                    return mission:event(136)
                end,
            },

            onEventFinish =
            {
                [128] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_ALDO)
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) ~= 2 then
                        return
                    end

                    if player:hasKeyItem(xi.ki.SILVER_BELL) then
                        return mission:progressEvent(152, 1)
                    end

                    return mission:progressEvent(152, 0, 1)
                end,
            },

            onEventFinish =
            {
                [152] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                    player:delKeyItem(xi.ki.LETTER_TO_ALDO)

                    if not player:hasKeyItem(xi.ki.SILVER_BELL) then
                        npcUtil.giveKeyItem(player, xi.ki.SILVER_BELL)
                    end
                end,
            },
        },
    },

    -- Section 2: Key Item hunt and Magicite gathering. Several steps aren't required or may have been already completed in another nation.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:getMissionStatus(mission.areaId) == 3
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['_6r9'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.MAGICITE_OPTISTONE) or
                        not player:hasKeyItem(xi.ki.MAGICITE_AURASTONE) or
                        not player:hasKeyItem(xi.ki.MAGICITE_ORASTONE)
                    then
                        return
                    end

                    if player:hasKeyItem(xi.ki.AIRSHIP_PASS) then
                        return mission:progressEvent(60, 1, 0)
                    end

                    return mission:progressEvent(60, 0, 0)
                end,
            },

            ['Nelcabrit'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(136)
                end,
            },

            onEventFinish =
            {
                [60] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MAGICITE_OPTISTONE)
                    player:delKeyItem(xi.ki.MAGICITE_AURASTONE)
                    player:delKeyItem(xi.ki.MAGICITE_ORASTONE)

                    if player:hasKeyItem(xi.ki.AIRSHIP_PASS) then
                        npcUtil.giveCurrency(player, 'gil', 20000)
                    else
                        npcUtil.giveKeyItem(player, xi.ki.AIRSHIP_PASS)
                    end

                    player:addTitle(xi.title.HAVE_WINGS_WILL_FLY)
                    player:setMissionStatus(mission.areaId, 4)
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.MAGICITE_OPTISTONE) and
                        not player:hasKeyItem(xi.ki.MAGICITE_AURASTONE) and
                        not player:hasKeyItem(xi.ki.MAGICITE_ORASTONE)
                    then
                        return mission:event(161)
                    end

                    return mission:event(183)
                end,
            },

            ['Muckvix'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.YAGUDO_TORCH) then
                        if mission:getVar(player, 'Option') == 1 then
                            return mission:progressEvent(184)
                        else
                            return mission:event(80)
                        end
                    else
                        if mission:getVar(player, 'Option') == 2 then
                            return mission:event(81)
                        else
                            return mission:event(79)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [184] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.YAGUDO_TORCH)
                    mission:setVar(player, 'Option', 2) -- Fickbix CS
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Geebeh'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.YAGUDO_TORCH) and
                        mission:getVar(player, 'Option') == 1
                    then
                        return mission:messageText(upperJeunoID.text.WITHER_AND_DIE)
                    end
                end,
            },

            ['Paya-Sabya'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.YAGUDO_TORCH) then
                        return
                    end

                    local option = mission:getVar(player, 'Option')

                    -- Event 23 is the follow up once the garden scene has played.
                    if option == 1 then
                        return mission:event(23)
                    elseif option == 0 then
                        return mission:progressEvent(80)
                    end
                end,
            },

            onEventFinish =
            {
                [80] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 1) -- "Yagudo Torch" CS
                end,
            },
        },

        [xi.zone.ALTAR_ROOM] =
        {
            ['Magicite'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.MAGICITE_ORASTONE) then
                        return
                    end

                    if
                        player:hasKeyItem(xi.ki.MAGICITE_OPTISTONE) and
                        player:hasKeyItem(xi.ki.MAGICITE_AURASTONE)
                    then
                        -- Play Lion part of the CS (Last Magicite Received)
                        return mission:progressEvent(44, xi.zone.ALTAR_ROOM, 3)
                    end

                    return mission:progressEvent(44, xi.zone.ALTAR_ROOM)
                end,
            },

            onZoneIn = function(player, prevZone)
                if mission:getVar(player, 'Option') == 2 then -- Fickbix CS
                    return 10000
                end
            end,

            onEventFinish =
            {
                [44] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.MAGICITE_ORASTONE)
                end,

                -- A cancelled event does not retire the Fickblix scene.
                [10000] = function(player, csid, option, npc)
                    if option == utils.EVENT_CANCELLED_OPTION then
                        return
                    end

                    mission:setVar(player, 'Option', 0)
                end,
            },
        },

        [xi.zone.MONASTIC_CAVERN] =
        {
            ['Magicite'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.MAGICITE_OPTISTONE) then
                        return
                    end

                    if
                        player:hasKeyItem(xi.ki.MAGICITE_AURASTONE) and
                        player:hasKeyItem(xi.ki.MAGICITE_ORASTONE)
                    then
                        -- Play Lion part of the CS (Last Magicite Received)
                        return mission:progressEvent(0, 1, 1, 1, 1, 1, 1, 1, 1)
                    end

                    return mission:progressEvent(0, xi.zone.MONASTIC_CAVERN)
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.MAGICITE_OPTISTONE)
                end,
            },
        },

        [xi.zone.QULUN_DOME] =
        {
            ['Magicite'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.MAGICITE_AURASTONE) then
                        return
                    end

                    if
                        player:hasKeyItem(xi.ki.MAGICITE_OPTISTONE) and
                        player:hasKeyItem(xi.ki.MAGICITE_ORASTONE)
                    then
                        -- Play Lion part of the CS (Last Magicite Received)
                        return mission:progressEvent(0, 1, 46, 47)
                    end

                    return mission:progressEvent(0, 0, 46, 47)
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.MAGICITE_AURASTONE)
                end,
            },
        },
    },

    -- Section 3: Magicite given to Jeuno leader. Finish quest.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:getMissionStatus(mission.areaId) == 4
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nelcabrit'] = mission:progressEvent(36),

            onEventFinish =
            {
                [36] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(183)
                end,
            },
        },
    },
}

return mission
