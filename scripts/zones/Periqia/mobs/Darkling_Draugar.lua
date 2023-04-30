-----------------------------------
-- Area: Periqia (Requiem)
--  Mob: Darkling Draugar
-----------------------------------
require("scripts/globals/assault")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.assault.progressInstance(mob, 1)
end

return entity
