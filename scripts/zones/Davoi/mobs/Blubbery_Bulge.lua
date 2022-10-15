-----------------------------------
-- Area: Davoi
--   NM: Blubbery Bulge
-- Involved in Quest: The Miraculous Dale
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 196)
end

return entity
