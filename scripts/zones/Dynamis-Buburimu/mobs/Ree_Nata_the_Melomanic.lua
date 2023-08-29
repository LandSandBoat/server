-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Ree Nata the Melomanic
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special'),
    require('scripts/mixins/remove_doom')
}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
