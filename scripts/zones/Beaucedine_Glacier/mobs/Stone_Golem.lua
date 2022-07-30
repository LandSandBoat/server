-----------------------------------
-- Area: Beaucedine Glacier (111)
--  Mob: Stone Golem
-- Note: PH for Gargantua
-----------------------------------
local ID = require("scripts/zones/Beaucedine_Glacier/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.GARGANTUA_PH, 5, 1300) -- 30 minute minimum
end

return entity
