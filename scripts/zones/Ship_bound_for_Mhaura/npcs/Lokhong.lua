-----------------------------------
-- Area: Ship bound for Mhaura
--  NPC: Lokhong
-- Type: Guild Merchant: Fishing Guild
-- !pos 1.841 -2.101 -9.000 221
-----------------------------------
local ID = zones[xi.zone.SHIP_BOUND_FOR_MHAURA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(521, 1, 23, 5) then
        player:showText(npc, ID.text.LOKHONG_SHOP_DIALOG)
    end
end

return entity
