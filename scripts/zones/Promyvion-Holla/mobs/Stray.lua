-----------------------------------
-- Area: Promyvion-Holla
--   NM: Stray
-----------------------------------
require("scripts/globals/promyvion")
mixins = { require("scripts/mixins/families/empty") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.promyvion.strayOnSpawn(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
