-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Maa Zaua the Wyrmkeeper
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special'),
    require('scripts/mixins/remove_doom')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BEAUCEDINE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  240.630, y = -20.460, z = -115.650 }
}

entity.phList =
{
    [ID.mob.MAA_ZAUA_THE_WYRMKEEPER - 2] = ID.mob.MAA_ZAUA_THE_WYRMKEEPER, -- Vanguard_Partisan
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Vanguards_Wyvern')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
