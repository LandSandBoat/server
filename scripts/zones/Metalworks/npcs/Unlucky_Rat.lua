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

    local MeanMachine = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.MEAN_MACHINE)

    if MeanMachine == QUEST_ACCEPTED then
        local FreeSlots = player:getFreeSlotsCount()

        if FreeSlots >= 1 then
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

    local MeanMachine = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.MEAN_MACHINE)
    local Fame = player:getFameLevel(BASTOK)

    if MeanMachine == QUEST_AVAILABLE and Fame >= 2 then
        player:startEvent(556)
    elseif MeanMachine == QUEST_ACCEPTED then
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
        player:addFame(BASTOK, 120)
        player:tradeComplete()
        player:addItem(4869)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 4869)
    end

end

return entity
