-----------------------------------
-- Area: Tahrongi Canyon
--  Mob: Wild Dhalmel
-- Note: PH for Serpopard Ishtar
-----------------------------------
local ID = require("scripts/zones/Tahrongi_Canyon/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 96, 2, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.SERPOPARD_ISHTAR_PH, 10, 3600) -- 1 hour
end

return entity
