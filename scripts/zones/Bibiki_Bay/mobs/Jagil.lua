-----------------------------------
-- Area: Bibiki Bay
--  Mob: Jagil
-- Note: PH for Serra
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.SERRA_PH, 10, 3600) -- 1 hour
end

return entity
