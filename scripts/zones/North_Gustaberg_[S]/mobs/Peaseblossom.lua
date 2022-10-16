-----------------------------------
-- Area: North Gustaberg [S]
--   NM: Peaseblossom
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 501)
end

return entity
