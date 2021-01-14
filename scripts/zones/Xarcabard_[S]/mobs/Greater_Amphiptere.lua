-----------------------------------
-- Area: Xarcabard [S]
--  Mob: Greater Amphiptere
-----------------------------------
mixins = {require("scripts/mixins/families/amphiptere")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
