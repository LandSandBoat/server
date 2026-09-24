-----------------------------------
-- Area: Caedarva Mire
--  Mob: Elder Treant
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DEFP, -25)
end

return entity
