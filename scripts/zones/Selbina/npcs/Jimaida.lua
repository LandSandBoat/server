-----------------------------------
-- Area: Selbina
--  NPC: Jimaida
-- Involved in Quests: Under the sea
-- !pos -15 -2 -16 248
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("underTheSeaVar") == 2 then
        player:startEvent(33) -- During quest "Under the sea" - 2nd dialog
    else
        player:startEvent(152) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 33 then
        player:setCharVar("underTheSeaVar", 3)
    end
end
