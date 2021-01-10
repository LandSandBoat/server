-----------------------------------
-- Area: Sacrificial Chamber
--  Mob: Sable-tongued Gonberry
-- BCNM: Jungle Boogymen
-----------------------------------
mixins =
{
    require("scripts/mixins/families/tonberry"),
    require("scripts/mixins/job_special")
}
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

return entity
