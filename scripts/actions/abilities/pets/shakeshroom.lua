-----------------------------------
-- Generic jug pet skill
-- TODO: verify functionality with regards to jug pet differences from regular mobs
-----------------------------------
---@type TAbilityPet
local abilityObject = {}
local skillName = 'shakeshroom'

abilityObject.onAbilityCheck = function(player, target, ability)
    local pet = player:getPet()
    local checkResult = xi.actions.mobskills[skillName].onMobSkillCheck(target, pet, ability)
    if checkResult ~= 0 then
        return xi.msg.basic.PET_CANNOT_DO_ACTION, 0 -- TODO: verify exact message in packet.
    end

    return 0
end

abilityObject.onPetAbility = function(target, pet, petskill, owner, action)
    local result = xi.actions.mobskills[skillName].onMobWeaponSkill(target, pet, petskill)

    return result
end

return abilityObject
