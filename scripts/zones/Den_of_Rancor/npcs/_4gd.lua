-----------------------------------
-- Area: Den of Rancor
--  NPC: Altar of Rancor (Rancor Flame)
-- !pos -76 16 -1 160
-----------------------------------
local denOfRancorID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if trade:getItemQty(xi.item.UNLIT_LANTERN) > 0 then
        if npcUtil.giveItem(player, xi.item.RANCOR_FLAME) then
            trade:confirmItem(xi.item.UNLIT_LANTERN, 1)
            player:confirmTrade()
        end
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(denOfRancorID.text.LANTERN_OFFSET + 13, xi.item.RANCOR_FLAME, xi.item.UNLIT_LANTERN) -- You could use this flame to light an unlit lantern.
end

return entity
