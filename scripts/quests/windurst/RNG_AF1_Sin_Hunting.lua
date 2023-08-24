-----------------------------------
-- Sin Hunting (RNG AF1)
-----------------------------------
-- Log ID: 2, Quest ID: 72
-- Perih Vashai: !pos 117 -3 92 241
-- Perchond: !pos -182.844 4 -164.948 166
-- Alexis: !pos 105 1 382 104
-- qm2: !pos -10.946 -1.000 313.810 104
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Ranguemont_Pass/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SIN_HUNTING)

quest.reward =
{
    item     = xi.items.SNIPING_BOW,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL and
            player:getMainJob() == xi.job.RNG
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] = quest:progressEvent(523),

            onEventFinish =
            {
                [523] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                    npcUtil.giveKeyItem(player, xi.ki.CHIEFTAINNESSS_TWINSTONE_EARRING)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') <= 4 then
                        return quest:event(524)
                    else
                        return quest:progressEvent(527)
                    end
                end,
            },

            onEventFinish =
            {
                [527] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.PERCHONDS_ENVELOPE)
                    end
                end,
            },
        },

        [xi.zone.RANGUEMONT_PASS] =
        {
            ['Perchond'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(3, 0, xi.items.GLITTERSAND)
                    else
                        return quest:event(2)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.GLITTERSAND) and
                        quest:getVar(player, 'Prog') == 2
                    then
                        return quest:progressEvent(5)
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [5] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'Prog', 3)
                    npcUtil.giveKeyItem(player, xi.ki.PERCHONDS_ENVELOPE)
                end,
            },
        },

        [xi.zone.JUGNER_FOREST] =
        {
            ['Alexius'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(10)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:event(11)
                    elseif quest:getVar(player, 'Prog') == 5 then
                        return quest:event(12)
                    end
                end,
            },

            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 4 and
                        IsMoonFull()
                    then
                        return quest:progressEvent(13, 0, xi.items.GLITTERSAND)
                    end
                end,
            },

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [13] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },
    },
}

return quest
