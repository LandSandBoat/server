-----------------------------------
-- Generic jug pet skill
-- 50% ATTP, -50% DEFP for 4 (0 TP) to 9 (3000 TP) minutes
-----------------------------------
---@type TAbilityPet
local abilityObject = {}
local skillName = 'rage'

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0
end

abilityObject.onPetAbility = function(target, pet, petskill, owner, action)
    -- TODO: Either the mobskill below is wrong or the Ready move is customized.
    -- Should grant a stackable BERSERK effect of 50%/-50% for 4 to 9 minutes depending on TP.
    local result = xi.actions.mobskills[skillName].onMobWeaponSkill(target, pet, petskill)

    return result
end

return abilityObject
