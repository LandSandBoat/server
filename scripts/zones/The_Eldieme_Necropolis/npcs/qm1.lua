-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: ???
-- Involved in Quests: Acting in Good Faith
-- !pos -17 0 59 195 (I-10)
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.ACTING_IN_GOOD_FAITH) == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.SPIRIT_INCENSE) then
        player:startEvent(50)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 50 and option == 0 then
        player:messageSpecial(ID.text.SPIRIT_INCENSE_EMITS_PUTRID_ODOR, tpz.ki.SPIRIT_INCENSE)
        player:delKeyItem(tpz.ki.SPIRIT_INCENSE)
    end
end

return entity
