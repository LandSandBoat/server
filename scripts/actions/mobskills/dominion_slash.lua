-----------------------------------
-- Dominion Slash
-- Family: Humanoid (Ark Angel EV)
-- Description: Performs an area of effect slashing weaponskill. Additional Effect: Silence
-- Notes?: One source also mentions that it "can dispel important buffs."
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Can skillchain?  Unknown property.

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 3.25, 3.25, 3.25 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)

        local maccParams =
        {
            effectId       = xi.effect.NONE,
            magicalElement = xi.element.LIGHT,
            actorStat      = xi.mod.INT,
        }

        local resistRate = xi.combat.magicHitRate.calculateResistRate(mob, target, maccParams)

        if resistRate >= 0.5 then
            target:dispelStatusEffect()
        end
    end

    return info.damage
end

return mobskillObject
