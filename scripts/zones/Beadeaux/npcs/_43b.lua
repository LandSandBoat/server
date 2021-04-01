-----------------------------------
-- Area: Beadeaux
--  NPC: Jail Door
-- Involved in Quests: The Rescue
-- !pos 56 0.1 -23 147
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Beadeaux/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_RESCUE) == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.TRADERS_SACK) == false) then
        if (trade:hasItemQty(495, 1) == true and trade:getItemCount() == 1) then
            player:startEvent(1000)
        end
    end
end

entity.onTrigger = function(player, npc)
    if (player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_RESCUE) == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.TRADERS_SACK) == false) then
        player:messageSpecial(ID.text.LOCKED_DOOR_QUADAV_HAS_KEY)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 1000) then
        player:addKeyItem(xi.ki.TRADERS_SACK)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TRADERS_SACK)
    end
end

return entity
