-----------------------------------
-- Ability: Stay
-- Commands the Pet to stay in one place.
-- Obtained: Beastmaster Level 15
-- Recast Time: 5 seconds
-- Duration: Instant
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if player:getPet() == nil then
        return xi.msg.basic.REQUIRES_A_PET, 0
    end

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability, action)
    local pet = player:getPet()

    if not pet:hasPreventActionEffect() then
        local tick = 0
        -- Pets gradually regaining HP out of combat added in ToAU.
        if xi.settings.main.ENABLE_TOAU == 1 then
            tick = 10
        end

        pet:addStatusEffectEx(xi.effect.HEALING, 0, 0, tick, 0)
        pet:setAnimation(0)
    end
end

return abilityObject
