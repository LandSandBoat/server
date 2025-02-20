-----------------------------------
-- Area: Mamook
--  Mob: Mamool Ja Philosopher
-----------------------------------
mixins = { require('scripts/mixins/families/mamool_ja'), require('scripts/mixins/weapon_break') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SEES_THROUGH_ILLUSION, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
