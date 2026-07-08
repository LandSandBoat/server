-----------------------------------
-- Royal Savior
-- [Hero's Combat BCNM] Grants effect of Protect
-- [Trust] Grants defence boost, palisade effect and stoneskin
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local effect = xi.effect.NONE

    if mob:isTrust() then
        local effectDuration = 60
        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 50, 0, effectDuration))
        mob:addStatusEffect(xi.effect.PALISADE, { power = 30, duration = effectDuration, origin = mob })
        mob:addStatusEffect(xi.effect.STONESKIN, { power = utils.clamp(math.floor(mob:getMaxHP() / 10), 10, 200) , duration = effectDuration, origin = mob })
        effect = xi.effect.DEFENSE_BOOST
        mob:setTP(0)
    else
        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.PROTECT, 175, 0, 300))
        effect = xi.effect.PROTECT
    end

    return effect
end

return mobskillObject
