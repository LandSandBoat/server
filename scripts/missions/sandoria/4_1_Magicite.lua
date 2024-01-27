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
-- Muckvix               : !pos -26.824 3.601 -137.082 245
-- Magicite (Orastone)   : !pos -344 25 43 152
-- Magicite (Opistone)   : !pos -160 -8 8 150
-- Magicite (Aurastone)  : !pos 11 25 -81 148
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.MAGICITE)

local function magiciteCounter(player)
    local count = 0
    for keyItem = xi.ki.MAGICITE_OPTISTONE, xi.ki.MAGICITE_ORASTONE do
        if player:hasKeyItem(keyItem) then
            count = count + 1
        end
    end

    return count
end

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
                    else
                        return mission:progressEvent(49)
                    end
                end,
            },

            onEventFinish =
            {
                [45] = function(player, csid, option, npc)
                    -- TODO: Verify that the mission is displayed in the logs here.  It may not officially be logged
                    -- until talking to the Ambassador.
                    mission:begin(player)
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
            ['_6r5'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        local hasKIParam = player:hasKeyItem(xi.ki.ARCHDUCAL_AUDIENCE_PERMIT) and 1 or 0
                        return mission:progressEvent(130, hasKIParam)
                    end
                end,
            },

            ['_6r9'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(128)
                    end
                end,
            },

            ['High_Wind'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        -- Note: The event parameter below corresponds to having keyItem for Audience Permit.
                        -- Currently have not captured a case where the negative answer is displayed.
                        return mission:progressEvent(164, 1)
                    end
                end,
            },

            ['Rainhard'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(165, 1)
                    end
                end,
            },

            ['Nelcabrit'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        -- Nelcabrit will display this message until talking to Jima (Door)
                        return mission:progressEvent(45)
                    elseif missionStatus == 1 then
                        return mission:progressEvent(133)
                    else
                        return mission:progressEvent(136)
                    end
                end,
            },

            onEventFinish =
            {
                [128] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_ALDO)
                end,

                [130] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                    -- You Accept the Mission message here
                    npcUtil.giveKeyItem(player, xi.ki.ARCHDUCAL_AUDIENCE_PERMIT)
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        if player:hasKeyItem(xi.ki.SILVER_BELL) then
                            return mission:progressEvent(152, 1)
                        else
                            return mission:progressEvent(152)
                        end
                    end
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
                    if magiciteCounter(player) == 3 then
                        if player:hasKeyItem(xi.ki.AIRSHIP_PASS) then
                            return mission:progressEvent(60, 1, 1)
                        else
                            return mission:progressEvent(60)
                        end
                    end
                end,
            },

            ['High_Wind'] =
            {
                onTrigger = function(player, npc)
                    if magiciteCounter(player) == 3 then
                        return mission:progressEvent(164, 1)
                    end
                end,
            },

            ['Rainhard'] =
            {
                onTrigger = function(player, npc)
                    if magiciteCounter(player) == 3 then
                        return mission:progressEvent(165, 1)
                    end
                end,
            },

            ['Nelcabrit'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(136)
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
                    if magiciteCounter(player) == 0 then
                        return mission:progressEvent(161)
                    else
                        return mission:progressEvent(183)
                    end
                end,
            },

            ['Muckvix'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.YAGUDO_TORCH) then
                        if mission:getVar(player, 'Option') == 1 then
                            return mission:progressEvent(184)
                        else
                            return mission:progressEvent(80)
                        end
                    else
                        if mission:getVar(player, 'Option') == 2 then
                            return mission:progressEvent(81)
                        else
                            return mission:progressEvent(79)
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
            ['Paya-Sabya'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.YAGUDO_TORCH) and
                        mission:getVar(player, 'Option') == 0
                    then
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
                    if not player:hasKeyItem(xi.ki.MAGICITE_ORASTONE) then
                        if magiciteCounter(player) == 2 then
                            -- Play Lion part of the CS (Last Magicite Received)
                            return mission:progressEvent(44, 152, 3, 1743, 3)
                        else
                            return mission:progressEvent(44)
                        end
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Option') == 2 then -- Fickbix CS
                        return 10000
                    end
                end,
            },

            onEventFinish =
            {
                [44] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.MAGICITE_ORASTONE)
                end,

                [10000] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 0)
                end,
            },
        },

        [xi.zone.MONASTIC_CAVERN] =
        {
            ['Magicite'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.MAGICITE_OPTISTONE) then
                        if magiciteCounter(player) == 2 then
                            -- Play Lion part of the CS (Last Magicite Received)
                            return mission:progressEvent(0, 1, 1, 1, 1, 1, 1, 1, 1)
                        else
                            return mission:progressEvent(0)
                        end
                    end
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
                    if not player:hasKeyItem(xi.ki.MAGICITE_AURASTONE) then
                        if magiciteCounter(player) == 2 then
                            -- Play Lion part of the CS (Last Magicite Received)
                            return mission:progressEvent(0, 1, 46, 47)
                        else
                            return mission:progressEvent(0, 0, 46, 47)
                        end
                    end
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
            ['Nelcabrit'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 4 then
                        return mission:progressEvent(36)
                    end
                end,
            },

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
                    return mission:progressEvent(183)
                end,
            },
        },
    },
}

return mission
