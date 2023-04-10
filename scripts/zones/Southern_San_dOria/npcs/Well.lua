-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Well
-- Involved in Quest: Grave Concerns
-- !pos -129 -6 92 230
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GRAVE_CONCERNS) == QUEST_ACCEPTED then
        if trade:hasItemQty(547, 1) and trade:getItemCount() == 1 then
            player:tradeComplete()
            player:addItem(567)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 567) -- Tomb Waterskin
        end
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
