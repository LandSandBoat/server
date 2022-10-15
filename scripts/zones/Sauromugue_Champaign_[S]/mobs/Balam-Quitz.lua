-----------------------------------
-- Area: Sauromugue Champaign [S]
--   NM: Balam-Quitz
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 529)
end

return entity
