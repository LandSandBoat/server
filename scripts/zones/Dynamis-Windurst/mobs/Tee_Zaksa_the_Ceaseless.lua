-----------------------------------
-- Area: Dynamis - Windurst
--  Mob: Tee Zaksa the Ceaseless
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special"),
    require("scripts/mixins/remove_doom")
}
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

return entity
