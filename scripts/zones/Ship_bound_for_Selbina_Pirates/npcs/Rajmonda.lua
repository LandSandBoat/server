-----------------------------------
-- Area: Ship bound for Selbina Pirates
--  NPC: Rajmonda
-- Type: Guild Merchant: Fishing Guild
-----------------------------------
local ID = zones[xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, ID.text.RAJMONDA_SHOP_DIALOG)
    end
end

return entity
