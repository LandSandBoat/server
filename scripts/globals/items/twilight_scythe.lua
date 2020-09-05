-----------------------------------------
-- ID: 18551
-- Item: Twilight Scythe
-- Additional Effect: DEATH
-- TODO: Enchantment: Non-elemental
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 3

    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, tpz.magic.ele.DARK, 0) <= 0.5) then
        return 0, 0, 0
    elseif (target:isMob()) then
        if (target:isMobType(MOBTYPE_NOTORIOUS)) then
            return 0, 0, 0
        else
            target:setHP(0)
            return tpz.subEffect.DEATH, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.KO
        end
    else
        target:setHP(0)
        return tpz.subEffect.DEATH, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.KO
    end
end
