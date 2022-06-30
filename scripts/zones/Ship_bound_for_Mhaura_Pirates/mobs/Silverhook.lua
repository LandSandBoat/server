-----------------------------------
-- Area: Ship bound for Mhaura (Pirates)
--  Mob: Silverhook
-----------------------------------
local ID = require("scripts/zones/Ship_bound_for_Mhaura_Pirates/IDs")
-----------------------------------

local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SILENCERES, 100)
    mob:setMod(xi.mod.BINDRES, 100)
    mob:setMod(xi.mod.MDEF, 50)
end

entity.onMobDeath = function(mob, player)

end

entity.onMobDespawn = function(mob, player)
    mob:setLocalVar("respawnTime", os.time() + 60)
    mob:setLocalVar("killed", 1)
end

return entity
