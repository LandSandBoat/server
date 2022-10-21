-----------------------------------
-- Area: Aydeewa Subterrane
--   NM: Crystal Eater
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 463)
end

return entity
