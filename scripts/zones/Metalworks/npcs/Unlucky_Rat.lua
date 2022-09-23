-----------------------------------
-- Area: Metalworks
--  NPC: Unlucky Rat
-- Starts & Finishes Quest: Mean Machine
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Metalworks/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.MEAN_MACHINE) == QUEST_ACCEPTED then
        if player:getFreeSlotsCount() >= 1 then
            local count = trade:getItemCount()
            local slimeOil = trade:hasItemQty(637, 1)

            if slimeOil == true and count == 1 then
                player:startEvent(557)
            end
        else
            player:messageSpecial(ID.text.FULL_INVENTORY_AFTER_TRADE, 4731)
        end
    end
end

entity.onTrigger = function(player, npc)
    local meanMachine = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.MEAN_MACHINE)
    local fameLevel   = player:getFameLevel(xi.quest.fame_area.BASTOK)

    if meanMachine == QUEST_AVAILABLE and fameLevel >= 2 then
        player:startEvent(556)
    elseif meanMachine == QUEST_ACCEPTED then
        player:startEvent(559)
    else
        player:startEvent(550)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 556 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.MEAN_MACHINE)
    elseif csid == 557 then
        player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.MEAN_MACHINE)
        player:addFame(xi.quest.fame_area.BASTOK, 120)
        player:tradeComplete()
        player:addItem(4869)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 4869)
    end
end

return entity
