-----------------------------------
-- Dawn
-- Promathia 8-4
-----------------------------------
-- !addmission 6 840
-- Zone Into Al'Taieu
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require("scripts/globals/teleports")
require('scripts/globals/titles')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)

mission.reward =
{
    nextMission = xi.mission.id.cop.THE_LAST_VERSE,
}

local additionalCS =
{
    'TenzenCS',
    'ChebukkisCS',
    'ShikareesCS',
    'JabbosCS',
    'LouveranceCS',
}

local checkAdditionalCS = function(player)
    local csCount = 0
    for _, cs in pairs(additionalCS) do
        if mission:getVar(player, cs) == 1 then
            csCount = csCount + 1
        end
    end

    if csCount == 5 then
        for _, cs in pairs(additionalCS) do
            mission:setVar(player, cs, 0)
        end
    end

    return csCount
end

local rings =
{
    xi.items.RAJAS_RING,
    xi.items.SATTVA_RING,
    xi.items.TAMAS_RING,
}

local ringCheck = function(player)
    for _, ring in pairs(rings) do
        if player:hasItem(ring) then
            return true
        end
    end

    return false
end

local updateRingEvent = function(player, csid, option)
    if option == 4 then
        player:updateEvent(rings[1], rings[2], rings[3])
    end
end

local ringFunction = function(player)
    local ringsTaken = mission:getVar(player, 'Rings')
    local currentDay = tonumber(os.date('%j'))
    local lastObtained = mission:getVar(player, 'Obtained')

    if ringsTaken == 0 then
        return mission:progressEvent(84, rings)
    elseif ringsTaken == 1 then -- No Wait for 1st Throw
        return mission:progressEvent(204, rings)
    elseif ringsTaken > 1 and (currentDay - lastObtained) >= 28 then -- 28 Day Wait for New Ring
        return mission:progressEvent(204, rings)
    end
end

