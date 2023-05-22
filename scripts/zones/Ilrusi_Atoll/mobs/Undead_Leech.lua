-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Undead Leech
-----------------------------------
require("scripts/globals/assault")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.assault.progressInstance(mob, 1)
end

return entity
