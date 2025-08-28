-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Bhuu Wjato the Firepool
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
    [ID.mob.BHUU_WJATO_THE_FIREPOOL - 2] = ID.mob.BHUU_WJATO_THE_FIREPOOL, -- Vanguard_Prelate
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
