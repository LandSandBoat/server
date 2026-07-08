-----------------------------------
-- Area: Mamook
--  Mob: Ziz
-- Note: PH for Zizzy Zillah
-----------------------------------
mixins = { require('scripts/mixins/families/ziz') }
local ID = zones[xi.zone.MAMOOK]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.ZIZZY_ZILLAH, 5, 3600) -- 1 hour
end

return entity
