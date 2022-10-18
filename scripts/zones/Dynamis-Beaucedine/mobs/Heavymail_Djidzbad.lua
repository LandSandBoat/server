-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Heavymail Djidzbad
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
