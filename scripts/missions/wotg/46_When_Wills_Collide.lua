-----------------------------------
-- When Wills Collide
-- Wings of the Goddess Mission 46
-----------------------------------
-- !addmission 5 45
-- Veridical Conflux : !pos -142.279 -6.749 585.239 89
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.WHEN_WILLS_COLLIDE)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.WHISPERS_OF_DAWN },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.GRAUBERG_S] =
        {
            ['Veridical_Conflux'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        not player:hasKeyItem(xi.ki.BOTTLED_PUNCH_BUG) and
                        npcUtil.tradeHasExactly(trade, xi.items.PUNCH_BUG)
                    then
                        return mission:progressEvent(42, 76, 0, 1267351, 120, 0, 8323092, 0, 0)
                    end
                end,

                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.BOTTLED_PUNCH_BUG) then
                        return mission:event(29, 89, 6)
                    else
                        return mission:event(41, 89, 23, 1756)
                    end
                end,
            },

            onEventFinish =
            {
                [29] = function(player, csid, option, npc)
                    if option == 99 then
                        player:setPos(-700.042, 0.4, -441.301, 192, xi.zone.WALK_OF_ECHOES)
                    end
                end,

                [42] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.BOTTLED_PUNCH_BUG)
                end,
            },
        },

        [xi.zone.WALK_OF_ECHOES] =
        {
            ['_521'] =
            {
                onTrigger = function(player, npc)
                    -- NOTE: BCNM Entry Event: 32000, Params 0, 300, 200, 1 following
                    -- the status 0 event below.  Status of 1, along with the Bottled
                    -- Punch Bug KI is required, and KI is lost on entry.

                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(1)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 2 then
                        return 2
                    end
                end,
            },

            onEventUpdate =
            {
                [1] = function(player, csid, option, npc)
                    if option == 5 then
                        player:updateEvent(12, 10, 305, 196, 320, 847, 450, 1)
                    end
                end,

                [2] = function(player, csid, option, npc)
                    if option == 5 then
                        player:updateEvent(119, 10, 305, 196, 320, 847, 450, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,

                [2] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [32001] = function(player, csid, option, npc)
                    -- TODO: Add battlefieldWin localVar, and check here once the ID has been
                    -- implemented.

                    mission:setVar(player, 'Status', 2)
                    player:setPos(-700.063, -17.6, -331.903, 64, xi.zone.WALK_OF_ECHOES)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.GRAUBERG_S] =
        {
            ['Veridical_Conflux'] = mission:event(29, 89, 12354, 59449, 120, 0, 8323089, 0, 0),

            onEventFinish =
            {
                [29] = function(player, csid, option, npc)
                    if option == 99 then
                        player:setPos(-700.042, 0.4, -441.301, 192, xi.zone.WALK_OF_ECHOES)
                    end
                end,
            },
        },
    },
}

return mission
