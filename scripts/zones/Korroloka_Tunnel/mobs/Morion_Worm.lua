-----------------------------------
-- Area: Korroloka Tunnel (173)
--  Mob: Morion Worm
-----------------------------------
local korrolokaGlobal = require("scripts/zones/Korroloka_Tunnel/globals")
local ID = require("scripts/zones/Korroloka_Tunnel/IDs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 1800)
    mob:setMod(xi.mod.REGEN, 5)
end

entity.onMobSpawn = function(mob)
    local npc = GetNPCByID(ID.npc.MORION_WORM_QM)
    npc:clearTimerQueue()
    npc:setStatus(xi.status.DISAPPEAR)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local npc = GetNPCByID(ID.npc.MORION_WORM_QM)
    npc:timer(900000, function()
        korrolokaGlobal.moveMorionWormQM()
        npc:setStatus(xi.status.NORMAL)
    end)
end
return entity
