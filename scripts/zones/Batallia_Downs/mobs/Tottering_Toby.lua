-----------------------------------
-- Area: Batallia Downs (105)
--  Mob: Tottering Toby
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 161)
end

return entity
