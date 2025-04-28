-----------------------------------
-- Area: Riverne-Site_B01
-- Notes: Assists Ouryu in Wyrmking Descends
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
end

return entity
