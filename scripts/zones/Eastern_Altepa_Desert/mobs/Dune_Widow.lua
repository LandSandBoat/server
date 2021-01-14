----------------------------------------
-- Area: Eastern Altepa Desert (114)
--   NM: Dune Widow
----------------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 408)
end

return entity
