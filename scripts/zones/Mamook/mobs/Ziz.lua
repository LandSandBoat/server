-----------------------------------
-- Area: Mamook
--  Mob: Ziz
-- Note: PH for Zizzy Zillah
-----------------------------------
mixins = { require('scripts/mixins/families/ziz') }
local ID = zones[xi.zone.MAMOOK]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.ZIZZY_ZILLAH_PH, 5, 3600) -- 1 hour
end

return entity
