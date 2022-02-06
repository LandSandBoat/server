-----------------------------------
-- Area: Apollyon SE, Floor 1
--  Mob: Ghost Clot
-----------------------------------
require("scripts/zones/Apollyon/helpers/apollyon_se")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLASH_SDT, 1500)
    mob:setMod(xi.mod.HTH_SDT, 0)
    mob:setMod(xi.mod.IMPACT_SDT, 0)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_se.handleMobDeathKey(mob, player, isKiller, noKiller, 1)
end

return entity
