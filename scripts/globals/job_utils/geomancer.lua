-----------------------------------
-- Geomancer Job Utilities
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/pets")
require("scripts/globals/weaponskills")
require("scripts/globals/jobpoints")
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.geomancer = xi.job_utils.geomancer or {}
-----------------------------------

xi.job_utils.geomancer.geoOnAbilityCheck = function(player, target, ability)
    if player:getPetID() == xi.pet.id.LUOPAN then
        return 0,0
    end
    return xi.msg.basic.REQUIRE_LUOPAN, 0
end

xi.job_utils.geomancer.geoOnMagicCastingCheck = function(caster, target, spell)
    if caster:getPetID() == xi.pet.id.LUOPAN then
        return xi.msg.basic.LUOPAN_ALREADY_PLACED
    elseif not caster:canUseMisc(xi.zoneMisc.PET) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    else
        return 0
    end
end

-----------------------------------
-- duration:   Length of the aura effect, not ticks of the aura's effect
--             0 = does not wear off
-- tickEffect: The effect being granted/imposed by the aura
--             Use xi.effect table: xi.effect.GEO_POISON for example,
--               but doesn't _need_ to be a GEO_ effect)
-- tickPower:  The power of the tick (healing amount, damage amount, etc.)
-- targetType: Target allies or enemies with:
--             xi.auraTarget.ALLIES or xi.auraTarget.ENEMIES
-----------------------------------
xi.job_utils.geomancer.addAura = function(target, duration, tickEffect, tickPower, targetType)
    target:addStatusEffectEx(xi.effect.COLURE_ACTIVE, xi.effect.COLURE_ACTIVE, 0, 3, duration, tickEffect, tickPower, targetType, xi.effectFlag.AURA)
end

-- TODO: After elements are aligned in the codebase, this should become:
-- xi.job_utils.geomancer.spawnLuopan = function(player, target, spell, tickEffect, tickPower, targetType)
xi.job_utils.geomancer.spawnLuopan = function(player, target, modelID, tickEffect, tickPower, targetType, spell)
    if target then
        xi.pet.spawnPet(player, xi.pet.id.LUOPAN)
    else
        return
    end

    local luopan = player:getPet()
    local luopanSize = 2
    local targetPos = target:getPos()

    if player:hasStatusEffect(xi.effect.WIDENED_COMPASS) then
        luopanSize = 4
    end

    -- Set the luopans pos to the same as the targets pos.
    luopan:setPos(targetPos.x, targetPos.y, targetPos.z, 0)

    -- Attach effect
    xi.job_utils.geomancer.addAura(luopan, 0, tickEffect, tickPower, targetType)

    -- Save the mp cost for use with Full Circle
    luopan:setLocalVar("MP_COST", spell:getMPCost())

    -- Change the luopans appearance to match the effect
    -- TODO: This is should be the element of the spell being cast added as an offset
    -- on top of a base model ID in core.
    luopan:setModelId(modelID)

    -- Size is effected by EntityFlags
    player:setPetFlags(luopanSize)

    -- Set HP loss over time
    luopan:addMod(xi.mod.REGEN_DOWN, luopan:getMainLvl() / 4)
    printf("\nluopan hp tick: %i", luopan:getMainLvl() / 4)

    -- Innate Damage Taken -50%
    luopan:addMod(xi.mod.DMG, -5000)
end
