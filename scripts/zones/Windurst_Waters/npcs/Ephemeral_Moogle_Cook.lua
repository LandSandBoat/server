-----------------------------------
-- Area: Windurst Waters
--  NPC: Ephemeral Moogle
-- !pos -117.250 -2.000 60.890 238
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
