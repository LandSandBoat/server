-----------------------------------
-- Nether Blast
-- Family: Avatar (Diabolos)
-- Description: Deals Dark breath damage to a target.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: These values are pulled from JP Wiki: https://wiki.ffo.jp/html/4045.html
    -- Need retail captures as mob version may be different from summoned pets.

    params.baseDamage     = mob:getMainLvl()
    params.additiveDamage = { 10, 10, 10 }
    params.fTP            = { 5, 5, 5 }
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.BREATH
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    -- Diabolos Dynamis Tavnazia tosses nether blast for ~1k
    -- if skill:getID() == 1910 then
    --     params.fTP = { 10, 10, 10 }
    -- end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
