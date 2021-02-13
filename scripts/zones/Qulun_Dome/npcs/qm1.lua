-----------------------------------
-- Area: Qulun Dome
--  NPC: qm1 (???)
-- Used In Quest: Whence Blows the Wind
-- !pos 261 39 79 148
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Qulun_Dome/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.WHENCE_BLOWS_THE_WIND) == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.QUADAV_CREST) == false) then
        player:addKeyItem(tpz.ki.QUADAV_CREST)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.QUADAV_CREST)
    else
        player:messageSpecial(ID.text.YOU_FIND_NOTHING)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
