-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Undead Toad
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
