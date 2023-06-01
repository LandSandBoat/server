-----------------------------------
-- Ability: Stay
-- Commands the Pet to stay in one place.
-- Obtained: Beastmaster Level 15
-- Recast Time: 5 seconds
-- Duration: Instant
-----------------------------------
require("scripts/globals/msg")
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
        -- reduce tick speed based on level. but never less than 5 and never
        -- more than 10.  This seems to mimic retail.  There is no formula
        -- that I can find, but this seems close.
        local level = 0
        if player:getMainJob() == xi.job.BST then
            level = player:getMainLvl()
        elseif player:getSubJob() == xi.job.BST then
            level = player:getSubLvl()
        end

        local tick = 10 - math.ceil(math.max(0, level / 20))

        pet:addStatusEffectEx(xi.effect.HEALING, 0, 0, tick, 0)
        pet:setAnimation(0)
    end
end

return abilityObject
