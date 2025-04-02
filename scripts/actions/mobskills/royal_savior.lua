-----------------------------------
-- Royal Savior
-- Grants effects of Sentinel and Stoneskin
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- Unsure if this is the correct value for enmity gain. The Wikis say it is stronger than Sentinel.
    -- Sentinel is 900, Provoke is 1800
    local power = 1300

    -- No data for how strong the stoneskin effect is from Royal Savior. Stoneskin cap is 350 without bonuses. This will make it 300 for level 99.
    local amount = mob:getMainLvl() * 3 + 3

    target:addEnmity(mob, 1, power)
    mob:addStatusEffect(xi.effect.STONESKIN, amount, 0, 300)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
