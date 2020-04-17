-----------------------------------
-- Area: Apollyon SE
--  Mob: Grave Digger
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Apollyon/IDs")

function onMobSpawn(mob)
    mob:setMod(tpz.mod.HTHRES, 1500)
    mob:setMod(tpz.mod.IMPACTRES, 1500)
    mob:setMod(tpz.mod.PIERCERES, 0)
end

function onMobDeath(mob, player, isKiller, noKiller, noKiller)
    if isKiller or noKiller then
        tpz.limbus.handleDoors(mob:getBattlefield(), true, ID.npc.APOLLYON_SE_PORTAL[3])
    end
end