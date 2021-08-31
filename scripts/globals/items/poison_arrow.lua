-----------------------------------
-- ID: 18157
-- Item: Poison Arrow
-- Additional Effect: Poison
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
    if (target:hasImmunity(256)) then
        -- TODO: spell is nil here
        -- spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    elseif (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, xi.magic.ele.WATER, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:delStatusEffect(xi.effect.POISON)
        if (not target:hasStatusEffect(xi.effect.POISON)) then
            target:addStatusEffect(xi.effect.POISON, 4, 3, 30)
        end
        return xi.subEffect.POISON, xi.msg.basic.ADD_EFFECT_STATUS, xi.effect.POISON
    end
end

return item_object
