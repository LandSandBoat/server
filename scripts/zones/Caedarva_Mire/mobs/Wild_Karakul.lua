-----------------------------------
-- Area: Caedarva Mire
--  Mob: Wild Karakul
-- Note: PH for Peallaidh
-----------------------------------
mixins =
{
    require('scripts/mixins/families/chigoe_pet'),
    require('scripts/mixins/sleep_at_night'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, zones[xi.zone.CAEDARVA_MIRE].mob.PEALLAIDH, 5, 3600) -- 1 hour
end

return entity
