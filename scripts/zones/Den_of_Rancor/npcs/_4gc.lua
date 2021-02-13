-----------------------------------
-- Area: Den of Rancor
--  NPC: Altar of Rancor (Flame of Crimson Rancor)
-- !pos 199 32 -280 160
-----------------------------------
local ID = require("scripts/zones/Den_of_Rancor/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 1138) then -- Unlit Lantern
        if npcUtil.giveItem(player, 1140) then -- Flame of Crimson Rancor
            player:confirmTrade()
        end
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.LANTERN_OFFSET + 2) -- The altar glows an eerie red. The lanterns have been put out.
end

return entity
