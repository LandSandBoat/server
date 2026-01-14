-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Sea Puk
-- Note: Place holder Nis Puk
-----------------------------------
mixins = { require('scripts/mixins/families/puk') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.WIND_ABSORB, 100)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, zones[xi.zone.BHAFLAU_THICKETS].mob.NIS_PUK, 5, 43200) -- 12 hours
end

return entity
