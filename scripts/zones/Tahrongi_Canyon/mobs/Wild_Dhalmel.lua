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

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 96, 2, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SERPOPARD_ISHTAR_PH, 10, 3600) -- 1 hour
end

return entity
