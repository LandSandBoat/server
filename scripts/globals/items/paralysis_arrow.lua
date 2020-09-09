-----------------------------------------
-- ID: 18696
-- Item: Paralysis Arrow
-- Additional Effect: Paralysis (20 power)
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
    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, tpz.magic.ele.ICE, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:delStatusEffect(tpz.effect.PARALYSIS)
        if (not target:hasStatusEffect(tpz.effect.PARALYSIS)) then
            target:addStatusEffect(tpz.effect.PARALYSIS, 20, 0, 30)
        end
        return tpz.subEffect.PARALYSIS, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.PARALYSIS
    end
end
