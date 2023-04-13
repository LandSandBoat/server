-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Citipati
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/claim_shield") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 278)
end

return entity
