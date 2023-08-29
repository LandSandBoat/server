-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: GoTyo Magenapper
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
