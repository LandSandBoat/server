-----------------------------------
-- Area: Windurst Woods
--  NPC: Ephemeral Moogle
-- !pos -34.840 -1.250 -114.490 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.ephemeralMoogleOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.crafting.ephemeralMoogleOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.crafting.ephemeralMoogleOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.crafting.ephemeralMoogleOnEventFinish(player, csid, option, npc)
end

return entity
