-----------------------------------
-- Ability: Chocobo jig ii
-- Increases Movement Speed to party members within the area of effect.
-- Obtained: Dancer Level 70
-- TP Required: 0
-- Recast Time: 1:00
-- Duration: 2:00
-----------------------------------
require("scripts/globals/jobpoints")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    local baseDuration       = 120 + player:getJobPointLevel(xi.jp.JIG_DURATION)
    local durationMultiplier = 1.0 + utils.clamp(player:getMod(xi.mod.JIG_DURATION), 0, 50) / 100
    local finalDuration      = math.floor(baseDuration * durationMultiplier)

    -- TODO: Chocobo Jig will not override all types of weight effect. Find out which aren't overriden.
    if target:hasStatusEffect(xi.effect.WEIGHT) then
        target:delStatusEffect(xi.effect.WEIGHT)
    end

    target:addStatusEffect(xi.effect.QUICKENING, 20, 0, finalDuration)
end

return abilityObject
