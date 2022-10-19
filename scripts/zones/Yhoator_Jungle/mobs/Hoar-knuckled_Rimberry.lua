-----------------------------------
-- Area: Yhoator Jungle
--   NM: Hoar-knuckled Rimberry
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/families/tonberry") }
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 368)
    xi.regime.checkRegime(player, mob, 133, 1, xi.regime.type.FIELDS)
end

return entity
