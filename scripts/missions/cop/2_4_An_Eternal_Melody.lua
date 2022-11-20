-----------------------------------
-- An Eternal Melody
-- Promathia 2-4
-----------------------------------
-- !addmission 6 238
-- Walnut Door      : !pos 111 -41 41 26
-- Justinius        : !pos 76 -34 68 26
-- Dilapidated Gate : !pos 260 9 -435 25
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.AN_ETERNAL_MELODY)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['_0qa'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(104)
                    end
                end,
            },

            ['Justinius'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:event(127):replaceDefault()
                    else
                        return mission:event(125):replaceDefault()
                    end
                end,
            },

            ['Parelbriaux'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:event(126):replaceDefault()
                    end
                end,
            },

            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if mission:getVar(player, 'Status') == 2 then
                        return mission:progressEvent(105)
                    end
                end,
            },

            onEventFinish =
            {
                [104] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.MYSTERIOUS_AMULET)
                    mission:setVar(player, 'Status', 1)
                end,

                [105] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.MISAREAUX_COAST] =
        {
            ['_0p0'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:event(5)
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                end,
            },
        },
    },
}

return mission
