-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Vanguard Ronin
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.dynamis.refillMobGroupOnDeath(mob, player, isKiller, 600) -- 10 min
end

return entity
