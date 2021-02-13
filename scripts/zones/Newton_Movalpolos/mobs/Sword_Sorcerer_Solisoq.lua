-----------------------------------
-- Area: Newton Movalpolos
--   NM: Sword Sorcerer Solisoq
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 249)
end

return entity
