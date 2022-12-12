-----------------------------------
-- Area: Batallia Downs [S]
--   NM: Burlibix Brawnback
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.STUN_MEVA, 50)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 494)
end

return entity
