-----------------------------------
-- Area: Balgas Dais
-- Mob: Domovoi
-- BCNM: Steamed Sprouts
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
end

return entity
