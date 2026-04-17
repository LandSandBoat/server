-----------------------------------
-- Entangle (HP Drain Variant)
-- Family: Treant
-- Description: Deals physical damage to a single target. Additional Effect : Bind, HP Drain
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 3.0, 3.0, 3.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.HP, info.damage))

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 60)
    end

    return info.damage
end

return mobskillObject
