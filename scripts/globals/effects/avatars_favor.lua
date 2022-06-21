-----------------------------------
-- xi.effect.AVATARS_FAVOR
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/avatars_favor")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    xi.avatarsFavor.applyAvatarsFavorAuraToPet(target, effect)
    xi.avatarsFavor.applyAvatarsFavorDebuffsToPet(target)
end

effect_object.onEffectTick = function(target, effect)
    -- Perform tick power upgrade to max
    if effect:getPower() < xi.avatarsFavor.skill317Index then
        effect:setPower(effect:getPower() + 1)
    end

    -- Cap power based on skill level
    if target:getSkillLevel(xi.skill.SUMMONING_MAGIC) < 187 and effect:getPower() > xi.avatarsFavor.skill186Index then
        effect:setPower(xi.avatarsFavor.skill186Index)
    elseif target:getSkillLevel(xi.skill.SUMMONING_MAGIC) < 317 and effect:getPower() > xi.avatarsFavor.skillDefaultIndex then
        effect:setPower(xi.avatarsFavor.skillDefaultIndex)
    end

    xi.avatarsFavor.applyAvatarsFavorAuraToPet(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    xi.avatarsFavor.removeAvatarsFavorAuraFromPet(target)
end

return effect_object
