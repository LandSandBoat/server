-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: SoZho Metalbender
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BEAUCEDINE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  376.572, y =  0.187, z = -147.550 }
}

entity.phList =
{
    [ID.mob.SOZHO_METALBENDER - 1] = ID.mob.SOZHO_METALBENDER, -- Vanguard_Militant
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
