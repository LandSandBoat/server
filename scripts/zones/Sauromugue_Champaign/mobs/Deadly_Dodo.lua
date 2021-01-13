-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Deadly Dodo
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 272)
end

return entity
