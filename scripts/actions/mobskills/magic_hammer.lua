-----------------------------------
-- Magic Hammer
-- Family: Poroggos
-- Description: Steals an amount of enemy's MP equal to damage dealt. Ineffective against undead.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Verify message
    params.baseDamage      = mob:getMainLvl()
    params.fTP             = { 2.0, 2.0, 2.0 }
    params.element         = xi.element.LIGHT
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.LIGHT
    params.shadowBehavior  = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.dStatMultiplier = 1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        -- Note: This deals damage + an MP Drain. The messaging shows damage done to the player.

        -- TODO: What happens if the primary damage is absorbed(If it is subject to absorbs)? Does it drain MP?
        -- If it still drains MP after an absorb then the drain calculation is likely a seperate function from the damage.

        -- TODO: MP Drain might not be linked directly to damage dealt or may have other mechanics involved. See video capture below.
        -- Magic Hammer did 14 damage but drained 90 MP.
        -- https://youtu.be/Qy-i4KNMnWQ?t=276
        -- https://discord.com/channels/443544205206355968/791182054015762482/1128174532507729941
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local mpDrainRatio = info.damage * 0.10
        xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.MP, mpDrainRatio)
    end

    return info.damage
end

return mobskillObject
