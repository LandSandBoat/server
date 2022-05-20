-----------------------------------
-- Area: Apollyon SE, Floor 1
--  Mob: Metalloid Amoeba
-----------------------------------
require("scripts/zones/Apollyon/bcnms/se_apollyon_helper")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLASH_SDT, 1500)
    mob:setMod(xi.mod.HTH_SDT, 0)
    mob:setMod(xi.mod.IMPACT_SDT, 0)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_se.handleMobDeathFloorOne(mob, player, isKiller, noKiller)
end

return entity
