-----------------------------------
-- Ability: Modus Veritas
-- Increases damage done by helix spells while lowering spell duration by 50%.
-- Obtained: Scholar Level 65
-- Recast Time: 3:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    local helix = target:getStatusEffect(xi.effect.HELIX)

    if helix ~= nil then
        local mvPower = helix:getSubPower()
        local resist  = applyResistanceAbility(player, target, xi.magic.ele.NONE, xi.skill.ELEMENTAL_MAGIC, 0)
        -- Doesn't work against NMs apparently
        if mvPower > 0 or resist < 0.25 or target:isNM() then -- Don't let Modus Veritas stack to prevent abuse
            ability:setMsg(xi.msg.basic.JA_MISS) --Miss
            return 0
        else
            -- Double power and halve remaining time
            local mvMerits           = player:getMerit(xi.merit.MODUS_VERITAS_DURATION)
            local durationMultiplier = 0.5 + (0.05 * mvMerits)
            mvPower = mvPower + 1

            local helixPower = helix:getPower() * 2 + (3 * player:getJobPointLevel(xi.jp.MODUS_VERITAS_EFFECT))
            local duration   = helix:getDuration()
            local remaining  = math.floor(helix:getTimeRemaining() / 1000) -- from milliseconds

            duration = (duration-remaining) + math.floor(remaining * durationMultiplier)
            helix:setSubPower(mvPower)
            helix:setPower(helixPower)
            helix:setDuration(duration * 1000) -- back to milliseconds
        end
    else
        ability:setMsg(xi.msg.basic.JA_NO_EFFECT_2) -- No effect
    end
end

return abilityObject
