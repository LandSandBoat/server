-----------------------------------
-- Area: Den of Rancor
--  NPC: Altar of Rancor (flame of blue rancor)
-- !pos 400.880 22.830 359.636 160
-----------------------------------
local ID = require("scripts/zones/Den_of_Rancor/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.items.UNLIT_LANTERN) then -- Unlit Lantern
        if npcUtil.giveItem(player, xi.items.FLAME_OF_BLUE_RANCOR) then -- Flame of Blue Rancor
            player:confirmTrade()
        end
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.LANTERN_OFFSET + 3) -- The altar glows an eerie blue. The lanterns have been put out.
end

return entity
