-----------------------------------
-- Area: Davoi
--  Mob: Orcish Cursemaker
-- Note: PH for Hawkeyed Dnatbat
-----------------------------------
local ID = require("scripts/zones/Davoi/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.HAWKEYED_DNATBAT_PH, 10, 3600) -- 1 hour
end

return entity
