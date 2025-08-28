-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: MiRhe Whisperblade
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

entity.phList =
{
    [ID.mob.MIRHE_WHISPERBLADE - 1] = ID.mob.MIRHE_WHISPERBLADE, -- Vanguard_Kusa
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
