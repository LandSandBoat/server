-----------------------------------
-- Area: Apollyon SE, Floor 3
--  Mob: Grave Digger
-----------------------------------
require("scripts/zones/Apollyon/bcnms/se_apollyon_helper")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.HTH_SDT, 1500)
    mob:setMod(xi.mod.IMPACT_SDT, 1500)
    mob:setMod(xi.mod.PIERCE_SDT, 0)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_se.handleMobDeathKey(mob, player, isKiller, noKiller, 3)
end

return entity
