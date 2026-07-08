-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Cutter
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
end

return entity
