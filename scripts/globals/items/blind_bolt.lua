-----------------------------------
-- ID: 18150
-- Item: Blind Bolt
-- Additional Effect: Blindness
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
    if (target:hasImmunity(64)) then
        return 0, 0, 0
    elseif (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, xi.magic.ele.DARK, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:delStatusEffect(xi.effect.BLINDNESS)
        if (not target:hasStatusEffect(xi.effect.BLINDNESS)) then
            target:addStatusEffect(xi.effect.BLINDNESS, 10, 0, 30)
        end
        return xi.subEffect.BLIND, xi.msg.basic.ADD_EFFECT_STATUS, xi.effect.BLINDNESS
    end
end

return item_object
