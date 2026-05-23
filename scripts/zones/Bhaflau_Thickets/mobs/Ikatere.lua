-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Ikatere
--  Besieged
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.besieged.onMobInitialize(mob)
end

entity.onMobSpawn = function(mob)
    xi.besieged.onMobSpawn(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.besieged.onMobDeath(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.besieged.onMobDespawn(mob)
end

return entity
