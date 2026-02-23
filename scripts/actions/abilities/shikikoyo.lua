-----------------------------------
-- Ability: Shikikoyo
-- Share TP above 1000 with a party member.
-- Obtained: Samurai Level 75
-- Recast Time: 5:00
-- Duration: Instant
-- Target: Party member, cannot target self.
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.samurai.checkShikikoyo(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.samurai.useShikikoyo(player, target, ability, action)
end

return abilityObject
