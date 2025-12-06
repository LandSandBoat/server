-----------------------------------
-- Area: Cloister of Tremors
--  Mob: Galgalim
-- Involved in Quest: The Puppet Master
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
