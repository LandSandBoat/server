-----------------------------------
-- Nocturnal Combustion
-- Family: Bombs (Djinn)
-- Description: Self-destructs, dealing Dark damage to targets around mob.
-- Notes:
-- * Damage is based on remaining HP and time of day (more damaging near midnight).
-- * The djinn will not use this until it has been affected by the current day's element.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
     -- TODO: Not unlocked for use unless mob is hit with elemental damage that matches day of week.
     -- Does not seem to be gated by HP threshholds.
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = skill:getMobHP() / 3
    params.fTP            = { 1, 1, 1 }
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

     -- TODO: Time of day scaling
     -- Damage seems to reach max power around 00:00 - 01:00.
     -- https://discord.com/channels/443544205206355968/443894311881408522/1438487786306142231

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
