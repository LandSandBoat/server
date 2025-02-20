-----------------------------------
-- Glittering Ruby
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    --randomly give str/dex/vit/agi/int/mnd/chr (+12)
    local effects =
    {
        xi.effect.STR_BOOST,
        xi.effect.DEX_BOOST,
        xi.effect.VIT_BOOST,
        xi.effect.AGI_BOOST,
        xi.effect.INT_BOOST,
        xi.effect.MND_BOOST,
        xi.effect.CHR_BOOST,
    }

    local effectId    = utils.randomEntry(effects)
    local effectPower = math.random(12, 14)

    target:addStatusEffect(effectId, effectPower, 0, 90)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)

    return effectId
end

return mobskillObject
