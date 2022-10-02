-----------------------------------
-- Area: Lufaise_Meadows
--  Mob: Fomor Black Mage
-----------------------------------
mixins = { require("scripts/mixins/fomor_hate") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
