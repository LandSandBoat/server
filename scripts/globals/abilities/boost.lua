-----------------------------------
-- Ability: Boost
-- Enhances user's next attack.
-- Obtained: Monk Level 5
-- Recast Time: 0:15
-- Duration: 3:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local power = 12.5 + (0.10 * player:getMod(xi.mod.BOOST_EFFECT))

    if (player:hasStatusEffect(xi.effect.BOOST) == true) then
        local effect = player:getStatusEffect(xi.effect.BOOST)
        effect:setPower(effect:getPower() + power)
        player:addMod(xi.mod.ATTP, power)
    else
        player:addStatusEffect(xi.effect.BOOST, power, 0, 180)
    end
end

return ability_object
