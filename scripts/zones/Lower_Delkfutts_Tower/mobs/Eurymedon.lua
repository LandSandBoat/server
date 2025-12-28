-----------------------------------
-- Area: Lower Delkfutt's Tower
--   NM: Eurymedon
-----------------------------------
mixins = { require('scripts/mixins/families/gigas_bst_nm') }
-----------------------------------
local ID = zones[xi.zone.LOWER_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  405.000, y = -32.000, z = -32.000 }
}

entity.phList =
{
    [ID.mob.EURYMEDON + 4] = ID.mob.EURYMEDON, -- 397.252 -32.128 -32.807
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Gigass_Bat')
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 342)
end

return entity
