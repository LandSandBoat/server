-----------------------------------
-- Area: Bastok Mines
--  NPC: Detzo
-- Starts & Finishes Quest: Rivals
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    local Rivals = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.RIVALS)

    if (Rivals == QUEST_ACCEPTED) then
        local FreeSlots = player:getFreeSlotsCount()

        if (FreeSlots >= 1) then
            local count = trade:getItemCount()
            local MythrilSallet = trade:hasItemQty(12417, 1)

            if (MythrilSallet == true and count == 1) then
                -- You retain the Mythril Sallet after trading it to Detzo
                player:startEvent(94)
            end
        else
            player:messageSpecial(ID.text.FULL_INVENTORY_AFTER_TRADE, 13571)
        end
    end

end

entity.onTrigger = function(player, npc)

    local Rivals = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.RIVALS)

    if (player:getCharVar("theTalekeeperGiftCS") == 1) then
        player:startEvent(171)
        player:setCharVar("theTalekeeperGiftCS", 2)
    elseif (Rivals == QUEST_AVAILABLE and player:getFameLevel(BASTOK) >= 3) then
        player:startEvent(93)
    elseif (Rivals == QUEST_ACCEPTED) then
        player:showText(npc, ID.text.DETZO_RIVALS_DIALOG)
    else
        player:startEvent(30)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 93) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.RIVALS)
    elseif (csid == 94) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13571)
        else
            player:addTitle(xi.title.CONTEST_RIGGER)
            player:addItem(13571)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13571)
            player:addFame(BASTOK, 30)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.RIVALS)
        end
    end

end

return entity
