-----------------------------------
-- A_Taste_of_Honey
-- Qutiba !pos 92 -7.5 -130 50
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.A_TASTE_OF_HONEY)

quest.reward = {
    item = xi.items.IRMIK_HELVASI
}

quest.sections = {

    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.VANISHING_ACT) == QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Qutiba'] = {
                onTrigger = function(player, npc)
                    if player:needToZone() or quest:getVar(player, 'Stage') > os.time() then
                        return quest:progressEvent(55)
                    else
                        return quest:progressEvent(579)
                    end
                end,
            },
            ['Fochacha'] = {
                onTrigger = function(player, npc)
                    return quest:event(50)
                end,
            },

            onEventFinish = {
                [579] = function(player, csid, option, npc)
                    quest:setVar(player, 'Stage', 0)
                    quest:begin(player)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Qutiba'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(585)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, {{xi.items.POT_OF_WHITE_HONEY, 3}}) then
                        return quest:progressEvent(580)
                    end
                end,
            },

            onEventFinish = {
                [580] = function(player, csid, option, npc)
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

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Qutiba'] = {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, {xi.items.POT_OF_WHITE_HONEY}) then
                        return quest:progressEvent(581)
                    end
                end,

                onTrigger = function(player, npc)
                    player:setLocalVar("recipe", 57)
                    return quest:event(57)
                end,
            },

            onEventUpdate = {
                [57] = function(player, csid, option, npc)
                    if player:getLocalVar("recipe") == 57 then
                        player:setLocalVar("recipe", 1)
                        player:updateEvent(5579, 1, 255, 0, 67108863, 5976652, 4095, 0)
                        return
                    elseif player:getLocalVar("recipe") == 1 then
                        player:setLocalVar("recipe", 2)
                        player:updateEvent(4096, 615, 936, 1523, 67108863, 5976652, 4, 0)
                        return
                    elseif player:getLocalVar("recipe") == 2 then
                        player:setLocalVar("recipe", 3)
                        player:updateEvent(2214, 2237, 4509, 5568)
                       return
                    elseif player:getLocalVar("recipe") == 3 then
                        player:setLocalVar("recipe", 0)
                        player:updateEvent(5575)
                       return
                    end
                end,
            },
        },
    },
}


return quest
