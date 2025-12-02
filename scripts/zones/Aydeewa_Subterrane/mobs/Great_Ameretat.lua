-----------------------------------
-- Area: Aydeewa Subterrane
--  Mob: Great Ameretat
-----------------------------------
mixins = { require('scripts.mixins.families.morbol_toau') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobMobskillChoose = function(mob, target)
    return target:countEffectWithFlag(xi.effectFlag.DISPELABLE) > 0 and xi.mobSkill.VAMPIRIC_ROOT or 0
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
