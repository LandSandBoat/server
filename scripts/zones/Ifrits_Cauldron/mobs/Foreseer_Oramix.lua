-----------------------------------
-- Area: Ifrit's Cauldron
--   NM: Foreseer Oramix
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 399)
end

return entity
