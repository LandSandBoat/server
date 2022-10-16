-----------------------------------
-- Area: South Gustaberg
--   NM: Leaping Lizzy
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 200)
end

return entity
