-----------------------------------
-- Magicite
-- Windurst M4-1
-----------------------------------
-- !addmission 2 13
-- Pakh Jatalfih         : !pos 34 8 -35 243
-- _6r8 (Embassy)        : !pos 31 9 -22 243
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

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MAGICITE)

mission.reward =
{
    rank = 5,
    gil = 10000,
    keyItem = xi.ki.MESSAGE_TO_JEUNO_WINDURST,
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
            ['_6r8'] =
            {
                onTrigger = function(player, npc)
                    if not xi.mission.getMissionRankPoints(player, xi.mission.id.windurst.MAGICITE) then
                        return
                    end

                    if player:hasKeyItem(xi.ki.ARCHDUCAL_AUDIENCE_PERMIT) then
                        return mission:progressEvent(131, 1)
                    end

                    return mission:progressEvent(131, 0)
                end,
            },

            -- Event 50 points at the embassy door.
            -- Progress priority keeps it ahead of the event 54 that 3-3 serves on this NPC.
            ['Pakh_Jatalfih'] =
            {
                onTrigger = function(player, npc)
                    if xi.mission.getMissionRankPoints(player, xi.mission.id.windurst.MAGICITE) then
                        return mission:progressEvent(50)
                    end

                    return mission:event(54)
                end,
            },

            onEventFinish =
            {
                -- Both menu answers carry on into the rest of the scene.
                -- Only a cancelled event leaves the mission unstarted.
                [131] = function(player, csid, option, npc)
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

    -- Permit obtained. The archduke has not been seen.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:getMissionStatus(mission.areaId) == 1
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['_6r9']          = mission:progressEvent(128),
            ['Pakh_Jatalfih'] = mission:event(134),

            onEventFinish =
            {
                [128] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_ALDO)
                end,
            },
        },
    },

    -- Carrying the letter to Aldo.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:getMissionStatus(mission.areaId) == 2
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SILVER_BELL) then
                        return mission:progressEvent(152, 1, 1)
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

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Pakh_Jatalfih'] = mission:event(137),
        },
    },

    -- Key item hunt and magicite gathering.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:getMissionStatus(mission.areaId) == 3
        end,

        [xi.zone.ALTAR_ROOM] =
        {
            ['Magicite'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.MAGICITE_ORASTONE) then
                        return
                    end

                    -- Param 1 appends the Lion and Shadow of Darkness scene when this completes the set.
                    if
                        player:hasKeyItem(xi.ki.MAGICITE_OPTISTONE) and
                        player:hasKeyItem(xi.ki.MAGICITE_AURASTONE)
                    then
                        return mission:progressEvent(44, xi.zone.ALTAR_ROOM, 3)
                    end

                    return mission:progressEvent(44, xi.zone.ALTAR_ROOM)
                end,
            },

            onZoneIn = function(player, prevZone)
                if mission:getVar(player, 'Option') == 2 then -- Fickblix CS
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
                    mission:setVar(player, 'Option', 2) -- Fickblix CS
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

                    -- Param 2 appends the Lion and Shadow of Darkness scene when this completes the set.
                    if
                        player:hasKeyItem(xi.ki.MAGICITE_AURASTONE) and
                        player:hasKeyItem(xi.ki.MAGICITE_ORASTONE)
                    then
                        return mission:progressEvent(0, xi.zone.MONASTIC_CAVERN, 0, 1)
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

                    -- Param 0 appends the Lion and Shadow of Darkness scene when this completes the set.
                    if
                        player:hasKeyItem(xi.ki.MAGICITE_OPTISTONE) and
                        player:hasKeyItem(xi.ki.MAGICITE_ORASTONE)
                    then
                        return mission:progressEvent(0, 1, xi.ki.CORUSCANT_ROSARY, xi.ki.BLACK_MATINEE_NECKLACE)
                    end

                    return mission:progressEvent(0, 0, xi.ki.CORUSCANT_ROSARY, xi.ki.BLACK_MATINEE_NECKLACE)
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.MAGICITE_AURASTONE)
                end,
            },
        },

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

                    -- Param 0 swaps the airship pass for gil, param 1 skips the Eald'narche and Wolfgang scene when set.
                    if player:hasKeyItem(xi.ki.AIRSHIP_PASS) then
                        return mission:progressEvent(60, 1, 0)
                    end

                    return mission:progressEvent(60, 0, 0)
                end,
            },

            ['Pakh_Jatalfih'] = mission:event(137),

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

                    -- Event 23 is the follow up once the garden scene has played.
                    if mission:getVar(player, 'Option') == 1 then
                        return mission:event(23)
                    end

                    return mission:progressEvent(80)
                end,
            },

            onEventFinish =
            {
                [80] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 1) -- "Yagudo Torch" CS
                end,
            },
        },
    },

    -- The stones are handed over. The embassy closes the mission.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:getMissionStatus(mission.areaId) == 4
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] = mission:event(183),
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Pakh_Jatalfih'] = mission:progressEvent(37),

            onEventFinish =
            {
                [37] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
