-----------------------------------
-- Area: Fei'Yin
--  Mob: Specter
-- Note: PH for N/E/S/W Shadow NMs
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 712, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.NORTHERN_SHADOW, 5, 57600) -- 16 hours
    xi.mob.phOnDespawn(mob, ID.mob.EASTERN_SHADOW, 5, 36000) -- 10 hours
    xi.mob.phOnDespawn(mob, ID.mob.WESTERN_SHADOW, 5, 36000) -- 10 hours
    xi.mob.phOnDespawn(mob, ID.mob.SOUTHERN_SHADOW, 5, 57600) -- 16 hours
end

return entity
