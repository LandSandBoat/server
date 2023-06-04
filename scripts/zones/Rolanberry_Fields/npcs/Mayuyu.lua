-----------------------------------
-- Area: Rolanberry Fields
--  NPC: Mayuyu
-- Legion NPC
-- !pos 240 24.399 468
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local legendary = player:hasTitle(xi.title.LEGENDARY_LEGIONNAIRE) and 1 or 0
    local capacity =
        (player:hasKeyItem(xi.ki.LEGION_TOME_PAGE_MINIMUS) and 1 or 0) +
        (player:hasKeyItem(xi.ki.LEGION_TOME_PAGE_MAXIMUS) and 2 or 0)

    player:startEvent(8008, 0, legendary, capacity)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- Event needs work, also the Legion Pass item is "tagged" via fields not yet implemented in core.
end

return entity
