-----------------------------------
-- Area: Sacrarium
--  Mob: Azren Kuba
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

return entity
