-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Marid
-- Note: Place holder Mahishasura
-----------------------------------
mixins = { require('scripts/mixins/families/marid'), require('scripts/mixins/families/chigoe_pet') }
local ID = zones[xi.zone.BHAFLAU_THICKETS]
-----------------------------------
local entity = {}

local mahishasuraPHTable =
{
    [ID.mob.MAHISHASURA - 10] = ID.mob.MAHISHASURA, -- 215.000 -18.000 372.000
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, mahishasuraPHTable, 5, 10800) -- 3 hours
end

return entity
