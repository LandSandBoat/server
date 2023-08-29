-----------------------------------
-- When Angels Fall
-- Promathia 8-3
-----------------------------------
-- !addmission 6 828
-- Zone into Garden of Ru'Hmet
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require("scripts/globals/teleports")
require('scripts/globals/titles')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL)

local ebonData =
{
    -- [race] = { xPos1, xPos2, EventID, KI },
    [xi.race.HUME_F] = { 421, 423, 120, xi.ki.LIGHT_OF_VAHZL },
    [xi.race.HUME_M] = { 421, 423, 120, xi.ki.LIGHT_OF_VAHZL },
    [xi.race.ELVAAN_F] = { 739, 741, 121, xi.ki.LIGHT_OF_MEA },
    [xi.race.ELVAAN_M] = { 739, 741, 121, xi.ki.LIGHT_OF_MEA },
    [xi.race.GALKA] = { 576, 578, 122, xi.ki.LIGHT_OF_ALTAIEU },
    [xi.race.TARU_F] = { 256, 258, 123, xi.ki.LIGHT_OF_HOLLA },
    [xi.race.TARU_M] = { 256, 258, 123, xi.ki.LIGHT_OF_HOLLA },
    [xi.race.MITHRA] = { 99, 101, 124, xi.ki.LIGHT_OF_DEM },
}

local ebonOnTrigger = function(player, npc)
    if mission:getVar(player, 'Status') == 1 then
        return mission:progressEvent(202)
    elseif mission:getVar(player, 'Status') == 2 then
        local xPos = npc:getXPos()
        local playerRace = player:getRace()
        for race, val in pairs(ebonData) do
            if playerRace == race and (xPos > val[1] and xPos < val[2]) then
                return mission:progressEvent(120)
            end
        end

        return mission:messageSpecial(zones[npc:getZoneID()].text.NO_NEED_INVESTIGATE)
    else
        return mission:messageSpecial(zones[npc:getZoneID()].text.NO_NEED_INVESTIGATE)
    end
end

local ebonOnEventFinish = function(player, csid, option)
    if option == 1 then
        mission:setVar(player, 'Status', 3)
        player:addTitle(xi.title.WARRIOR_OF_THE_CRYSTAL)
        player:addKeyItem(ebonData[player:getRace()][4])
        return mission:messageSpecial(zones[player:getZoneID()].text.KEYITEM_OBTAINED, ebonData[player:getRace()][4])
    end
