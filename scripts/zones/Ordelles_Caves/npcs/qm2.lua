-----------------------------------
-- Area: Ordelle's Caves
--  NPC: ??? (qm2)
-- Involved in Quest: A Squire's Test II
-- !pos -94 1 273 193
-----------------------------------
local ID = require("scripts/zones/Ordelles_Caves/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_SQUIRE_S_TEST_II) == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.STALACTITE_DEW) and
        player:getCharVar("SquiresTestII") == 0
    then
        player:setCharVar("SquiresTestII", os.time())
        player:messageSpecial(ID.text.A_SQUIRE_S_TEST_II_DIALOG_I)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
