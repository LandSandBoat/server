-----------------------------------
-- Ability: Spectral jig
-- Allows you to evade enemies by making you undetectable by sight and sound.
-- Obtained: Dancer Level 25
-- TP Required: 0
-- Recast Time: 30 seconds
-- Duration: 3 minutes
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
   return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local baseDuration = 180 + player:getJobPointLevel(xi.jp.JIG_DURATION)
    local durationMultiplier = 1.0 + utils.clamp(player:getMod(xi.mod.JIG_DURATION), 0, 50) / 100
    local finalDuration = math.floor(baseDuration * durationMultiplier * xi.settings.SNEAK_INVIS_DURATION_MULTIPLIER)

    if (player:hasStatusEffect(xi.effect.SNEAK) == false) then
        player:addStatusEffect(xi.effect.SNEAK, 0, 10, finalDuration)
        player:addStatusEffect(xi.effect.INVISIBLE, 0, 10, finalDuration)
        ability:setMsg(xi.msg.basic.SPECTRAL_JIG) -- Gains the effect of sneak and invisible
    else
        ability:setMsg(xi.msg.basic.NO_EFFECT) -- no effect on player.
    end

    return 1
end

return ability_object
