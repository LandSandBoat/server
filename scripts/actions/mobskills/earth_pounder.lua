-----------------------------------
-- Earth Pounder
-- Family: Scorpions
-- Description: Deals Earth damage to enemies within area of effect. Additional Effect: DEX Down
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 2.0, 2.0, 2.0 }
    params.element        = xi.element.EARTH
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.EARTH
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    if mob:getPool() == xi.mobPool.PLATOON_SCORPION then
        local battlefield = mob:getBattlefield()
        local ftpPower = 0

        if battlefield then
            ftpPower = 2.0 + battlefield:getLocalVar('scorpionsDefeated') * 0.5
            params.fTP = { ftpPower, ftpPower, ftpPower }
        end
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Jimmayus Spreadsheet implies this scales with level. Need more captures to determine scaling formula.
        -- TODO: Capture decay rate. Many mobs use 9 second decay rate so using that for now.
        -- https://docs.google.com/spreadsheets/d/1YBoveP-weMdidrirY-vPDzHyxbEI2ryECINlfCnFkLI/edit?pli=1&gid=57955395#gid=57955395&range=A598
        local power = 10

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEX_DOWN, power, 9, 180)
    end

    return info.damage
end

return mobskillObject
