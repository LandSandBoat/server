-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Gladiatorial Weapon
-- BCNM: Die by the Sword
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.UDMGMAGIC, -10000)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
