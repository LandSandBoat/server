-----------------------------------
-- Area: Newton Movalpolos
--   NM: Sword Sorcerer Solisoq
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 249)
end

return entity
