-----------------------------------
-- Mine Blast
-- Family: Mines (Qiqirn Mine / Goblin Mine)
-- Description: AOE: Varies. 16' for Goblin Bombs in [S].
-- TODO: Behavior of mines varies, we may eventually want to split up to multiple files once captures are made.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 100, 100, 100 } -- TODO: Capture fTPs. (Varies by mob)
    params.element        = xi.element.FIRE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.FIRE
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    -- TODO: Cheese Hoarder Gigiroon Mines

    -- TODO: Qiqirn Mines

    -- TODO: Goblin mines in [S] zones

    -- TODO: Excavation Duty Assault

    -- TODO: Blifnix Oilycheek's Goblin Mines

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

mobskillObject.onMobSkillFinalize = function(mob, skill)
    mob:entityAnimationPacket('mai1') -- Animation: Mine jumps up and explodes.

    mob:setHP(0)
end

return mobskillObject
