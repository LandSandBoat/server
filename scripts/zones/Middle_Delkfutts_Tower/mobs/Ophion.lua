-----------------------------------
-- Area: Middle Delkfutt's Tower
--   NM: Ophion
-----------------------------------
mixins = { require('scripts/mixins/families/gigas_bst_nm') }
-----------------------------------
local ID = zones[xi.zone.MIDDLE_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -444.000, y = -95.000, z = -3.000 }
}

entity.phList =
{
    [ID.mob.OPHION - 16] = ID.mob.OPHION, -- -453 -95.529 -1
    [ID.mob.OPHION - 11] = ID.mob.OPHION, -- -409.937 -95.772 48.785
    [ID.mob.OPHION - 2]  = ID.mob.OPHION, -- -384 -95.529 14
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Gigass_Bats')
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 337)
end

return entity
