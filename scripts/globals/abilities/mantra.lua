-----------------------------------
-- Ability: Mantra
-- Increases the max. HP of party members within area of effect.
-- Obtainable: Monk Level 75
-- Recast Time: 0:10:00
-- Duration: 0:03:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:delStatusEffect(tpz.effect.MAX_HP_BOOST)

    local merits = player:getMerit(tpz.merit.MANTRA)

    target:addStatusEffect(tpz.effect.MAX_HP_BOOST, merits, 0, 180)

    return tpz.effect.MANTRA
end

return ability_object
