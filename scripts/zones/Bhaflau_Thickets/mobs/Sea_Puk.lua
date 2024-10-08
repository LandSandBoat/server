-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Sea Puk
-- Note: Place holder Nis Puk
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_THICKETS]
mixins = { require('scripts/mixins/families/puk') }
-----------------------------------
---@type TMobEntity
local entity = {}

local nisPukPHTable =
{
    [ID.mob.NIS_PUK - 20] = ID.mob.NIS_PUK, -- -135 -18 -648
    [ID.mob.NIS_PUK - 19] = ID.mob.NIS_PUK, -- -104 -18 -636
    [ID.mob.NIS_PUK - 18] = ID.mob.NIS_PUK, -- -123 -16 -638
    [ID.mob.NIS_PUK - 12] = ID.mob.NIS_PUK, -- -106 -16 -613
    [ID.mob.NIS_PUK - 11] = ID.mob.NIS_PUK, -- -109 -15 -600
    [ID.mob.NIS_PUK - 10] = ID.mob.NIS_PUK, -- -128 -15 -602
    [ID.mob.NIS_PUK - 9]  = ID.mob.NIS_PUK, -- -132 -16 -612
    [ID.mob.NIS_PUK - 5]  = ID.mob.NIS_PUK, -- -119 -15 -651
}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.WIND_ABSORB, 100)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, nisPukPHTable, 5, 43200) -- 12 hours
end

return entity
