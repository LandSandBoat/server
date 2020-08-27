-----------------------------------
-- Area: Den of Rancor
--  NPC: Altar of Rancor (Rancor Flame)
-- !pos -76 16 -1 160
-----------------------------------
local ID = require("scripts/zones/Den_of_Rancor/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 1138) then -- Unlit Lantern
        if npcUtil.giveItem(player, 1139) then -- Rancor Flame
            player:confirmTrade()
        end
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.LANTERN_OFFSET + 13, 1139, 1138) -- You could use this flame to light an unlit lantern.
end
