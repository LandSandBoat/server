-----------------------------------
-- Area: Windurst Waters
--  NPC: Orn
-- !pos -68 -9 30 238
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    bookwormStatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.EARLY_BIRD_CATCHES_THE_BOOKWORM)

    if (bookwormStatus == QUEST_ACCEPTED and player:getCharVar("EARLY_BIRD_TRACK_BOOK") == 3) then
        player:startEvent(399)

    elseif (bookwormStatus == QUEST_ACCEPTED and player:getCharVar("EARLY_BIRD_TRACK_BOOK") == 2) then
        player:startEvent(398)

    elseif (bookwormStatus == QUEST_ACCEPTED and player:getCharVar("EARLY_BIRD_TRACK_BOOK") == 1) then
        player:startEvent(396)

    elseif (bookwormStatus == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.OVERDUE_BOOK_NOTIFICATIONS) == true) then
        player:startEvent(395)

    else
        player:startEvent(652)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 395) then
        player:setCharVar("EARLY_BIRD_TRACK_BOOK", 1)
    elseif (csid == 398) then
        player:setCharVar("EARLY_BIRD_TRACK_BOOK", 3)
    end

end
