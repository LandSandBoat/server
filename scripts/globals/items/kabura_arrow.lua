-----------------------------------
-- ID: 17325
-- Item: Kabura Arrow
-- Additional Effect: Silence
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
    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, xi.magic.ele.WIND, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:delStatusEffect(xi.effect.SILENCE)
        if (not target:hasStatusEffect(xi.effect.SILENCE)) then
            target:addStatusEffect(xi.effect.SILENCE, 1, 0, 60)
        end
        return xi.subEffect.SILENCE, xi.msg.basic.ADD_EFFECT_STATUS, xi.effect.SILENCE
    end
end

return item_object
