-----------------------------------
-- Ability: Chocobo jig ii
-- Increases Movement Speed to party members within the area of effect.
-- Obtained: Dancer Level 70
-- TP Required: 0
-- Recast Time: 1:00
-- Duration: 2:00
-----------------------------------
 require("scripts/globals/settings")
require("scripts/globals/status")

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local baseDuration = 120
    local durationMultiplier = 1.0 + utils.clamp(player:getMod(tpz.mod.JIG_DURATION), 0, 50) / 100
    local finalDuration = math.floor(baseDuration * durationMultiplier)

    target:addStatusEffect(tpz.effect.QUICKENING, 20, 0, finalDuration)
end