local giveRings = function(player, csid, option)
    if option >= 5 and option <= 7 then
        if player:getFreeSlotsCount() == 0 then
            return mission:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, rings[option - 4])
        else
            local ringsTaken = mission:getVar(player, 'Rings')
            mission:setVar(player, 'Rings', ringsTaken + 1)
            mission:setVar(player, 'Obtained', tonumber(os.date('%j')))
            player:addItem(rings[option - 4])
            return mission:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, rings[option - 4])
        end
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.ALTAIEU] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') < 1 then
                        return 167
                    end
                end,
            },

            onEventFinish =
            {
                [167] = function(player, csid, option)
                    mission:setVar(player, 'Status', 1)
                    player:delKeyItem(xi.ki.MYSTERIOUS_AMULET_PRISHE)
                    return player:messageSpecial(zones[player:getZoneID()].text.RETURN_AMULET_TO_PRISHE, xi.ki.MYSTERIOUS_AMULET)
                end,
            },
        },

        [xi.zone.EMPYREAL_PARADOX] =
        {
            ['Transcendental_Radiance'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:progressEvent(2)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option)
                    mission:setVar(player, 'Status', 2)
                end,

                [3] = function(player, csid, option)
                    if mission:getVar(player, 'Status') < 4 then
                        mission:setVar(player, 'Status', 4)
                    end
                end,

                [6] = function(player, csid, option)
                    player:setPos(539, 0, -593, 192)
                    player:addTitle(xi.title.AVERTER_OF_THE_APOCALYPSE)
                    if not player:hasKeyItem(xi.ki.TEAR_OF_ALTANA) then
                        npcUtil.giveKeyItem(player, xi.ki.TEAR_OF_ALTANA)
                    end

                    if mission:getVar(player, 'Status') < 3 then
                        mission:setVar(player, 'Wait', getMidnight())
                        mission:setVar(player, 'Status', 3)
                    end

                    return mission:progressEvent(3)
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {

            ['Cid'] =
            {
                onTrigger = function(player, npc)
                    if
                        mission:getVar(player, 'Status') == 4 and
                        mission:getVar(player, 'Wait') < os.time() and
                        mission:getVar(player, 'TenzenCS') < 1
                    then
                        return mission:progressEvent(897)
                    end
                end,
            },

            onEventFinish =
            {
                [897] = function(player, csid, option)
                    mission:setVar(player, 'TenzenCS', 1)
                end,
            },
        },

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if
                        mission:getVar(player, 'Status') == 4 and
                        mission:getVar(player, 'Wait') < os.time() and
                        mission:getVar(player, 'JabbosCS') < 1
                    then
                        return 57
                    end
                end,
            },

            onEventFinish =
            {
                [57] = function(player, csid, option)
                    mission:setVar(player, 'JabbosCS', 1)
                end,
            },
        },

        [xi.zone.MHAURA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if
                        mission:getVar(player, 'Status') == 4 and
                        mission:getVar(player, 'ShikareesCS') < 1
                    then
                        return 322
                    end
                end,
            },

            onEventFinish =
            {
                [322] = function(player, csid, option)
                    mission:setVar(player, 'ShikareesCS', 1)
                    -- Used for Requiem of Sin Quest
                    player:setCharVar("Quest[4][83]conquestRequiem", getConquestTally())
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hinaree'] =
            {
                onTrigger = function(player, npc)
                    if
                        mission:getVar(player, 'Status') == 4 and
                        mission:getVar(player, 'Wait') < os.time() and
                        mission:getVar(player, 'LouveranceCS') < 1
                    then
                        return mission:progressEvent(757)
                    end
                end,
            },

            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if
                        mission:getVar(player, 'Status') == 4 and
                        mission:getVar(player, 'Wait') < os.time() and
                        mission:getVar(player, 'LouveranceCS') == 2
                    then
                        return mission:progressEvent(758)
                    end
                end,
            },

            onEventFinish =
            {
                [757] = function(player, csid, option)
                    mission:setVar(player, 'LouveranceCS', 3)
                end,

                [758] = function(player, csid, option)
                    mission:setVar(player, 'LouveranceCS', 1)
                end,
            }

        },

        [xi.zone.ULEGUERAND_RANGE] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if
                        mission:getVar(player, 'Status') == 4 and
                        mission:getVar(player, 'Wait') < os.time() and
                        mission:getVar(player, 'LouveranceCS') == 3
                    then
                        return 17
                    end
                end,
            },

            onEventFinish =
            {
                [17] = function(player, npc)
                    mission:setVar(player, 'LouveranceCS', 2)
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Chipmy-Popmy'] =
            {
                onTrigger = function(player, npc)
                    if
                        mission:getVar(player, 'Status') == 4 and
                        mission:getVar(player, 'Wait') < os.time() and
                        mission:getVar(player, 'ChebukkisCS') < 1
                    then
                        return mission:progressEvent(619)
                    end
                end,
            },

            onEventFinish =
            {
                [619] = function(player, npc)
                    mission:setVar(player, 'ChebukkisCS', 2)
                end,
            },
        },

        [xi.zone.BIBIKI_BAY] =
        {
            ['Warmachine'] =
            {
                onTrigger = function(player, npc)
                    local coloredDrop = 4258 + math.random(0, 7)
                    if
                        mission:getVar(player, 'Status') == 4 and
                        mission:getVar(player, 'Wait') < os.time() and
                        mission:getVar(player, 'ChebukkisCS') == 2
                    then
                        if player:getFreeSlotsCount() == 0 then
                            if mission:getVar(player, 'ColoredDrop') < 4258 then
                                mission:setVar(player, 'ColoredDrop', coloredDrop)
                            end

                            return mission:messageSpecial(zones[npc:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, coloredDrop)
                        else
                            if mission:getVar(player, 'ColoredDrop') < 4258 then
                                mission:setVar(player, 'ColoredDrop', coloredDrop)
                            end

                            return mission:progressEvent(43)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [43] = function(player, csid, option)
                    local coloredDrop = mission:getVar(player, 'ColoredDrop')
                    mission:setVar(player, 'ChebukkisCS', 1)
                    mission:setVar(player, 'coloredDrop', 0)
                    player:addItem(coloredDrop)
                    return mission:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, coloredDrop)
                end,
            },
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if mission:getVar(player, 'Status') == 4 and checkAdditionalCS(player) == 5 then
                        return mission:progressEvent(122)
                    end
                end,
            },

            onEventFinish =
            {
                [122] = function(player, csid, option)
                    mission:setVar(player, 'Status', 5)
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['_6s1'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 5 then
                        return mission:progressEvent(129)
                    elseif mission:getVar(player, 'Status') > 5 and not ringCheck(player) then
                        return ringFunction(player)
                    end
                end,
            },

            onEventUpdate =
            {
                [84] = function(player, csid, option)
                    return updateRingEvent(player, csid, option)
                end,

                [204] = function(player, csid, option)
                    return updateRingEvent(player, csid, option)
                end,
            },

            onEventFinish =
            {
                [84] = function(player, csid, option)
                    return giveRings(player, csid, option)
                end,

                [129] = function(player, csid, option)
                    mission:setVar(player, 'Status', 6)
                end,

                [204] = function(player, csid, option)
                    return giveRings(player, csid, option)
                end,
            },
        },

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['_0qa'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 6 then
                        return mission:progressEvent(543)
                    end
                end,
            },

            onEventFinish =
            {
                [543] = function(player, csid, option)
                    mission:setVar(player, 'Status', 7)
                end,
            },
        },

        [xi.zone.LUFAISE_MEADOWS] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if mission:getVar(player, 'Status') == 7 then
                        return mission:progressEvent(116)
                    end
                end,
            },

            onEventFinish =
            {
                [116] = function(player, csid, option)
                    mission:setVar(player, 'Status', 8)
                    return player:addTitle(xi.title.BANISHER_OF_EMPTINESS)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['_6s1'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') > 5 and not ringCheck(player) then
                        return ringFunction(player)
                    end
                end,
            },

            onEventUpdate =
            {
                [84] = function(player, csid, option)
                    return updateRingEvent(player, csid, option)
                end,

                [204] = function(player, csid, option)
                    return updateRingEvent(player, csid, option)
                end,
            },

            onEventFinish =
            {
                [84] = function(player, csid, option)
                    return giveRings(player, csid, option)
                end,

                [129] = function(player, csid, option)
                    mission:setVar(player, 'Status', 6)
                end,

                [204] = function(player, csid, option)
                    return giveRings(player, csid, option)
                end,
            },
        },
    },
}

return mission
