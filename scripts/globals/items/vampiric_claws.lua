-----------------------------------
-- ID: 17510
-- Item: Vampiric Claws
-- Additional effect: HP Drain
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 10

    if (math.random(0, 99) >= chance or target:isUndead()) then
        return 0, 0, 0
    else
        local drain = math.random(3, 15)
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        -- drain = addBonusesAbility(player, xi.magic.ele.DARK, target, drain, params)
        drain = drain * applyResistanceAddEffect(player, target, xi.magic.ele.DARK, 0)
        drain = adjustForTarget(target, drain, xi.magic.ele.DARK)
        drain = finalMagicNonSpellAdjustments(player, target, xi.magic.ele.DARK, drain)

        return xi.subEffect.HP_DRAIN, xi.msg.basic.ADD_EFFECT_HP_DRAIN, player:addHP(drain)
    end
end

return item_object
