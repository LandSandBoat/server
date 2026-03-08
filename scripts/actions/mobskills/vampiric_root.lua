-----------------------------------
-- Vampiric Root
-- Steals HP from a single target and absorbs positive status effects.
-- Type: Magical
-- Utsusemi/Blink absorb: 1 shadow
-- Range: Melee
-- Notes: (Unverified) If used against undead, it will simply do damage and not drain HP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Will only use vampiric root if there are buffs to steal
    return target:countEffectWithFlag(xi.effectFlag.DISPELABLE) > 0 and 0 or 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: This is a physical skill. Will fix in mobPhysicalMove() PR
    params.baseDamage     = mob:getWeaponDmg()
    params.fTP            = { 2.00, 2.00, 2.00 }
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS -- TODO: Capture shadowBehavior
    -- Note: Ignores PDIF

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.HP, info.damage))

        -- Absorb ALL positive status effects
        -- Note: Some sources claim this includes food and reraise which has been proven to be false
        local result = mob:stealStatusEffect(target)
        while result ~= 0 do
            result = mob:stealStatusEffect(target)
        end
    end

    return info.damage
end

return mobskillObject
