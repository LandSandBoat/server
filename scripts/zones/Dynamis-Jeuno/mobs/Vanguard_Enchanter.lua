-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Vanguard Enchanter
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_JEUNO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.dynamis_beastmen)
    xi.applyMixins(mob, xi.mixins.job_special)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.HERMITRIX_TOOTHROT_PH, 10, 1200) -- 10% lottery chance and 20 minute cooldown values ASSUMED same as Dynamis-Beaucedine/Xarcabard, needs final verification
    xi.mob.phOnDespawn(mob, ID.mob.WYRMWIX_SNAKESPECS_PH, 10, 1200) -- 10% lottery chance and 20 minute cooldown values ASSUMED same as Dynamis-Beaucedine/Xarcabard, needs final verification
    xi.mob.phOnDespawn(mob, ID.mob.JABBROX_GRANNYGUISE_PH, 10, 1200) -- 10% lottery chance and 20 minute cooldown values ASSUMED same as Dynamis-Beaucedine/Xarcabard, needs final verification
end

return entity
