-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Mamool Ja Savant
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.families.mamool_ja)
    xi.applyMixins(mob, xi.mixins.weapon_break)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
