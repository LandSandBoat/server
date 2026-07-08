-----------------------------------
-- Area: Jugner Forest [S]
--  Mob: Decrepit Gnole
-----------------------------------
mixins = { require('scripts/mixins/families/gnole') }
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.mob.phOnDespawn(mob, ID.mob.VOIRLOUP, 10, 60 * 60 * 2) -- 2 hours, guessed
end

return entity
