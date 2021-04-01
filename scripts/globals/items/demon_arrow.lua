-----------------------------------
-- ID: 18159
-- Item: Demon Arrow
-- Additional Effect: 12% Attack Down
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 95
    if (target:getMainLvl() > player:getMainLvl()) then
        chance = chance - 5 * (target:getMainLvl() - player:getMainLvl())
        chance = utils.clamp(chance, 5, 95)
    end
    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, xi.magic.ele.WATER, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:delStatusEffect(xi.effect.ATTACK_BOOST)
        target:addStatusEffect(xi.effect.ATTACK_DOWN, 12, 0, 60)
        return xi.subEffect.DEFENSE_DOWN, xi.msg.basic.ADD_EFFECT_STATUS, xi.effect.ATTACK_DOWN
    end
end

return item_object
