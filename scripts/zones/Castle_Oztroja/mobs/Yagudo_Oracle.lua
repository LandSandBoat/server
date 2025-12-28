-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Oracle
-- Note: PH for Quu Domi the Gallant
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Yagudos_Elemental')
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.QUU_DOMI_THE_GALLANT, 5, 3600) -- 1 hour
end

return entity
