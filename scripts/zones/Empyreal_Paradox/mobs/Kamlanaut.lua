-----------------------------------
-- Area: Emperial Paradox
--  Mob: Kam'lanaut
-- Apocalypse Nigh Final Fight
-- TODO:
--   Can perform three TP attacks upon reaching 100%+ TP, giving very little rest for healers.
--   He can do 3 Great Wheels in a row, devastating any melee jobs in range.
-----------------------------------
require("scripts/globals/status")
-----------------------------------

local skillToAbsorb =
{
    [823] = tpz.mod.FIRE_ABSORB,  -- fire_blade
    [824] = tpz.mod.ICE_ABSORB,   -- frost_blade
    [825] = tpz.mod.WIND_ABSORB,  -- wind_blade2
    [826] = tpz.mod.EARTH_ABSORB, -- earth_blade
    [827] = tpz.mod.LTNG_ABSORB,  -- lightning_blade
    [828] = tpz.mod.WATER_ABSORB, -- water_blade
}

function onMobWeaponSkill(target, mob, skill)
    -- when uses an en-spell weapon skill, absorb damage of that element type
    local absorbId = skillToAbsorb[skill:getID()]

    if absorbId then
        -- remove previous absorb mod, if set
        local previousAbsorb = mob:getLocalVar("currentAbsorb")

        if previousAbsorb > 0 then
            mob:setMod(previousAbsorb, 0)
        end

        -- add new absorb mod
        mob:setLocalVar("currentAbsorb", absorbId)
        mob:setMod(absorbId, 100)
    end
end

function onMobDeath(mob, player, isKiller)
end
