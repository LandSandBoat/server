-----------------------------------
-- Triclip
-- Family: Tauri
-- Description: Delivers a threefold attack. Additional Effect: DEX Down
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 3
    params.fTP            = { 0.5, 0.5, 0.5 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3
    -- TODO: Possible accuracy modifier

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- Power is 10 at 1000 TP, 20 at 3000 TP
        local power = 5 + math.floor(skill:getTP() / 200)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEX_DOWN, power, 9, 90)
    end

    return info.damage
end

return mobskillObject
