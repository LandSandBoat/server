-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Lioumere
-----------------------------------
mixins = { require('scripts/mixins/families/antlion_ambush') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
