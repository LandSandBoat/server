-----------------------------------
-- Area: Castle Oztroja
--  NPC: qm2 (???)
-- Used In Quest: Whence Blows the Wind
-- !pos -100 -63 58 151
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Castle_Oztroja/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.WHENCE_BLOWS_THE_WIND) == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.YAGUDO_CREST) == false) then
        player:addKeyItem(xi.ki.YAGUDO_CREST)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.YAGUDO_CREST)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
