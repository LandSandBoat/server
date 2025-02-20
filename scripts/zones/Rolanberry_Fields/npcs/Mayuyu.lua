-----------------------------------
-- Area: Rolanberry Fields
--  NPC: Mayuyu
-- Legion NPC
-- !pos 240 24.399 468
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local legendary = player:hasTitle(xi.title.LEGENDARY_LEGIONNAIRE) and 1 or 0
    local capacity =
        (player:hasKeyItem(xi.ki.LEGION_TOME_PAGE_MINIMUS) and 1 or 0) +
        (player:hasKeyItem(xi.ki.LEGION_TOME_PAGE_MAXIMUS) and 2 or 0)

    player:startEvent(8008, 0, legendary, capacity)
end

return entity
