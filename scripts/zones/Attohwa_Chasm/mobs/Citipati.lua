-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Citipati
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 278)
end

return entity
