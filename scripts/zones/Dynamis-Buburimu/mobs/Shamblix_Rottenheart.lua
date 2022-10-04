-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Shamblix Rottenheart
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
