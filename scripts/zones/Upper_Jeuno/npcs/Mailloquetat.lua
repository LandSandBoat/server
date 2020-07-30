-----------------------------------
-- Area: Upper Jeuno
--  NPC: Mailloquetat
-- Involved in Quests: Save my Sister
-- !pos -31 -1 8 244
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getFameLevel(JEUNO) >= 4 and player:getCharVar("saveMySisterVar") == 1) then
        player:startEvent(159) -- For "Save my Sister" quest
    else
        player:startEvent(25) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 159) then
        player:setCharVar("saveMySisterVar", 2)
    end
end
