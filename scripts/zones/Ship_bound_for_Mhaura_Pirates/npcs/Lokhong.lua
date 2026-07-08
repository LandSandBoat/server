-----------------------------------
-- Area: Ship bound for Mhaura Pirates
--  NPC: Lokhong
-- Type: Guild Merchant: Fishing Guild
-- !pos 1.841 -2.101 -9.000 221
-----------------------------------
local ID = zones[xi.zone.SHIP_BOUND_FOR_MHAURA_PIRATES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, ID.text.LOKHONG_SHOP_DIALOG)
    end
end

return entity
