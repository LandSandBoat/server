-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: ??? Used for Norg quest "The Sahagin's Stash"
-- !pos 295.276 27.129 213.043 176
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.THE_SAHAGINS_STASH) == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.SEA_SERPENT_STATUE) then
        player:startEvent(1)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 1 then
        player:addKeyItem(tpz.ki.SEA_SERPENT_STATUE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SEA_SERPENT_STATUE)
    end
end

return entity
