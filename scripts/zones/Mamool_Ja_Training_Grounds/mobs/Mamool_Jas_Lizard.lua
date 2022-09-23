-----------------------------------
-- Area: Mamool Ja Training Grounds (Imperial Agent Rescue)
--  MOB: Mamool Ja Lizard
-----------------------------------
require("scripts/globals/assault")
-----------------------------------

local entity = {}

entity.onMobSpawn = function(mob)
    xi.assaultUtil.adjustMobLevel(mob)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
