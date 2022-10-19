-----------------------------------
-- Area: East Ronfaure
--  NPC: Andelain
-- Type: Standard NPC
-- !pos 664.231 -12.849 -539.413 101
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------
local ID = require("scripts/zones/East_Ronfaure/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local sermonQuest = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_VICASQUE_S_SERMON)

    if sermonQuest == QUEST_ACCEPTED then
        local count = trade:getItemCount()
        local bluePeas = trade:getItemQty(618)
        if bluePeas == 1 and count == 1 and player:getCharVar("sermonQuestVar") == 0 then
            player:tradeComplete()
            player:setCharVar("sermonQuestVar", 1)
            player:showText(npc, ID.text.THANKS_TO_GODDESS)
            player:startEvent(19)
        elseif bluePeas > 1 and count == bluePeas then
            player:showText(npc, ID.text.ONLY_NEED_ONE, xi.items.BLUE_PEAS)
        else
            player:showText(npc, ID.text.CANNOT_ACCEPT_THIS)
        end
    else
        player:showText(npc, ID.text.CANNOT_ACCEPT_THIS)
        player:startEvent(19)
    end
end

entity.onTrigger = function(player, npc)
    local sermonQuest = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_VICASQUE_S_SERMON)

    if sermonQuest == QUEST_ACCEPTED and player:getCharVar("sermonQuestVar") == 0 then
        player:showText(npc, ID.text.NO_MORE_NO_LESS, xi.items.BLUE_PEAS)
    elseif player:getCharVar("sermonQuestVar") == 1 then
        player:showText(npc, ID.text.THANKS_TO_GODDESS)
        player:startEvent(19)
    else
        player:showText(npc, ID.text.NAME_IS_ANDELAIN)
        player:startEvent(19)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 19 then
        player:showText(npc, ID.text.GATES_OF_PARADISE)
    end
end

return entity
