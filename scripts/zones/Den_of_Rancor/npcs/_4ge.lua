-----------------------------------
-- Area: Den of Rancor
--  NPC: Altar of Rancor (Rancor Flame)
-- !pos -76 16 -1 160
-----------------------------------
local ID = require("scripts/zones/Den_of_Rancor/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.items.UNLIT_LANTERN) then -- Unlit Lantern
        if npcUtil.giveItem(player, xi.items.RANCOR_FLAME) then -- Rancor Flame
            player:confirmTrade()
        end
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.LANTERN_OFFSET + 13, xi.items.RANCOR_FLAME, xi.items.UNLIT_LANTERN) -- You could use this flame to light an unlit lantern.
end

return entity
