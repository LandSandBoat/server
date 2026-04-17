-----------------------------------
-- Bloody Claw
-- Family: Gargouille
-- Description: Steals an enemy's HP. Additional Effect: Reduces a random stat.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() ~= 4 then -- TODO: Standardize mob spawn anim sub
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 3
    params.fTP            = { 0.9, 0.9, 0.9 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.HP, info.damage))

        -- Add 0 to 6 for all 7 of the possible attribute reductions
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN + math.random(0, 6), 20, 9, 120)
    end

    return info.damage
end

return mobskillObject
