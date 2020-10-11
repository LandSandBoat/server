-----------------------------------
-- Geomancer helpers
-----------------------------------
require("scripts/globals/pets")
require("scripts/globals/status")
-----------------------------------

tpz = tpz or {}
tpz.geo = tpz.geo or {}

tpz.geo.spawnLuopan = function(player, target, aura_effect, tick_effect, tick_power, target_type, spell_cost)

    tpz.pet.spawnPet(player, tpz.pet.id.LUOPAN)
    local luopan = player:getPet()
    local modelID = aura_effect
    local petID  = luopan:getID()

    -- Attach effect
    luopan:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, 0, 3, 0, tick_effect, tick_power, target_type, tpz.effectFlag.AURA)
    -- Save the mp cost for use with Full Circle.
    luopan:setLocalVar("MP_COST", spell_cost)
    -- Change the luopans appearance to match the effect.
    luopan:setModelId(modelID)
    -- Set HP loss over time.
    luopan:addMod(tpz.mod.REGEN_DOWN, 24)
end
