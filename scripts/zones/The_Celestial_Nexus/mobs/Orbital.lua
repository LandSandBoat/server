-----------------------------------
-- Area: The Celestial Nexus
--  Mob: Orbital
-- Zilart Mission 16 BCNM Fight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 50)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
