-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Phantom Worm
-----------------------------------
local kuftalGlobal = require("scripts/zones/Kuftal_Tunnel/globals")
local ID = require("scripts/zones/Kuftal_Tunnel/IDs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 1800)
    mob:addMod(xi.mod.REGEN, 50)
end

entity.onMobSpawn = function(mob)
    local npc = GetNPCByID(ID.npc.PHANTOM_WORM_QM)
    npc:clearTimerQueue()
    npc:setStatus(xi.status.DISAPPEAR)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local npc = GetNPCByID(ID.npc.PHANTOM_WORM_QM)
    npc:timer(900000, function()
        kuftalGlobal.movePhantomWormQM()
        npc:setStatus(xi.status.NORMAL)
    end)
end

return entity
