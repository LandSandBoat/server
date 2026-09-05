-----------------------------------
-- Area: Periqia
--  Mob: Excaliace
-- Involved in Assault: Seagull Grounded
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
    mob:setMobMod(xi.mobMod.DONT_ROAM_HOME, 1)
    mob:setMobMod(xi.mobMod.NO_DESPAWN, 1)
end

return entity
