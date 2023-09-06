-----------------------------------
-- Area: Phomiuna_Aqueducts
--  Mob: Fomor Beastmaster
-----------------------------------
mixins = { require('scripts/mixins/fomor_hate') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
