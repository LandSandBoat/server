-----------------------------------
-- Daybreak
-- Family: Humanoid (August)
-- Description: 1 min 30 sec duration, 1 min 30 sec cooldown after either No quater used or daybreak wears off
-- When August's HP drops below 66%, he uses Daybreak if it's available which partially restores some HP and MP,
-- resets his TP, and activates an aura with wings of light
-- Daybreak is a -50% PDT effect, full Erase
-- Daybreak is removed after the use of No Quarter.
-- Type: Magical
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 7, 7, 7 }
    params.element        = xi.element.LIGHT
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.LIGHT
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    local hpHeal = mob:getMainLvl() * 7
    local mpHeal = mob:getMainLvl() * 7

    mob:eraseAllStatusEffect() -- erase all negetive effects
    mob:addHP(hpHeal) -- restore hp
    mob:addMP(mpHeal) -- restore mp
    mob:setMod(xi.mod.DMGPHYS, -5000) -- Phyisical damage taken -50%
    mob:setTP(0) -- daybreak uses all tp, so set to 0
    mob:setLocalVar('DaybreakUsed', 1)

    skill:setFinalAnimationSub(5)

    return info.damage
end

return mobskillObject
