-----------------------------------
-- Geomancer helpers
-----------------------------------
require("scripts/globals/pets")
require("scripts/globals/status")
-----------------------------------

tpz = tpz or {}
 xi.geo = xi.geo or {}

-- TODO: After elements are aligned in the codebase, this should become:
-- xi.geo.spawnLuopan = function(player, target, spell, tick_effect, tick_power, target_type)
 xi.geo.spawnLuopan = function(player, target, modelID, tick_effect, tick_power, target_type, spell)

    xi.pet.spawnPet(player, xi.pet.id.LUOPAN)
    local luopan = player:getPet()

    -- Attach effect
    luopan:addStatusEffectEx(xi.effect.COLURE_ACTIVE, xi.effect.COLURE_ACTIVE, 0, 3, 0, tick_effect, tick_power, target_type, xi.effectFlag.AURA)

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
