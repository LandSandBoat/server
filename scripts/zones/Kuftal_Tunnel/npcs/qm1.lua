-----------------------------------
-- Area: Kuftal Tunnel
--  NPC: ??? (qm1)
-- Note: Spawns Phantom Worm
-- position changes every 5 seconds
-----------------------------------
local ID = require("scripts/zones/Kuftal_Tunnel/IDs")
local kuftalGlobal = require("scripts/zones/Kuftal_Tunnel/globals")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
    npc:timer(5000, function()
        kuftalGlobal.movePhantomWormQM()
    end)
end

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 645) and
        npcUtil.popFromQM(player, npc, ID.mob.PHANTOM_WORM, { radius = 1 })
    then
        -- Darksteel Ore
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
end

return entity
