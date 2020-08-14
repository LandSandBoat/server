-----------------------------------------
-- ID: 16509
-- Item: Aspir Knife
-- Additional effect: MP Drain
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 10

    if (math.random(0, 99) >= chance or target:isUndead()) then
        return 0, 0, 0
    else
        local drain = math.random(1, 3)
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        -- drain = addBonusesAbility(player, tpz.magic.ele.DARK, target, drain, params)
        drain = drain * applyResistanceAddEffect(player, target, tpz.magic.ele.DARK, 0)
        drain = adjustForTarget(target, drain, tpz.magic.ele.DARK)
        drain = finalMagicNonSpellAdjustments(player, target, tpz.magic.ele.DARK, drain)

        if (drain > target:getMP()) then
            drain = target:getMP()
        end

        target:addMP(-drain)
        return tpz.subEffect.MP_DRAIN, tpz.msg.basic.ADD_EFFECT_MP_DRAIN, player:addMP(drain)
    end
end
