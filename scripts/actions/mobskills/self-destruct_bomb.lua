-----------------------------------
-- Self-Destruct
-- Family: Bombs
-- Description: Suicide Move. Deals damage to targets in range based on mob's remaining HP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if math.randomInt(1, 100) > 50 then -- A bomb will have a 25% chance to use Self-Destruct
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- Self Destruct does use the player's HP to determine the max damage it can do.  This means a player at 100% hp has a 25% chance to die if full damage is taken, given the bomb has enough HP.
    params.baseDamage         = math.min(target:getMaxHP() * math.randomFloat(0.7, 1.1), mob:getHP())
    params.fTP                = { 1.00, 1.00, 1.00 }
    params.element            = xi.element.FIRE
    params.attackType         = xi.attackType.BREATH
    params.damageType         = xi.damageType.FIRE
    params.skipMagicBonusDiff = true
    params.shadowBehavior     = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

mobskillObject.onMobSkillFinalize = function(mob, skill)
    mob:setHP(0)
end

return mobskillObject
