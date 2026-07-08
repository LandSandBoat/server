-----------------------------------
-- Generic jug pet skill
-- TODO: verify functionality with regards to jug pet differences from regular mobs
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    -- TODO implement this ability
    return xi.msg.basic.PET_CANNOT_DO_ACTION
end

return abilityObject
