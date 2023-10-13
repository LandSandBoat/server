-----------------------------------
-- Area: Mamook
--   NM: Zizzy Zillah
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/families/ziz") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.SLEEP)
    mob:setMod(xi.mod.REGAIN, 350)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 460)
end

return entity
