-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Vanguard Enchanter
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Dynamis-Jeuno/IDs")
require("scripts/globals/mobs")
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    dynamis.refillMobGroupOnDeath(mob, player, isKiller, 600) -- 10 min
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.HERMITRIX_TOOTHROT_PH, 10, 1200) -- 20 minutes
    xi.mob.phOnDespawn(mob, ID.mob.WYRMWIX_SNAKESPECS_PH, 10, 1200) -- 20 minutes
    xi.mob.phOnDespawn(mob, ID.mob.JABBROX_GRANNYGUISE_PH, 10, 1200) -- 20 minutes
end
return entity
