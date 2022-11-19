-----------------------------------
-- Area: Newton Movalpolos
--  NPC: Moblin Showman - Bugbear Matman
-- !pos 124.544 19.988 -60.670 12
-----------------------------------
local ID = require("scripts/zones/Newton_Movalpolos/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 1878) and
        npcUtil.popFromQM(player, npc, ID.mob.BUGBEAR_MATMAN)
    then
        -- Air tank
        player:showText(npc, ID.text.SHOWMAN_ACCEPT)
        player:confirmTrade()
    else
        player:showText(npc, ID.text.SHOWMAN_DECLINE)
    end
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.SHOWMAN_TRIGGER)
end

return entity
