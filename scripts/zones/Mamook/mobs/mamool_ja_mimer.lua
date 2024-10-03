-----------------------------------
-- Area: Mamook
--  Mob: Mamool Ja Mimer
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.weapon_break)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
