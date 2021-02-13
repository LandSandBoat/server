-----------------------------------
-- Area: Mamook
--   NM: Zizzy Zillah
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/families/ziz")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 460)
end

return entity
