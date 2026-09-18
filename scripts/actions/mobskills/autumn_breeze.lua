-----------------------------------
-- Autumn Breeze
-- Family: Pixie
-- Description: Recovers HP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    --[[
    https://youtu.be/r7ogGoabgH0?t=1m58s
    https://youtu.be/a0Tqdl8_SY4?t=2m29s
    https://youtu.be/a0Tqdl8_SY4?t=5m22s
    https://youtu.be/m0XpjG6E1oc?t=58s
    https://youtu.be/m0XpjG6E1oc?t=5m52s
    belphoebe : 300 ish (310, 312, 294..)
    skuld     : 250 ish
    carabosse : 100-250 ish (lowest lv mob of the 3)
    ]]

    -- Note: JPWiki says may also give a regen effect.
    -- https://wiki.ffo.jp/html/24432.html

    local params = {}

    params.primaryMessage = xi.msg.basic.SELF_HEAL
    params.baseHeal       = math.randomInt(100, 400) -- TODO: Capture heal power. Most mobskills use mob's max HP.
    params.fTP =
    {
        { tp = 1000, modifier = 1.00 },
        { tp = 2000, modifier = 1.00 },
        { tp = 3000, modifier = 1.00 },
    }

    return xi.mobskills.mobHealMove(mob, target, skill, action, params)
end

return mobskillObject
