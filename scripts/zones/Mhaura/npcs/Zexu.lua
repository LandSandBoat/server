-----------------------------------
-- Area: Mhaura
--  NPC: Zexu
-- Involved in Quests: The Sand Charm
-- !pos 30 -8 25 249
-----------------------------------
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCharVar("theSandCharmVar") == 1) then
        player:startEvent(123) -- During quest "The Sand Charm" - 1st dialog
    else
        player:startEvent(121) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 123) then
        player:setCharVar("theSandCharmVar", 2)
    end
end
