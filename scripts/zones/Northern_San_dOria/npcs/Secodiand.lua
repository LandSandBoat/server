-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Secodiand
-- Starts and Finishes Quest: Fear of the dark
-- !pos -160 -0 137 231
-----------------------------------
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FEAR_OF_THE_DARK) ~= QUEST_AVAILABLE then
        if trade:hasItemQty(922, 2) and trade:getItemCount() == 2 then
            player:startEvent(18)
        end
    end
end

entity.onTrigger = function(player, npc)
    local fearOfTheDark = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FEAR_OF_THE_DARK)

    if fearOfTheDark == QUEST_AVAILABLE then
        player:startEvent(19)
    else
        player:startEvent(17)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 19 and option == 1 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FEAR_OF_THE_DARK)
    elseif csid == 18 then
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 200)
        if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FEAR_OF_THE_DARK) == QUEST_ACCEPTED then
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FEAR_OF_THE_DARK)
        else
            player:addFame(xi.quest.fame_area.SANDORIA, 5)
        end
    end
end

return entity
