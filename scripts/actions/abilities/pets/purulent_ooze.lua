-----------------------------------
-- Generic jug pet skill
-- TODO: verify functionality with regards to jug pet differences from regular mobs
-----------------------------------
---@type TAbilityPet
local abilityObject = {}
local skillName = 'purulent_ooze'

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0
end

abilityObject.onPetAbility = function(target, pet, petskill, owner, action)
    local result = xi.actions.mobskills[skillName].onMobWeaponSkill(target, pet, petskill)

    return result
end

return abilityObject
