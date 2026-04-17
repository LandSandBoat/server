-----------------------------------
-- Amon Drive
-- Family: Humanoid (AA TaruTaru)
-- Description: Performs an area of effect weaponskill. Additional Effect: Paralysis, Petrification, Poison
-- Notes: Special weaponskill unique to Ark Angel TT. Deals ~100-400 damage.
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
    params.fTP            = { 2.5, 2.5, 2.5 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 25, 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PETRIFICATION, 1, 0, math.random(8, 15) + mob:getMainLvl() / 3)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, math.ceil(mob:getMainLvl() / 5), 3, 60)
    end

    return info.damage
end

return mobskillObject
