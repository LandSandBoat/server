-----------------------------------
-- Flavors of Our Lives (Flavors_of_Our_Lives)
-- https://www.bg-wiki.com/ffxi/Flavors_of_Our_Lives
-----------------------------------
-- Berghent         : !pos 95.721 -0.148 -28.680 256
-- Masad            : !pos -28.182 -0.650 -91.991 256
-- Dewalt           : !pos -23.099 -0.648 28.208 256
-- Chalvava         : !pos -318.000 -1.000 -318.000 258
-- Harvesting Point : !pos 196.000 0.001 289.500 260
-- Sickle           : !additem 1020
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/quests')
require("scripts/globals/helm")
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/status')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.FLAVORS_OF_OUR_LIVES)

quest.reward =
{
    xp    = 500,
    bayld = 300,
    title = xi.title.POTATION_PATHFINDER,
}

quest.sections =
{
    -- Section: Talk to Berghent near the Big Bridge in Western Adoulin (J-9) to start the quest.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Berghent'] =
            {
                onTrigger = function(player, npc)
                    if player:getLocalVar("Flavors_of_Our_Lives_Refused") == 1 then
                        return quest:progressEvent(81)
                    else
                        return quest:progressEvent(80)
                    end
                end,
            },

            onEventFinish =
            {
                [80] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    else -- Refused
                        player:setLocalVar("Flavors_of_Our_Lives_Refused", 1)
                    end
                end,

                [81] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Talk to Masad inside the Mummers' Coalition.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 0
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Berghent'] = quest:event(82), -- Reminder
            ['Masad'] = quest:progressEvent(83),

            onEventFinish =
            {
                [83] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Section: Talk to Dewalt inside the Couriers' Coalition.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Berghent'] = quest:event(82), -- Reminder
            ['Dewalt'] = quest:progressEvent(85),

            onEventFinish =
            {
                [85] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- Section: Head to Rala Waterways and talk to Chalvava at (F-11).
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 2
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Berghent'] = quest:event(82), -- Reminder
            ['Dewalt'] = quest:event(105), -- Reminder
        },

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Chalvava'] = quest:progressEvent(8),

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },

    -- Section: Go to Yahse Hunting Grounds and harvest a Key Item Blightberry using a Sickle
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 3 and not player:hasKeyItem(xi.ki.BLIGHTBERRY)
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Berghent'] = quest:event(82), -- Reminder
            ['Dewalt'] = quest:event(105), -- Reminder
        },

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Chalvava'] = quest:event(9) -- Reminder
        },

        [xi.zone.YAHSE_HUNTING_GROUNDS] =
        {
            ['Harvesting_Point'] =
            {
                onTrade = function(player, npc, trade)
                    -- TODO: CSID for YAHSE_HUNTING_GROUNDS
                    xi.helm.onTrade(player, npc, trade, xi.helm.type.HARVESTING, nil, nil)
                    return quest:keyItem(xi.ki.BLIGHTBERRY)
                end,
            },
        },
    },

    -- Section: Return to Berghent for your reward
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 3 and player:hasKeyItem(xi.ki.BLIGHTBERRY)
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Berghent'] = quest:progressEvent(87),

            onEventFinish =
            {
                [87] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },

    -- New default text
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Berghent'] = quest:event(88),
        },
    },
}

return quest
