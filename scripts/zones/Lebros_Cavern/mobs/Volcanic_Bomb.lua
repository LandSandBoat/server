-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Volcanic Bomb
-----------------------------------
require("scripts/globals/assault")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.assaultUtil.adjustMobLevel(mob)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
