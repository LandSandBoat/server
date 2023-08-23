-----------------------------------
-- xi.effect.LEVEL_RESTRICTION
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if target:getObjType() == xi.objType.PC then
        target:levelRestriction(effect:getPower())
        target:messageBasic(xi.msg.basic.LEVEL_IS_RESTRICTED, effect:getPower()) -- <target>'s level is restricted to <param>
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
    if target:getObjType() == xi.objType.PC then
        target:levelRestriction(0)
    end
end

return effectObject
