-----------------------------------
-- Area: Gustav Tunnel
--   NM: Ungur
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

-- TODO: Set multiple spawn points for PH

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 475)
end

return entity
