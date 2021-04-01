-----------------------------------
-- Area: Davoi
--  NPC: Storage Hole
-- Involved in Quest: The Crimson Trial
-- !pos -51 4 -217 149
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Davoi/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    if (player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_CRIMSON_TRIAL) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(1103, 1) and trade:getItemCount() == 1) then
            player:tradeComplete()
            player:addKeyItem(xi.ki.ORCISH_DRIED_FOOD)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ORCISH_DRIED_FOOD)
        end
    end

end

entity.onTrigger = function(player, npc)

    if (player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_CRIMSON_TRIAL) == QUEST_ACCEPTED) then
        player:messageSpecial(ID.text.AN_ORCISH_STORAGE_HOLE)
    else
        player:messageSpecial(ID.text.YOU_SEE_NOTHING)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
