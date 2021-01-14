-----------------------------------
-- Area: Batallia Downs [S]
--   NM: Burlibix Brawnback
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:addMod(tpz.mod.STUNRES, 50)
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 494)
end

return entity
