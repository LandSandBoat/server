-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Metsanhaltija
-- BCNM: Grove Guardians
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SLEEP_MEVA, 50)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
