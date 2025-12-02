-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Tonberry Kinq
-----------------------------------
mixins =
{
    require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -219.962, y = -1.736, z =  28.388 }
}

entity.phList =
{
    [ID.mob.TONBERRY_KINQ - 4] = ID.mob.TONBERRY_KINQ, -- -221.717 0.996 12.819
    [ID.mob.TONBERRY_KINQ - 2] = ID.mob.TONBERRY_KINQ, -- -218 -0.792 24
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Tonberrys_Elemental')
    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 30000)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
