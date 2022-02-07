-----------------------------------
-- Area: Apollyon SE, Floor 4
--  Mob: Evil Armory
-----------------------------------
require("scripts/zones/Apollyon/helpers/apollyon_se")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGMAGIC, -10000)
    mob:setMod(xi.mod.UDMGPHYS, -8000)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_se.handleMobDeathKey(mob, player, isKiller, noKiller, 4)
end

return entity
