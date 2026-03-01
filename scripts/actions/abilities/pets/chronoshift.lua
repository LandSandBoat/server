-----------------------------------
-- Chronoshift
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local effectCount = 0
    local effectID    = pet:getLocalVar('aEffectID') or 0    -- Retrive the absorbed effect's ID
    local effect      = pet:getStatusEffect(effectID) or nil -- Find that effect on Atomos

    if effect then
        -- Delete old effect if on target already
        target:delStatusEffectSilent(effectID)
        -- Add the stolen effect to the party
        target:copyStatusEffect(effect)
        petskill:setMsg(xi.msg.basic.RECEIVE_MAGICAL_EFFECT)
        effectCount = 1
    else
        petskill:setMsg(xi.msg.basic.NO_EFFECT)
    end

    pet:timer(5000, function()
        if summoner then
            summoner:despawnPet()
        end
    end)

    return effectCount
end

return abilityObject
