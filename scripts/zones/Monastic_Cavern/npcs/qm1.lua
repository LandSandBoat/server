-----------------------------------
-- Area: Monastic Cavern
--  NPC: ???
-- Used In Quest: Whence Blows the Wind
-- !pos 168 -1 -22 150
-----------------------------------
local ID = require("scripts/zones/Monastic_Cavern/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.WHENCE_BLOWS_THE_WIND) == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.ORCISH_CREST) then
        player:addKeyItem(tpz.ki.ORCISH_CREST)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ORCISH_CREST)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
