-----------------------------------
-- Area: Korroloka Tunnel
--  NPC: ??? (qm1) - Morion Worm spawn
-- !pos 254.652 -6.039 20.878 173
-----------------------------------
local ID = require("scripts/zones/Korroloka_Tunnel/IDs")
local korrolokaGlobal = require("scripts/zones/Korroloka_Tunnel/globals")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
    npc:timer(900000, function()
        korrolokaGlobal.moveMorionWormQM()
    end) -- Time in miliseconds. 15 minutes.
end

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 643) and
        npcUtil.popFromQM(player, npc, ID.mob.MORION_WORM, { radius = 1 })
    then
        -- Iron Ore
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.MORION_WORM_1)
end

return entity
