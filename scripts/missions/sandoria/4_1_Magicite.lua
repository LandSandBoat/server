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
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/titles')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.MAGICITE)

mission.reward =
{
    rank = 5,
    gil = 10000,
    keyItem = xi.ki.MESSAGE_TO_JEUNO_SANDORIA,
    nextMission = { xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_RUINS_OF_FEI_YIN },
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
                    if getMissionRankPoints(player, xi.mission.id.sandoria.MAGICITE) then
                        return mission:progressEvent(45)
                    else
                        return mission:progressEvent(49)
                    end
                end,
            },

            onEventFinish =
            {
                [45] = function(player, csid, option, npc)
                    mission:begin(player)
                end,
            },
        },
    },

    -- Player has accepted the mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
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
                    elseif mission:getVar(player, 'Stage') == 3 then
                        if player:hasKeyItem(xi.ki.AIRSHIP_PASS) then
                            return mission:progressEvent(60, 1)
                        else
                            return mission:progressEvent(60)
                        end
                    end
                end,
            },

            ['Nelcabrit'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 1 then
                        return mission:progressEvent(133)
                    elseif missionStatus <= 5 then
                        return mission:progressEvent(136)
                    elseif missionStatus == 6 then
                        return mission:progressEvent(36)
                    end
                end,
            },

            onEventFinish =
            {
                [36] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [60] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MAGICITE_OPTISTONE)
                    player:delKeyItem(xi.ki.MAGICITE_AURASTONE)
                    player:delKeyItem(xi.ki.MAGICITE_ORASTONE)

                    if player:hasKeyItem(xi.ki.AIRSHIP_PASS) then
                        npcUtil.giveCurrency(player, "gil", GIL_RATE * 20000)
                    else
                        npcUtil.giveKeyItem(player, xi.ki.AIRSHIP_PASS)
                    end

                    player:addTitle(xi.title.HAVE_WINGS_WILL_FLY)
                    player:setMissionStatus(mission.areaId, 6)
                end,

                [128] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                    npcUtil.giveKeyItem(player, xi.ki.LETTERS_TO_ALDO)
                end,

                [130] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                    npcUtil.giveKeyItem(player, xi.ki.ARCHDUCAL_AUDIENCE_PERMIT)
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 2 then
                        return mission:progressEvent(152)
                    elseif missionStatus == 3 then
                        return mission:progressEvent(183)
                    end
                end,
            },

            ['Muckvix'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SILVER_BELL) and not player:hasKeyItem(xi.ki.YAGUDO_TORCH) then
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
                [152] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.LETTERS_TO_ALDO)
                    npcUtil.giveKeyItem(player, xi.ki.SILVER_BELL)
                    player:setMissionStatus(mission.areaId, 3)
                end,

                [184] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.YAGUDO_TORCH)
                    mission:setVar(player, 'Option', 2) -- FickbixCS
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Paya-Sabya'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.SILVER_BELL) and
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
                    mission:setVar(player, 'Option', 1) -- YagudoTorchCS
                end,
            },
        },

        [xi.zone.ALTAR_ROOM] =
        {
            ['Magicite'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.MAGICITE_ORASTONE) then
                        if mission:getVar(player, 'Stage') == 2 then
                            -- Play Lion part of the CS (Last Magicite Received)
                            return mission:progressEvent(44, 152, 3, 1743, 3)
                        else
                            return mission:progressEvent(44)
                        end
                    end
                end,
            },

            onZoneIn = function(player, prevZone)
                if mission:getVar(player, 'Option') == 2 then
                    return 10000
                end
            end,

            onEventFinish =
            {
                [44] = function(player, csid, option, npc)
                    mission:setVar(player, 'Stage', mission:getVar(player, 'Stage') + 1)
                    player:setMissionStatus(mission.areaId, 4)
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
                        if mission:getVar(player, 'Stage') == 2 then
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
                    mission:setVar(player, 'Stage', mission:getVar(player, 'Stage') + 1)
                    player:setMissionStatus(mission.areaId, 4)
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
                        if mission:getVar(player, 'Stage') == 2 then
                            -- Play Lion part of the CS (Last Magicite Received)
                            return mission:progressEvent(0, 1)
                        else
                            return mission:progressEvent(0)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    mission:setVar(player, 'Stage', mission:getVar(player, 'Stage') + 1)
                    player:setMissionStatus(mission.areaId, 4)
                    npcUtil.giveKeyItem(player, xi.ki.MAGICITE_AURASTONE)
                end,
            },
        },
    },
}

return mission
