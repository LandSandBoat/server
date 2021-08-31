-----------------------------------
-- Area: Gusgen Mines
--   NM: Asphyxiated Amsel
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 235)
end

return entity
