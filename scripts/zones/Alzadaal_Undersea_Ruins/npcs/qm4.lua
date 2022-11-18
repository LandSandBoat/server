-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: ??? (Spawn Wulgaru(ZNM T2))
-- !pos -22 -4 204 72
-----------------------------------
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 2597) and
        npcUtil.popFromQM(player, npc, ID.mob.WULGARU)
    then
        -- Trade Opalus Gem
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.GLITTERING_FRAGMENTS)
end

return entity
