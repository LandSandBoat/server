-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Doom Mage
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

return entity
