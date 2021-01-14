----------------------------------------
-- Area: Gustav Tunnel
--   NM: Taxim
----------------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 424)
end

return entity
