-----------------------------------
-- Area: Upper Delkfutt's Tower
--   NM: Enkelados
-----------------------------------
mixins = { require('scripts/mixins/families/gigas_bst_nm') }
-----------------------------------
local ID = zones[xi.zone.UPPER_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -226.158, y = -144.099, z =  28.522 }
}

entity.phList =
{
    [ID.mob.ENKELADOS[1] + 3] = ID.mob.ENKELADOS[1], -- Confirmed on retail
    [ID.mob.ENKELADOS[2] + 3] = ID.mob.ENKELADOS[2], -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Gigass_Bats')
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 331)
end

return entity
