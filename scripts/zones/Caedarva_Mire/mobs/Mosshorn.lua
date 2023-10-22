-----------------------------------
-- Area: Caedarva Mire
--  Mob: Mosshorn
-----------------------------------
mixins = { require('scripts/mixins/families/chigoe_pet') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
