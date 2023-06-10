-----------------------------------
-- xi.effect.LEVEL_SYNC
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:levelRestriction(effect:getPower())

    if target:getObjType() == xi.objType.PC then
        target:clearTrusts()

        if xi.settings.map.DESPAWN_JUGPETS_BELOW_MINIMUM_LEVEL then
            local pet = target:getPet()
            local masterLevel = target:getMainLvl()

            if
                pet and
                pet:getObjType() == xi.objType.PET and
                target:isJugPet() and -- isJugPet checks m_PBaseEntity->PPet's check type, not the target's pet type.
                masterLevel < pet:getMinimumPetLevel()
            then
                target:despawnPet()
            end
        end
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:levelRestriction(0)
    target:disableLevelSync()
end

return effectObject
