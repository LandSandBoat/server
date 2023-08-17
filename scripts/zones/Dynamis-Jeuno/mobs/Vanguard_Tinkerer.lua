-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Vanguard Tinkerer
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Dynamis-Jeuno/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.TYMEXOX_NINEFINGERS_PH, 10, 1200) -- 20 minute cooldown and 10% lottery chance values ASSUMED same as Dynamis-Beaucedine/Xarcabard, needs final verification
end

return entity
