-----------------------------------------
-- ID: 18157
-- Item: Poison Arrow
-- Additional Effect: Poison
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 95
    if (target:getMainLvl() > player:getMainLvl()) then
        chance = chance - 5 * (target:getMainLvl() - player:getMainLvl())
        chance = utils.clamp(chance, 5, 95)
    end
    if (target:hasImmunity(256)) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    elseif (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, tpz.magic.ele.WATER, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:delStatusEffect(tpz.effect.POISON)
        if (not target:hasStatusEffect(tpz.effect.POISON)) then
            target:addStatusEffect(tpz.effect.POISON, 4, 3, 30)
        end
        return tpz.subEffect.POISON, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.POISON
    end
end
