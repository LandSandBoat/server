-----------------------------------
-- Area: Beaucedine Glacier [S]
--  Mob: Gargouille
-- Note: PH for Grand'Goule
-----------------------------------
local ID = zones[xi.zone.BEAUCEDINE_GLACIER_S]
mixins = { require('scripts/mixins/families/gargouille') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.GRANDGOULE_PH, 10, 3600) -- 1 hour
end

return entity
