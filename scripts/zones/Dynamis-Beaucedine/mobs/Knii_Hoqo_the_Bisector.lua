-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Knii Hoqo the Bisector
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
    [ID.mob.KNII_HOQO_THE_BISECTOR - 1] = ID.mob.KNII_HOQO_THE_BISECTOR, -- Vanguard_Persecutor
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