end

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.DAWN },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.THE_GARDEN_OF_RUHMET] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') < 1 then
                        return 201
                    end
                end
            },

            ['Ebon_Panel'] = -- Ebon Panels
            {
                onTrigger = function(player, npc)
                    return ebonOnTrigger(player, npc)
                end,
            },

            ['_0zt'] = -- Luminous Convergence
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 5 then
                        return mission:progressEvent(204)
                    end
                end,
            },

            ['_0z0'] = -- BCNM Entrance
            {
                onTrigger = function(player, npc)
                    if
                        mission:getVar(player, 'Status') == 3 and
                        player:hasKeyItem(xi.ki.BRAND_OF_TWILIGHT) and
                        player:hasKeyItem(xi.ki.BRAND_OF_DAWN)
                    then
                        return mission:progressEvent(203)
                    elseif mission:getVar(player, 'Status') == 5 then
                        return mission:progressEvent(205)
                    end
                end,
            },

            ['_0zv'] = -- Particle Gate (Brand of Twilight)
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.BRAND_OF_TWILIGHT) and
                        mission:getVar(player, 'Status') >= 3 and
                        mission:getVar(player, 'Status') <= 4
                    then
                        return mission:progressEvent(111)
                    else
                        return mission:messageSpecial(zones[npc:getZoneID()].text.NO_NEED_INVESTIGATE)
                    end
                end,
            },

            ['_0zu'] = -- Particle Gate (Brand of Dawn)
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.BRAND_OF_DAWN) and
                        mission:getVar(player, 'Status') >= 3 and
                        mission:getVar(player, 'Status') <= 4
                    then
                        return mission:progressEvent(110)
                    else
                        return mission:messageSpecial(zones[npc:getZoneID()].text.NO_NEED_INVESTIGATE)
                    end
                end,
            },

            ['_0zy'] = -- Cermet Portal
            {
                onTrigger = function(player, npc)
                    if player:getZPos() <= 360 then
                        return mission:messageSpecial(zones[npc:getZoneID()].text.PORTAL_SEALED)
                    else
                        return mission:event(139)
                    end
                end,
            },

            onEventFinish =
            {
                [111] = function(player, csid, option)
                    if option == 1 then
                        player:addKeyItem(xi.ki.BRAND_OF_TWILIGHT)
                        return mission:messageSpecial(zones[player:getZoneID()].text.KEYITEM_OBTAINED, xi.ki.BRAND_OF_TWILIGHT)
                    end
                end,

                [110] = function(player, csid, option)
                    if option == 1 then
                        player:addKeyItem(xi.ki.BRAND_OF_DAWN)
                        return mission:messageSpecial(zones[player:getZoneID()].text.KEYITEM_OBTAINED, xi.ki.BRAND_OF_DAWN)
                    end
                end,

                [120] = function(player, csid, option)
                    return ebonOnEventFinish(player, csid, option)
                end,

                [121] = function(player, csid, option)
                    return ebonOnEventFinish(player, csid, option)
                end,

                [122] = function(player, csid, option)
                    return ebonOnEventFinish(player, csid, option)
                end,

                [123] = function(player, csid, option)
                    return ebonOnEventFinish(player, csid, option)
                end,

                [124] = function(player, csid, option)
                    return ebonOnEventFinish(player, csid, option)
                end,

                [201] = function(player, csid, option)
                    mission:setVar(player, 'Status', 1)
                    player:addKeyItem(xi.ki.MYSTERIOUS_AMULET)
                    player:setCharVar("Ru-Hmet-TP", 0)
                    return mission:messageSpecial(zones[player:getZoneID()].text.KEYITEM_OBTAINED, xi.ki.MYSTERIOUS_AMULET)
                end,

                [202] = function(player, csid, option)
                    mission:setVar(player, 'Status', 2)
                end,

                [203] = function(player, csid, option)
                    mission:setVar(player, 'Status', 4)
                end,

                [204] = function(player, csid, option)
                    mission:complete(player)
                end,

                [32001] = function(player, csid, option)
                    if mission:getVar(player, 'Status') == 4 then
                        mission:setVar(player, 'Status', 5)
                    end
                end
            }
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.THE_GARDEN_OF_RUHMET] =
        {
            ['_0zs'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(112)
                end,
            },

            ['_0zy'] = -- Cermet Portal
            {
                onTrigger = function(player, npc)
                    if player:getZPos() <= 360 then
                        return mission:event(140)
                    else
                        return mission:event(141)
                    end
                end,
            },

            ['Ebon_Panel'] = -- Ebon Panels
            {
                onTrigger = function(player, npc)
                    return mission:messageSpecial(zones[npc:getZoneID()].text.NO_NEED_INVESTIGATE)
                end,
            },

            ['_0zv'] = -- Particle Gate (Brand of Twilight)
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.BRAND_OF_TWILIGHT) then
                        return mission:progressEvent(111)
                    else
                        return mission:messageSpecial(zones[npc:getZoneID()].text.NO_NEED_INVESTIGATE)
                    end
                end,
            },

            ['_0zu'] = -- Particle Gate (Brand of Dawn)
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.BRAND_OF_DAWN) then
                        return mission:progressEvent(110)
                    else
                        return mission:messageSpecial(zones[npc:getZoneID()].text.NO_NEED_INVESTIGATE)
                    end
                end,
            },

            ['_0zt'] = -- Luminous Convergence
            {
                onTrigger = function(player, npc)
                    return mission:messageSpecial(zones[npc:getZoneID()].text.NO_NEED_INVESTIGATE)
                end,
            },

            onEventFinish =
            {
                [111] = function(player, csid, option)
                    if option == 1 then
                        player:addKeyItem(xi.ki.BRAND_OF_TWILIGHT)
                        return mission:messageSpecial(zones[player:getZoneID()].text.KEYITEM_OBTAINED, xi.ki.BRAND_OF_TWILIGHT)
                    end
                end,

                [110] = function(player, csid, option)
                    if option == 1 then
                        player:addKeyItem(xi.ki.BRAND_OF_DAWN)
                        return mission:messageSpecial(zones[player:getZoneID()].text.KEYITEM_OBTAINED, xi.ki.BRAND_OF_DAWN)
                    end
                end,

                [112] = function(player, csid, option)
                    if option == 1 then
                        player:setPos(-20, 0, -355, 192, xi.zone.GRAND_PALACE_OF_HUXZOI)
                    end
                end,
            },
        },

    },
}

return mission
