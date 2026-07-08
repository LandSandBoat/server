-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Marid
-- Note: Place holder Mahishasura
-----------------------------------
mixins = { require('scripts/mixins/families/marid'), require('scripts/mixins/families/chigoe_pet') }
local ID = zones[xi.zone.BHAFLAU_THICKETS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.MAHISHASURA, 15, 10800) -- 3 hours
end

return entity
