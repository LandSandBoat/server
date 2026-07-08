-----------------------------------
-- Area: Caedarva Mire
--  Mob: Wild Karakul
-- Note: PH for Peallaidh
-----------------------------------
mixins = { require('scripts/mixins/families/chigoe_pet') }
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.PEALLAIDH, 5, 3600) -- 1 hour
end

return entity
