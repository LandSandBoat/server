-----------------------------------
-- The Puppet Master
-----------------------------------
-- Log ID: 2, Quest ID: 81
-- House of the Hero (_6n2) : !pos -26 -13 260 239
-- Juroro                   : !pos 32 7 -41 236
-- Koru-Moru                : !pos -120 -6 124 239
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PUPPET_MASTER)

quest.reward =
{
    fame     = 20,
    fameArea = xi.quest.fame_area.WINDURST,
    item     = xi.items.KUKULCANS_STAFF,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL and
                player:getMainJob() == xi.job.SMN and
                not quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['_6n2'] = quest:progressEvent(402),

            onEventFinish =
            {
                [402] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['_6n2'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(403)
                    end
                end,
            },

            ['Koru-Moru'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(404)
                    end
                end,
            },

            onEventFinish =
            {
                [404] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        xi.quest.setMustZone(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.CLASS_REUNION)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Juroro'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(256, 0, 329, 0, xi.items.EARTH_PENDULUM)
                    elseif
                        questProgress == 1 and
                        not player:hasItem(xi.items.EARTH_PENDULUM)
                    then
                        return quest:progressEvent(257, 0, xi.items.EARTH_PENDULUM)
                    elseif questProgress == 2 then
                        return quest:progressEvent(258)
                    end
                end,
            },

            onEventFinish =
            {
                [256] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.items.EARTH_PENDULUM) then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [257] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.items.EARTH_PENDULUM)
                end,

                [258] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.CLOISTER_OF_TREMORS] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == 577 and
                        quest:getVar(player, 'Prog') == 1
                    then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                not player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CLASS_REUNION)
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Koru-Moru'] = quest:event(405):replaceDefault(),
        },
    },
}

return quest
