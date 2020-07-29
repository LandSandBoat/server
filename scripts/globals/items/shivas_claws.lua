-----------------------------------------
-- ID: 17492
-- Item: Shiva's Claws
-- Additional Effect: Paralyze
-- Author: Gweivyth
----------------------------------

require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")

-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 10

    if (VanadielDayElement() == tpz.day.ICEDAY) then
        chance = chance+6
    end

    if math.random(100) <= chance and applyResistanceAddEffect(player, target, tpz.magic.ele.ICE, 0) > 0.5 then
        target:addStatusEffect(tpz.effect.PARALYSIS, 10, 0, 30)
        return tpz.subEffect.PARALYSIS, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.PARALYSIS
    end

    return 0, 0, 0
end