-----------------------------------
-- Area: Pashhow Marshlands
--   NM: Ni'Zho Bladebender
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 214)
    xi.regime.checkRegime(player, mob, 60, 1, xi.regime.type.FIELDS)
    xi.roe.onRecordTrigger(player, 257)
end

return entity
