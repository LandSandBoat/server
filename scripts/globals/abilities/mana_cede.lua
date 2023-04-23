-----------------------------------
-- Ability: Mana Cede
-- Description: Channels your MP into TP for avatars and elementals.
-- Obtained: SMN Level 87
-- Recast Time: 00:05:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    local playerMP = player:getMP()
    local avatar   = player:getPet()

    -- Retail only checks if you have an avatar summoned, but we can do better.
    -- Actual behavior: Ability can still be used at 3000 TP and < 100 MP.
    -- Results in player expending the rest of their MP and subsequently dismissing avatar.
    if avatar ~= nil then
        local avatarTP = avatar:getTP()
        if avatarTP == 3000 or playerMP < 100 then
            return xi.msg.basic.UNABLE_TO_USE_JA, 0
        end
    elseif avatar == nil then
        return xi.msg.basic.REQUIRES_A_PET, 0
    end
end

abilityObject.onUseAbility = function(player, target, ability, action)
    xi.job_utils.summoner.useManaCede(player, ability, action)
end

return abilityObject
