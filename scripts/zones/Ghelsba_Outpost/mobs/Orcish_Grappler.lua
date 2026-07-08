-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Orcish Grappler
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_H2H_PENALTY, 1)
end

return entity
