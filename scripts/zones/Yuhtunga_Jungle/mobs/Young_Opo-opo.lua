-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Young Opo-opo
-- Note: PH for Mischievous Micholas
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 126, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 128, 1, tpz.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.MISCHIEVOUS_MICHOLAS_PH, 20, 3600) -- 1 hour
end

return entity
