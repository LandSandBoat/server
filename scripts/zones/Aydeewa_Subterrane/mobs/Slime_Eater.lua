-----------------------------------
-- Area: Aydeewa Subterrane
--   Mob: Slime Eater
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DEFP, 20)
    mob:setMod(xi.mod.MDEF, 20)
end

return entity
