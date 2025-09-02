-----------------------------------
-- Ability: Radial Arcana
-- Causes your luopan to vanish and restores MP of party members within area of effect.
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.geomancer.geoOnAbilityCheck(player, target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, master, action)
    local mpAmount  = math.floor(3 * pet:getMainLvl())
    local mpRestore = mpAmount

    if master and master:getMerit(xi.merit.RADIAL_ARCANA) > 0 then
        mpRestore = mpRestore + (mpRestore * 0.03 * master:getMerit(xi.merit.RADIAL_ARCANA))
        if master:getMod(xi.mod.RADIAL_ARCANA) > 0 then
            mpRestore = mpRestore + (mpRestore * 0.05 * master:getMerit(xi.merit.RADIAL_ARCANA))
        end
    end

    mpRestore = utils.clamp(mpRestore, 0, target:getMaxMP())

    if target:getID() == pet:getID() then
        mpRestore = 0
    end

    target:addMP(mpRestore)

    pet:timer(200, function(mobArg)
        mobArg:setHP(0)
    end)

    return mpRestore
end

return abilityObject
