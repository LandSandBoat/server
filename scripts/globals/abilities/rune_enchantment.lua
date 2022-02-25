-----------------------------------
-- Ability: Rune Enchantment
-- Allows you to harbor runes
-- Obtained: Rune Fencer Level 5
-- Recast Time: 0:05
-- Duration: 5:00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

--this is a dummied ability that is not actually usable by a player due to Rune Enchantment only being the main category in a menu, as well as the name of the ability for recast.
ability_object.onUseAbility = function(user, target, ability)
    -- Leave blank.
end

return ability_object
