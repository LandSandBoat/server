-----------------------------------
-- Area: Bastok Mines
--  NPC: Detzo
-- Starts & Finishes Quest: Rivals
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/titles")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.RIVALS) == QUEST_ACCEPTED then
        if player:getFreeSlotsCount() >= 1 then
            if trade:hasItemQty(12417, 1) == true and trade:getItemCount() == 1 then
                player:startEvent(94)
            end
        else
            player:messageSpecial(ID.text.FULL_INVENTORY_AFTER_TRADE, 13571)
        end
    end
end

entity.onTrigger = function(player, npc)
    local Rivals = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.RIVALS)

    if player:getCharVar("theTalekeeperGiftCS") == 1 then
        player:startEvent(171)
        player:setCharVar("theTalekeeperGiftCS", 2)

    elseif
        Rivals == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.BASTOK) >= 3
    then
        player:startEvent(93)

    elseif Rivals == QUEST_ACCEPTED then
        player:showText(npc, ID.text.DETZO_RIVALS_DIALOG)

    else
        player:startEvent(30)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 93 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.RIVALS)
    elseif csid == 94 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13571)
        else
            player:addTitle(xi.title.CONTEST_RIGGER)
            player:addItem(13571)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13571)
            player:addFame(xi.quest.fame_area.BASTOK, 30)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.RIVALS)
        end
    end
end

return entity
