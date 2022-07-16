-----------------------------------
-- Area: Ifrits Cauldron
--   NM: Vouivre
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGEN, 50)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 402)
end

return entity
