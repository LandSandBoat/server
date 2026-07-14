-----------------------------------
-- Area: Horlais Peak
--  Mob: Wolf Clan Warmachine
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
end

return entity
