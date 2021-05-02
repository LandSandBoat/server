-----------------------------------
-- Fear of the Dark 2
-- Suldiran !pos 42 -7 -43 48
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
require('scripts/globals/interaction/quest')
require("scripts/globals/titles")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.FEAR_OF_THE_DARK_II)

quest.reward = {
    gil = 200,
    title = xi.title.DARK_RESISTANT,
}

quest.sections = {

    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.AL_ZAHBI] = {
            ['Suldiran'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(14)
                end,
            },

            onEventFinish = {
                [14] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AL_ZAHBI] = {
            ['Suldiran'] = {
                onTrigger = function(player, npc)
                    return quest:event(15)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, {{xi.items.IMP_WING, 2}}) then
                        return quest:progressEvent(16)
                    end
                end,
            },

            onEventFinish = {
                [16] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:complete(player)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.AL_ZAHBI] = {
            ['Suldiran'] = {
                onTrigger = function(player, npc)
                    return quest:event(17)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, {{xi.items.IMP_WING, 2}}) then
                        return quest:progressEvent(18)
                    end
                end,
            },

            onEventFinish = {
                [18] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveGil(player, 200)
                end,
            },
        },
    },
}


return quest
