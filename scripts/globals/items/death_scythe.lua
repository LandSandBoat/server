-----------------------------------
-- ID: 16777
-- Item: Death Scythe
-- Additional Effect: Drains HP
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 10

    if (math.random(0, 99) >= chance) then
        return 0, 0, 0
    else
        local power = 10
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        power = addBonusesAbility(player, xi.magic.ele.DARK, target, power, params)
        power = power * applyResistanceAddEffect(player, target, xi.magic.ele.DARK, 0)
        power = adjustForTarget(target, power, xi.magic.ele.DARK)
        power = finalMagicNonSpellAdjustments(player, target, xi.magic.ele.DARK, power )

        if (power < 0) then
            power = 0
        else
            player:addHP(power)
        end

        return xi.subEffect.HP_DRAIN, xi.msg.basic.ADD_EFFECT_HP_DRAIN, power
    end
end

return item_object
