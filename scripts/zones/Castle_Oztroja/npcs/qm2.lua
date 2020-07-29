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

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.WHENCE_BLOWS_THE_WIND) == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.YAGUDO_CREST) == false) then
        player:addKeyItem(tpz.ki.YAGUDO_CREST)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.YAGUDO_CREST)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
