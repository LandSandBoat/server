-----------------------------------
-- Dawn
-- Promathia 8-4
-----------------------------------
-- !addmission 6 840
-- Transcendental Radiance : !pos 540 0 -594 36
-- Hinaree : !pos -301.535 -10.199 97.698 230
-- Chipmy-Popmy : !pos -183.4 -3 72 240
-- ??? Warmachine : !pos -345.236 -3.188 -976.563 4
-- Cid : !pos -12 -12 1 237
-- Marble bridge : !pos -96.6 -0.2 92.3 244
-- Walnutt door : !pos 111 -41 41 26
-----------------------------------
require('scripts/globals/bcnm')
require('scripts/globals/interaction/mission')
require('scripts/globals/missions')
require('scripts/globals/keyitems')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and mission:getVar(player, 'Status') < 2
        end,

        [xi.zone.EMPYREAL_PARADOX] =
        {
            ['Transcendental_Radiance'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(2)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,

                [3] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == 1056 and
                        mission:getVar(player, 'Status') == 1
                    then
                        mission:setVar(player, 'Status', 2)
                        mission:setVar(player, 'PromKillDay', getMidnight())
                        local empyrealParadoxID = require('scripts/zones/Empyreal_Paradox/IDs')
                        if not player:hasKeyItem(xi.ki.TEAR_OF_ALTANA) then
                            player:addKeyItem(xi.ki.TEAR_OF_ALTANA)
                            player:messageSpecial(empyrealParadoxID.text.KEYITEM_OBTAINED, xi.ki.TEAR_OF_ALTANA)
                            player:setPos(0, -10, -470, 64, xi.zone.ALTAIEU)
                        end
                    end
                end,
            },
        }
    },
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and mission:getVar(player, 'Status') > 1 and mission:getVar(player, "PromKillDay") < os.time()
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Hinaree'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Louverance') == 0 then
                        return mission:progressEvent(757)
                    end
                end,
            },

            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if mission:getVar(player, 'Louverance') == 2 then
                        return mission:progressEvent(758)
                    end
                end,
            },

            onEventFinish =
            {
                [757] = function(player, csid, option, npc)
                    mission:setVar(player, 'Louverance', 1)
                end,

                [758] = function(player, csid, option, npc)
                    mission:setVar(player, 'Louverance', 3)
                    local missionStatus = mission:getVar(player, 'Status')
                    mission:setVar(player, 'Status', missionStatus + 1)
                end,
            },
        },
        [xi.zone.ULEGUERAND_RANGE] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Louverance') == 1 then
                        return 17
                    end
                end,
            },

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    mission:setVar(player, 'Louverance', 2)
                end,
            },
        },
        [xi.zone.PORT_WINDURST] =
        {
            ['Chipmy-Popmy'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Chebukkis') == 0 then
                        return mission:progressEvent(619)
                    end
                end,
            },

            onEventFinish =
            {
                [619] = function(player, csid, option, npc)
                    mission:setVar(player, 'Chebukkis', 1)
                end,
            },
        },

        [xi.zone.BIBIKI_BAY] =
        {
            ['Warmachine'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Chebukkis') == 1 then
                        return mission:progressEvent(43)
                    end
                end,
            },

            onEventFinish =
            {
                [43] = function(player, csid, option, npc)
                    local IDBibikyBay = require("scripts/zones/Bibiki_Bay/IDs")
                    local coloredDrop = 4258 + math.random(0, 7)
                    if player:getFreeSlotsCount() == 0 then
                        player:messageSpecial(IDBibikyBay.text.ITEM_CANNOT_BE_OBTAINED, coloredDrop)
                    else
                        player:addItem(coloredDrop)
                        player:messageSpecial(IDBibikyBay.text.ITEM_OBTAINED, coloredDrop)
                        mission:setVar(player, 'Chebukkis', 2)
                        local missionStatus = mission:getVar(player, 'Status')
                        mission:setVar(player, 'Status', missionStatus + 1)
                    end
                end,
            },
        },

        [xi.zone.MHAURA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Shikarees') == 0 then
                        return 322
                    end
                end,
            },
            onEventFinish =
            {
                [322] = function(player, csid, option, npc)
                    mission:setVar(player, 'Shikarees', 1)
                    local missionStatus = mission:getVar(player, 'Status')
                    mission:setVar(player, 'Status', missionStatus + 1)
                end,
            },
        },

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Jabbos') == 0 then
                        return 57
                    end
                end,
            },
            onEventFinish =
            {
                [57] = function(player, csid, option, npc)
                    mission:setVar(player, 'Jabbos', 1)
                    local missionStatus = mission:getVar(player, 'Status')
                    mission:setVar(player, 'Status', missionStatus + 1)
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Tenzen') == 0 then
                        return mission:progressEvent(897)
                    end
                end,
            },

            onEventFinish =
            {
                [897] = function(player, csid, option, npc)
                    mission:setVar(player, 'Tenzen', 1)
                    local missionStatus = mission:getVar(player, 'Status')
                    mission:setVar(player, 'Status', missionStatus + 1)
                end,
            },
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if mission:getVar(player, 'Status') == 7 then
                        return mission:progressEvent(122)
                    end
                end,
            },

            onEventFinish =
            {
                [122] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 8)
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['_6s1'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 8 then
                        return mission:progressEvent(129)
                    end
                end,
            },

            onEventFinish =
            {
                [129] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 9)
                end,
            },
        },

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['_0qa'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 9 then
                        return mission:progressEvent(543)
                    end
                end,
            },

            onEventFinish =
            {
                [543] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 10)
                end,
            },
        },

        [xi.zone.LUFAISE_MEADOWS] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if mission:getVar(player, 'Status') == 10 then
                        return mission:progressEvent(116)
                    end
                end,
            },

            onEventFinish =
            {
                [116] = function(player, csid, option, npc)
                    player:addTitle(xi.title.BANISHER_OF_EMPTINESS)
                    mission:setVar(player, 'Status', 11)
                end,
            },
        },
    },
}

return mission
