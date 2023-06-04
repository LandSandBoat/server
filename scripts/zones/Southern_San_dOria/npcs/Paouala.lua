-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Paouala
-- Starts and Finishes Quest: Sleepless Nights
-- !pos 158 -6 17 230
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SLEEPLESS_NIGHTS) == QUEST_ACCEPTED then
        if trade:hasItemQty(4527, 1) and trade:getItemCount() == 1 then
            player:startEvent(84)
        end
    end
end

entity.onTrigger = function(player, npc)
    local sleeplessNights = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SLEEPLESS_NIGHTS)

    if
        player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 2 and
        sleeplessNights == QUEST_AVAILABLE
    then
        player:startEvent(85)
    elseif sleeplessNights == QUEST_ACCEPTED then
        player:startEvent(83)
    elseif sleeplessNights == QUEST_COMPLETED then
        player:startEvent(81)
    else
        player:startEvent(82)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 85 and option == 1 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SLEEPLESS_NIGHTS)
    elseif csid == 84 then
        player:tradeComplete()
        player:addTitle(xi.title.SHEEPS_MILK_DELIVERER)
        npcUtil.giveCurrency(player, 'gil', 5000)
        player:addFame(xi.quest.fame_area.SANDORIA, 30)
        player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SLEEPLESS_NIGHTS)
    end
end

return entity
