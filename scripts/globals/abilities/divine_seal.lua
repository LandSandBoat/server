-----------------------------------
-- Ability: Divine Seal
-- Enhances the potency of the user's next healing spell.
-- Obtained: White Mage Level 15
-- Recast Time: 10:00
-- Duration: 1 Spell or 60 seconds, whichever occurs first.
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.DIVINE_SEAL, 1, 0, 60)
end

return ability_object
