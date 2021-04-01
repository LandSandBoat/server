-----------------------------------
-- Ability: Meditate
-- Gradually charges TP.
-- Obtained: Samurai Level 30
-- Recast Time: 3:00 (Can be reduced to 2:30 using Merit Points)
-- Duration: 15 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local amount = 12
    if (player:getMainJob() == xi.job.SAM) then
        amount = 20
    end
    local duration = 15 + player:getMod(xi.mod.MEDITATE_DURATION)
    player:addStatusEffectEx(xi.effect.MEDITATE, 0, amount, 3, duration)
end

return ability_object
