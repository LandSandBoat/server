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

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.WHENCE_BLOWS_THE_WIND) == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.QUADAV_CREST) == false) then
        player:addKeyItem(tpz.ki.QUADAV_CREST)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.QUADAV_CREST)
    else
        player:messageSpecial(ID.text.YOU_FIND_NOTHING)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
