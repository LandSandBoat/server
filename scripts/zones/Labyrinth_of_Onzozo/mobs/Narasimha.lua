----------------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Narasimha
----------------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 299)
end

return entity
