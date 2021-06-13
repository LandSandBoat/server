-----------------------------------
-- Geomancer helpers
-----------------------------------
require("scripts/globals/pets")
require("scripts/globals/status")
-----------------------------------

xi = xi or {}
xi.geo = xi.geo or {}

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
xi.geo.addAura = function(target, duration, tickEffect, tickPower, targetType)
    target:addStatusEffectEx(xi.effect.COLURE_ACTIVE, xi.effect.COLURE_ACTIVE, 0, 3, duration, tickEffect, tickPower, targetType, xi.effectFlag.AURA)
end

-- TODO: After elements are aligned in the codebase, this should become:
-- xi.geo.spawnLuopan = function(player, target, spell, tickEffect, tickPower, targetType)
xi.geo.spawnLuopan = function(player, target, modelID, tickEffect, tickPower, targetType, spell)

    xi.pet.spawnPet(player, xi.pet.id.LUOPAN)
    local luopan = player:getPet()

    -- Attach effect
    xi.geo.addAura(luopan, 0, tickEffect, tickPower, targetType)

    -- Save the mp cost for use with Full Circle
    luopan:setLocalVar("MP_COST", spell:getMPCost())

    -- Change the luopans appearance to match the effect
    -- TODO: This is should be the element of the spell being cast added as an offset
    --       on top of a base model ID in core.
    luopan:setModelId(modelID)

    -- Set HP loss over time
    luopan:addMod(xi.mod.REGEN_DOWN, luopan:getMainLvl() / 4)

    -- Innate Damage Taken -50%
    luopan:addMod(xi.mod.DMG, -50)
end
