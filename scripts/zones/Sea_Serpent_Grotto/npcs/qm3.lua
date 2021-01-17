-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: ??? Used for Norg quest "It's not your vault"
-- !pos -173 26 252 176
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.ITS_NOT_YOUR_VAULT) == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.SEALED_IRON_BOX) then
        player:addKeyItem(tpz.ki.SEALED_IRON_BOX)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SEALED_IRON_BOX)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
