-----------------------------------
-- Area: Den of Rancor
--  NPC: Altar of Rancor (flame of blue rancor)
-- !pos 400.880 22.830 359.636 160
-----------------------------------
local ID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.item.UNLIT_LANTERN) then -- Unlit Lantern
        if npcUtil.giveItem(player, xi.item.FLAME_OF_BLUE_RANCOR) then -- Flame of Blue Rancor
            player:confirmTrade()
        end
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.LANTERN_OFFSET + 3) -- The altar glows an eerie blue. The lanterns have been put out.
end

return entity
