-----------------------------------
-- Area: Konschtat Highlands
--  NPC: Signpost
-- Involved in Quest: The Signpost Marks the Spot
-- !pos -183 65 599 108
-----------------------------------
local ID = require("scripts/zones/Konschtat_Highlands/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if
        player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.THE_SIGNPOST_MARKS_THE_SPOT) == QUEST_ACCEPTED and
        not player:hasKeyItem(tpz.ki.PAINTING_OF_A_WINDMILL)
    then
        player:messageSpecial(ID.text.SIGNPOST_DIALOG_2)
        player:addKeyItem(tpz.ki.PAINTING_OF_A_WINDMILL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PAINTING_OF_A_WINDMILL)
    else
        player:messageSpecial(ID.text.SIGNPOST_DIALOG_1)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
