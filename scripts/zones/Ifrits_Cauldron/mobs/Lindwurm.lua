-----------------------------------
-- Area: Ifrits Cauldron
--   NM: Lindwurm
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 401)
end

return entity
