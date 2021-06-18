-----------------------------------
-- Ability: Ignis
-- Increases resistance against ice and deals fire damage.
-- Obtained: Rune Fencer level 5
-- Recast Time: 0:05 (shared with all runes)
-- Duration: 5:00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)

    local runeList = player:getMaxRune()
    local runeCount = runeList.count

    if runeCount >= 3 then
        player:removeOldestRune()
    end

    target:addStatusEffect(xi.effect.IGNIS, 10, 0, 300)

    return xi.effect.IGNIS
end

return ability_object
