-----------------------------------
-- Area: Windurst Woods
-- NPC: Hae Jakkya
-- Involved in quest: Chasing Tales
-- !pos 57.387 -2.5 -140.757 241
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.CHASING_TALES) == QUEST_ACCEPTED then
        if player:hasKeyItem(tpz.ki.A_SONG_OF_LOVE) then
            player:startEvent(406)
        elseif player:getCharVar("CHASING_TALES_TRACK_BOOK") == 1 then
            player:startEvent(403, 0, tpz.ki.A_SONG_OF_LOVE)
        elseif player:hasKeyItem(tpz.ki.OVERDUE_BOOK_NOTIFICATION) then
            player:startEvent(402, 0, tpz.ki.A_SONG_OF_LOVE)
        else
            player:startEvent(41)
        end
    else
        player:startEvent(41)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 402 then
        player:setCharVar("CHASING_TALES_TRACK_BOOK", 1)
    end
end
