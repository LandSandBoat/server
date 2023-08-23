-----------------------------------
-- xi.effect.AVATARS_FAVOR
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    xi.avatarsFavor.applyAvatarsFavorAuraToPet(target, effect)
    xi.avatarsFavor.applyAvatarsFavorDebuffsToPet(target)
end

effectObject.onEffectTick = function(target, effect)
    -- Perform tick power upgrade to max
    if effect:getPower() <= 11 then
        effect:setPower(effect:getPower() + 1)
    end

    local summoningSkill = target:getSkillLevel(xi.skill.SUMMONING_MAGIC)

    for i = 1, 7 do
        if
            summoningSkill <= xi.avatarsFavor.skillLevels[i] and
            effect:getPower() > i
        then
            effect:setPower(i)
            break
        elseif
            summoningSkill > 670 and
            effect:getPower() > 7
        then
            effect:setPower(7) -- Making sure we set a power if we are over 670 skill
        end
    end

    -- Applying gear bonus
    effect:setPower(effect:getPower() + target:getMaxGearMod(xi.mod.AVATARS_FAVOR_ENHANCE))

    -- TODO add Job Point Gift Bonus
    -- if GET PLAYERS JP TOTAL >= 550 then
    --    effect:setPower(effect:getPower() + 1)
    -- end

    xi.avatarsFavor.applyAvatarsFavorAuraToPet(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    xi.avatarsFavor.removeAvatarsFavorAuraFromPet(target)
end

return effectObject
