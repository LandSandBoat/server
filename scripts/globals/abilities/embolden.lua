-----------------------------------
-- Ability: Embolden
-- Enhances the effects of the next enhancing magic spell you cast, but reduces effect duration.
-- Obtained: Rune Fencer Level 60
-- Recast Time: 10:00
-- Duration: 1:00 or first absorb
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability, action)
    target:addStatusEffect(xi.effect.EMBOLDEN, 0, 0, 60) -- effects handled in scripts/globals/spells/spell_enhancing.lua
end

return abilityObject
