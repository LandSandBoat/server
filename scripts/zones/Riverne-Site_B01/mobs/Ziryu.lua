-----------------------------------
-- Area: Riverne-Site_A01
-- Notes: Assists Ouryu in Ouryu Cometh
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
end

return entity
