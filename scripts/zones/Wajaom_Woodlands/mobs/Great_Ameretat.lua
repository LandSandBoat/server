-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Great Ameretat
-- Note: PH for Jaded Jody
-----------------------------------
mixins = { require('scripts.mixins.families.morbol_toau') }
local ID = zones[xi.zone.WAJAOM_WOODLANDS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobMobskillChoose = function(mob, target)
    return target:countEffectWithFlag(xi.effectFlag.DISPELABLE) > 0 and xi.mobSkill.VAMPIRIC_ROOT or 0
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.JADED_JODY, 10, 7200) -- 2 hours
end

return entity
