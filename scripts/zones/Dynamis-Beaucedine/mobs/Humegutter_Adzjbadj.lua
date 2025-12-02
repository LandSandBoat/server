-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Humegutter Adzjbadj
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
    { x =  289.547, y = -0.196, z = -40.171 }
}

entity.phList =
{
    [ID.mob.HUMEGUTTER_ADZJBADJ - 1] = ID.mob.HUMEGUTTER_ADZJBADJ, -- Vanguard_Footsoldier
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
