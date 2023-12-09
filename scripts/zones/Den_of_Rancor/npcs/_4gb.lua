-----------------------------------
-- Area: Den of Rancor
--  NPC: Altar of Rancor (flame of blue rancor)
-- !pos 400.880 22.830 359.636 160
-----------------------------------
local denOfRancorID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if trade:getItemQty(xi.item.UNLIT_LANTERN) > 0 then
        if npcUtil.giveItem(player, xi.item.FLAME_OF_BLUE_RANCOR) then
            trade:confirmItem(xi.item.UNLIT_LANTERN, 1)
            player:confirmTrade()
        end
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(denOfRancorID.text.LANTERN_OFFSET + 3) -- The altar glows an eerie blue. The lanterns have been put out.
end

return entity
