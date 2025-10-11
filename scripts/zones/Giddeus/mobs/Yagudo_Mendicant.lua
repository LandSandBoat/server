-----------------------------------
-- Area: Giddeus (145)
--  Mob: Yagudo Mendicant
-----------------------------------
local ID = zones[xi.zone.GIDDEUS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Yagudos_Elemental')
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.HOO_MJUU_THE_TORRENT, 12, 3600) -- 1 hour
end

return entity
