-----------------------------------
-- Area: Ifrits Cauldron
--   NM: Vouivre
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 402)
end

return entity
