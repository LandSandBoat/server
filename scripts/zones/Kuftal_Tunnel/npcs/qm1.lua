-----------------------------------
-- Area: Kuftal Tunnel
--  NPC: ??? (qm1)
-- Note: Spawns Phantom Worm
-- position changes every 5 seconds
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
local kuftalGlobal = require('scripts/zones/Kuftal_Tunnel/globals')
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
    npc:timer(5000, function()
        kuftalGlobal.movePhantomWormQM()
    end)
end

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.CHUNK_OF_DARKSTEEL_ORE) and
        npcUtil.popFromQM(player, npc, ID.mob.PHANTOM_WORM, { radius = 1 })
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
end

return entity
