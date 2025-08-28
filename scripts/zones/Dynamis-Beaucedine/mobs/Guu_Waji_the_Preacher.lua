-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Guu Waji the Preacher
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

entity.phList =
{
    [ID.mob.GUU_WAJI_THE_PREACHER - 1] = ID.mob.GUU_WAJI_THE_PREACHER, -- Vanguard_Exemplar
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
