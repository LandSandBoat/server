-----------------------------------
-- When Angels Fall
-- Promathia 8-3
-----------------------------------
-- !addmission 6 828
-- Gate of the god : !pos -20 0.1 -283 34
-- Hume Tower : !pos 422.351 -5.180 -100.000 35
-- Mithra Tower : !pos 100.000 -5.180 -337.661 35
-- Elvaan Tower : !pos 740.000 -5.180 -342.352 35
-- Tarutaru Tower : !pos 257.650 -5.180 -699.999 35
-- Galka Tower : !pos 577.648 -5.180 -700.000 35
-- Central Teleport : !pos -420 0 -366 35
-- Brand of dawn : !pos -420 0 -283 35
-- Brand of twilight : !pos -420 0 -557 35
-- Luminous Convergence : !pos 420 -0.6 518 35
-----------------------------------
require('scripts/globals/bcnm')
require('scripts/globals/interaction/mission')
require('scripts/globals/npc_util')
require('scripts/globals/missions')
require('scripts/globals/status')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
local AlTaieuID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.DAWN },
}

local towerByNpcId = {
    [ID.npc.EBON_PANEL_HUME] = {
        checkRace = function(playerRace)
            return playerRace == xi.race.HUME_M or playerRace == xi.race.HUME_F
        end,
        eventId = 120
    },

    [ID.npc.EBON_PANEL_ELVAAN] = {
        checkRace = function(playerRace)
            return playerRace == xi.race.ELVAAN_M or playerRace == xi.race.ELVAAN_F
        end,
        eventId = 121
    },

    [ID.npc.EBON_PANEL_GALKA] = {
        checkRace = function(playerRace)
            return playerRace == xi.race.GALKA
        end,
        eventId = 122
    },

    [ID.npc.EBON_PANEL_TARU] = {
        checkRace = function(playerRace)
            return playerRace == xi.race.TARU_M or playerRace == xi.race.TARU_F
        end,
        eventId = 123
    },

    [ID.npc.EBON_PANEL_MITHRA] = {
        checkRace = function(playerRace)
            return playerRace == xi.race.MITHRA
        end,
        eventId = 124
    },
}

local function onTriggerEbonPanel(player, npc)
    if mission:getVar(player, 'Status') == 1 then
        return mission:progressEvent(202)
    elseif mission:getVar(player, 'Status') == 2 then
        local playerRace = player:getRace()
        local tower = towerByNpcId[npc:getID()]
        if tower and tower.checkRace(playerRace) then
            return mission:progressEvent(tower.eventId)
        else
            return player:messageSpecial(ID.text.NO_NEED_INVESTIGATE)
        end
    else
        return player:messageSpecial(ID.text.NO_NEED_INVESTIGATE)
    end
end

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
                    if mission:getVar(player, 'Status') == 0 then
                        return 201
                    end
                end,
            },

            ['_iz2'] = {
                onTrigger = function(player, npc)
                    onTriggerEbonPanel(player, npc)
                end,
            },

            ['_0zu'] = {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.BRAND_OF_DAWN) then
                        return mission:progressEvent(110)
                    end
                end,
            },

            ['_0zv'] = {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.BRAND_OF_TWILIGHT) then
                        return mission:progressEvent(111)
                    end
                end,
            },

            ['_0z0'] = {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 4 then
                        return mission:progressEvent(203)
                    end
                end,
            },

            ['_0zt'] = {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 6 then
                        return mission:progressEvent(204)
                    end
                end,
            },

            ['Ebon_Panel'] =
            {
                onTrigger = function(player, npc)
                    onTriggerEbonPanel(player, npc)
                end,
            },

            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == 1024 and
                        mission:getVar(player, 'Status') == 5
                    then
                        mission:setVar(player, 'Status', 6)
                    end
                end,

                [110] = function(player, csid, option,npc) -- BRAND_OF_DAWN
                    if option == 1 then
                        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BRAND_OF_DAWN)
                        player:addKeyItem(xi.ki.BRAND_OF_DAWN)
                        if player:hasKeyItem(xi.ki.BRAND_OF_TWILIGHT) then
                            mission:setVar(player, 'Status', 4)
                        end
                    end
                end,

                [111] = function(player, csid, option,npc) -- BRAND_OF_TWILIGHT
                    if option == 1 then
                        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BRAND_OF_TWILIGHT)
                        player:addKeyItem(xi.ki.BRAND_OF_TWILIGHT)
                        if player:hasKeyItem(xi.ki.BRAND_OF_DAWN) then
                            mission:setVar(player, 'Status', 4)
                        end
                    end
                end,

                [120] = function(player, csid, option,npc) -- HUME
                    mission:setVar(player, 'Status', 3)
                    player:addTitle(xi.title.WARRIOR_OF_THE_CRYSTAL)
                    player:addKeyItem(xi.ki.LIGHT_OF_VAHZL)
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIGHT_OF_VAHZL)
                end,

                [121] = function(player, csid, option,npc) -- ELVAAN
                    mission:setVar(player, 'Status', 3)
                    player:addTitle(xi.title.WARRIOR_OF_THE_CRYSTAL)
                    player:addKeyItem(xi.ki.LIGHT_OF_MEA)
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIGHT_OF_MEA)
                end,

                [122] = function(player, csid, option,npc) -- GALKA
                    mission:setVar(player, 'Status', 3)
                    player:addTitle(xi.title.WARRIOR_OF_THE_CRYSTAL)
                    player:addKeyItem(xi.ki.LIGHT_OF_ALTAIEU)
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIGHT_OF_ALTAIEU)
                end,

                [123] = function(player, csid, option,npc) -- TARUTARU
                    mission:setVar(player, 'Status', 3)
                    player:addTitle(xi.title.WARRIOR_OF_THE_CRYSTAL)
                    player:addKeyItem(xi.ki.LIGHT_OF_HOLLA)
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIGHT_OF_HOLLA)
                end,

                [124] = function(player, csid, option,npc) -- MITHRA
                    mission:setVar(player, 'Status', 3)
                    player:addTitle(xi.title.WARRIOR_OF_THE_CRYSTAL)
                    player:addKeyItem(xi.ki.LIGHT_OF_DEM)
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIGHT_OF_DEM)
                end,

                [201] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                    player:addKeyItem(xi.ki.MYSTERIOUS_AMULET_PRISHE)
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MYSTERIOUS_AMULET)
                end,

                [202] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                end,

                [203] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 5)
                end,

                [204] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 7)
                end,
            },
        },

        [xi.zone.ALTAIEU] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 7 then
                        return 167
                    end
                    return -1
                end,
            },

            onEventFinish =
            {
                [167] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MYSTERIOUS_AMULET_PRISHE)
                    player:messageSpecial(AlTaieuID.text.RETURN_AMULET_TO_PRISHE, xi.ki.MYSTERIOUS_AMULET)
                    mission:complete(player)
                end,
            }
        }
    }
}

return mission
