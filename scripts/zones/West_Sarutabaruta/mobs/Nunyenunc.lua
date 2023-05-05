-----------------------------------
-- Area: West Sarutabaruta (115)
--   NM: Nunyenunc
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.LIGHT_MEVA, 50)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 251)
    xi.roe.onRecordTrigger(player, 265)
end

return entity
