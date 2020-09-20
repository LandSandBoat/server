-----------------------------------
-- Area: Apollyon SE
--  Mob: Ghost Clot
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Apollyon/IDs")

function onMobSpawn(mob)
    mob:setMod(tpz.mod.SLASHRES, 1500)
    mob:setMod(tpz.mod.HTHRES, 0)
    mob:setMod(tpz.mod.IMPACTRES, 0)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        tpz.limbus.handleDoors(player:getBattlefield(), true, ID.npc.APOLLYON_SE_PORTAL[1])
    end
end