-----------------------------------
-- PET: Jug Pets
-----------------------------------
require('scripts/utils/utils')
-----------------------------------

xi = xi or {}
xi.pets = xi.pets or {}
xi.pets.jug = xi.pets.jug or {}

-- NOTE: Called from petutils.cpp
-- Acts as a hook for functions.
-- Runs everytime a pet's stats are rebuilt/recalculated.
---@param master CBaseEntity
---@param pet CBaseEntity
xi.pets.jug.onPetStatCalculate = function(master, pet)
    pet:setMobMod(xi.mobMod.DAMAGE_OFFSET, 2)
    pet:setMobMod(xi.mobMod.RANGED_DAMAGE_OFFSET, 2)
end
