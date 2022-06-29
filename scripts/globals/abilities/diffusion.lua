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
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if player:hasStatusEffect(xi.effect.DIFFUSION) then
        return xi.msg.basic.EFFECT_ALREADY_ACTIVE, 0
    end
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.DIFFUSION, 1, 0, 60)

    return xi.effect.DIFFUSION
end

return ability_object
