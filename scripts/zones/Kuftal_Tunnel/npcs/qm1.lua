-----------------------------------
-- Area: Kuftal Tunnel
--  NPC: ??? (qm1)
-- Note: Spawns Phantom Worm
-- Position changes every 8 seconds
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
local kuftalGlobal = require('scripts/zones/Kuftal_Tunnel/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onSpawn = function(npc)
    npc:timer(8000, function()
        kuftalGlobal.movePhantomWormQM()
    end)
end

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.CHUNK_OF_DARKSTEEL_ORE) and
        npcUtil.popFromQM(player, npc, ID.mob.PHANTOM_WORM, { radius = 1, hide = 900 })
    then
        player:confirmTrade()
    end
end

return entity
