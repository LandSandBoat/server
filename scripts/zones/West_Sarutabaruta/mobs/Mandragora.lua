-----------------------------------
-- Area: West Sarutabaruta
--  Mob: Mandragora
-- Note: PH for Tom Tit Tat
-----------------------------------
local ID = zones[xi.zone.WEST_SARUTABARUTA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_H2H_PENALTY, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 26, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    -- Currently, this will look up both Tom Tit Tats to try to spawn them
    xi.mob.phOnDespawn(mob, ID.mob.TOM_TIT_TAT[1], 10, math.randomInt(3600, 7200)) -- 1 to 2 hours
end

return entity
