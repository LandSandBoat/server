-----------------------------------
-- Area: Oldton Movalpolos
--  Mob: Bugbear Bondman
-- Note: PH for Bugbear Strongman
-----------------------------------
local ID = require("scripts/zones/Oldton_Movalpolos/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BUGBEAR_STRONGMAN_PH, 10, 1) -- no cooldown
end

return entity
