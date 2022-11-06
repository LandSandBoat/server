-----------------------------------
-- Area: North Gustaberg [S]
--   NM: Olgoi-Khorkhoi
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 499)
end

return entity
