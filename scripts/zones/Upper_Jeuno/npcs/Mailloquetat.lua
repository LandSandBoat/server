-----------------------------------
-- Area: Upper Jeuno
--  NPC: Mailloquetat
-- Involved in Quests: Save my Sister
-- !pos -31 -1 8 244
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/shop")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getFameLevel(JEUNO) >= 4 and player:getCharVar("saveMySisterVar") == 1) then
        player:startEvent(159) -- For "Save my Sister" quest
    else
        player:startEvent(25) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 159) then
        player:setCharVar("saveMySisterVar", 2)
    end
end

return entity
