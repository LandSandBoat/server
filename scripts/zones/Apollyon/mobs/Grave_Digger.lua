-----------------------------------
-- Area: Apollyon SE
--  Mob: Grave Digger
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Apollyon/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.HTHRES, 1500)
    mob:setMod(xi.mod.IMPACTRES, 1500)
    mob:setMod(xi.mod.PIERCERES, 0)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller, noKiller)
    if isKiller or noKiller then
        xi.limbus.handleDoors(mob:getBattlefield(), true, ID.npc.APOLLYON_SE_PORTAL[3])
    end
end

return entity
