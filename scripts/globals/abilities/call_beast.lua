-----------------------------------
-- Ability: Call Beast
-- Calls a beast to fight by your side.
-- Obtained: Beastmaster Level 23
-- Recast Time: 5:00
-- Duration: Dependent on jug pet used.
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if player:getPet() ~= nil then
        return xi.msg.basic.ALREADY_HAS_A_PET, 0
    elseif not player:hasValidJugPetItem() then
        return xi.msg.basic.NO_JUG_PET_ITEM, 0
    elseif not player:canUseMisc(xi.zoneMisc.PET) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA, 0
    else
        local playerLevel = player:getMainLvl()
        local petId = player:getWeaponSubSkillType(xi.slot.AMMO)
        local petLevels = {}
        petLevels[21] = 23 -- SHEEP FAMILIAR
        petLevels[22] = 23 -- HARE FAMILIAR
        petLevels[23] = 23 -- CRAB FAMILIAR
        petLevels[24] = 23 -- COURIER CARRIE
        petLevels[25] = 23 -- HOMUNCULUS
        petLevels[26] = 28 -- FLYTRAP FAMILIAR
        petLevels[27] = 28 -- TIGER FAMILIAR
        petLevels[28] = 28 -- FLOWERPOT BILL
        petLevels[29] = 33 -- EFT FAMILIAR
        petLevels[30] = 33 -- LIZARD FAMILIAR
        petLevels[31] = 33 -- MAYFLY FAMILIAR
        petLevels[32] = 33 -- FUNGUAR FAMILIAR
        petLevels[33] = 38 -- BEETLE FAMILIAR
        petLevels[34] = 38 -- ANTLION FAMILIAR
        petLevels[35] = 43 -- MITE FAMILIAR
        petLevels[36] = 43 -- LULLABY MELODIA
        petLevels[37] = 43 -- KEENEARED STEFFI,
        petLevels[38] = 51 -- FLOWERPOT BEN
        petLevels[39] = 51 -- SABER SIRAVARDE
        petLevels[40] = 53 -- COLDBLOOD COMO
        petLevels[41] = 53 -- SHELLBUSTER OROB
        petLevels[42] = 53 -- VORACIOUS AUDREY
        petLevels[43] = 58 -- AMBUSHER ALLIE
        petLevels[44] = 63 -- LIFEDRINKER LARS
        petLevels[45] = 63 -- PANZER GALAHAD,
        petLevels[46] = 63 -- CHOPSUEY CHUCKY
        petLevels[47] = 75 -- AMIGO SABOTENDER

        if playerLevel < petLevels[petId] then
            return xi.msg.basic.NO_JUG_PET_ITEM, 0
        end
    end

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.pet.spawnPet(player, player:getWeaponSubSkillType(xi.slot.AMMO))
    player:removeAmmo()
    -- Briefly put the recastId for READY/SIC (102) into a recast state to
    -- toggle charges accumulating. 102 is the shared recast id for all jug
    -- pet abilities and for SIC when using a charmed mob.
    -- see sql/abilities_charges and sql_abilities
    player:addRecast(xi.recast.ABILITY, 102, 1)
end

return abilityObject
