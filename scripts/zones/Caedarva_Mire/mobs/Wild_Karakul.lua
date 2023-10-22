-----------------------------------
-- Area: Caedarva Mire
--  Mob: Wild Karakul
-- Note: PH for Peallaidh
-----------------------------------
mixins = { require('scripts/mixins/families/chigoe_pet') }
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.PEALLAIDH_PH, 5, 3600) -- 1 hour
end

return entity
