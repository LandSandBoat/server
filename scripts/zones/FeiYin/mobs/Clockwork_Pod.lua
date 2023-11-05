-----------------------------------
-- Area: FeiYin
--  Mob: Clockwork Pod
-- Note: PH for Mind Hoarder
-----------------------------------
require("scripts/globals/mobs")
local ID = require("scripts/zones/FeiYin/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.MIND_HOARDER_PH, 10, 5400) -- 1.5 hour minimum
end

return entity
