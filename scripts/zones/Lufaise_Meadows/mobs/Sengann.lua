-----------------------------------
-- Area: Lufaise Meadows
--  Mob: Sengann
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/fomor_hate") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 441)
end

return entity
