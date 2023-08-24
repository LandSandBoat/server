-----------------------------------
-- Unbridled Passion (RNG AF3)
-----------------------------------
-- Log ID: 2, Quest ID: 74
-- Perih Vashai: !pos 117 -3 92 241
-- Koh Lenbalalako: !pos -64.412 -17 29.213 249
-- qm7: !pos -295.065 -25.054 151.250 112
-- qm6: !pos -254.883 -17.003 -150.818 112
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Xarcabard/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.UNBRIDLED_PASSION)

quest.reward =
{
    item     = xi.items.HUNTERS_SOCKS,
    title    = xi.title.PARAGON_OF_RANGER_EXCELLENCE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL and
            player:getMainJob() == xi.job.RNG and
            player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.FIRE_AND_BRIMSTONE) and
            not player:needToZone()
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] = quest:progressEvent(541, 0, xi.items.TWINSTONE_EARRING),

            onEventFinish =
            {
                [541] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
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
                    if quest:getVar(player, 'Prog') > 0 and quest:getVar(player, 'Prog') < 3 then
                        return quest:event(542)-- during RNG AF3
                    elseif quest:getVar(player, 'Prog') < 7 then
                        return quest:event(542)-- during RNG AF3
                    elseif quest:getVar(player, 'Prog') == 7 then
                        return quest:progressEvent(546, 0, xi.items.HUNTERS_SOCKS) -- complete RNG AF3
                    end
                end,
            },

            onEventFinish =
            {
                [546] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.MHAURA] =
        {
            ['Koh_Lenbalalako'] = -- defaultActions
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(10009, 0, xi.items.TWINSTONE_EARRING, xi.items.GOLD_EARRING)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:event(10010, 0, 0, xi.items.GOLD_EARRING)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:event(10012)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.GOLD_EARRING) and
                        quest:getVar(player, 'Prog') == 2
                    then
                        return quest:progressEvent(10011)
                    end
                end,
            },

            onEventFinish =
            {
                [10009] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [10011] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    npcUtil.giveKeyItem(player, xi.ki.KOHS_LETTER)
                    player:tradeComplete()
                end,
            },
        },

        [xi.zone.XARCABARD] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 3 then
                        return 4
                    end
                end,
            },

            ['qm6'] = -- defaultActions TODO -
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(6, 0, xi.items.TWINSTONE_EARRING)
                    elseif quest:getVar(player, 'Prog') == 6 then
                        return quest:progressEvent(7)
                    end
                end,
            },

            ['qm7'] = -- defaultActions TODO -
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:event(8)
                    end
                end,
            },

            ['Koenigstiger'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 4 then
                        quest:setVar(player, 'Prog', 5)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [6] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,

                [7] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, { { xi.items.ICE_ARROW, 99 } })
                    quest:setVar(player, 'Prog', 7)
                end,

                [8] = function(player, csid, option, npc)
                    npcUtil.popFromQM(player, npc, ID.mob.KOENIGSTIGER, { claim = true, hide = 0 })
                end,
            },
        },
    },
}

return quest
