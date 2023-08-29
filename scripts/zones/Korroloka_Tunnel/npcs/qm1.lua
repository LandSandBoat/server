-----------------------------------
-- Area: Korroloka Tunnel
--  NPC: ??? (qm1) - Morion Worm spawn
-- !pos 254.652 -6.039 20.878 173
-----------------------------------
local ID = zones[xi.zone.KORROLOKA_TUNNEL]
local korrolokaGlobal = require('scripts/zones/Korroloka_Tunnel/globals')
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
    npc:timer(900000, function()
        korrolokaGlobal.moveMorionWormQM()
    end) -- Time in miliseconds. 15 minutes.
end

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.CHUNK_OF_IRON_ORE) and
        npcUtil.popFromQM(player, npc, ID.mob.MORION_WORM, { radius = 1 })
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.MORION_WORM_1)
end

return entity
