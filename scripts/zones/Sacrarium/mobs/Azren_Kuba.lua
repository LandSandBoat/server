-----------------------------------
-- Area: Sacrarium
--  Mob: Azren Kuba
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

return entity
