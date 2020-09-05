-----------------------------------------
-- ID: 18306, 18307, 18644, 18658, 18672, 19753, 19846, 20880, 20881, 21808
-- Item: Apocalypse
-- Additional Effect: Blindness
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 10

    -- if (target:hasImmunity(64)) then
        -- spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    -- This does nothing, as this is not a spell, and it doesn't get used in the return.
    -- That should be handled in the resist check in the global anyways.

    if math.random(100) <= chance and applyResistanceAddEffect(player, target, tpz.magic.ele.DARK, 0) > 0.5 then
        target:addStatusEffect(tpz.effect.BLINDNESS, 15, 0, 30)
        return tpz.subEffect.BLIND, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.BLINDNESS
    end

    return 0, 0, 0
end
