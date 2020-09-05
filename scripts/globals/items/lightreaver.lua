-----------------------------------------
-- ID: 20858
-- Item: Lightreaver
-- Additional Effect: DEATH
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    -- AddEffect Death does not Proc on Notorious Monsters
    if (target:isMob()) then
        if (target:isMobType(MOBTYPE_NOTORIOUS)) then
            return 0, 0, 0
        end
    end

    -- Now continue with normal resistance and random number checks..
    local procRate = 3
    if (procRate <= math.random(1, 100) or applyResistanceAddEffect(player, target, tpz.magic.ele.DARK, 0) <= 0.5) then
        -- If random number beats procRate OR if effect is resisted, return all zero
        return 0, 0, 0
    else
        -- It's clobberin time!
        target:setHP(0)
        return tpz.subEffect.DEATH, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.KO
    end
end
