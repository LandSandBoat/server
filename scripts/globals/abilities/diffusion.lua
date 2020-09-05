-----------------------------------
-- Ability: Diffusion
-- Grants the effect of your next support Blue Magic spell to party members within range.
-- Obtained: Blue Mage Level 75
-- Recast Time: 10:00
-- Duration: 1:00, or until the next blue magic spell is cast.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if player:hasStatusEffect(tpz.effect.DIFFUSION) then
        return tpz.msg.basic.EFFECT_ALREADY_ACTIVE, 0
    end
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:addStatusEffect(tpz.effect.DIFFUSION, 1, 0, 60)

    return tpz.effect.DIFFUSION
end
