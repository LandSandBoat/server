-----------------------------------
-- Area: Emperial Paradox
--  Mob: Kam'lanaut
-- Apocalypse Nigh Final Fight
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

local skillToAbsorb =
{
    [823] = xi.mod.FIRE_ABSORB,  -- fire_blade
    [824] = xi.mod.ICE_ABSORB,   -- frost_blade
    [825] = xi.mod.WIND_ABSORB,  -- wind_blade2
    [826] = xi.mod.EARTH_ABSORB, -- earth_blade
    [827] = xi.mod.LTNG_ABSORB,  -- lightning_blade
    [828] = xi.mod.WATER_ABSORB, -- water_blade
}

entity.onMobEngaged = function(mob, target)
    mob:setLocalVar("nextEnSkill", os.time() + 10)
end

entity.onMobFight = function(mob, target)
    if os.time() > mob:getLocalVar("nextEnSkill") then
        local skill = math.random(823, 828)
        mob:setLocalVar("currentTP", mob:getTP())
        mob:useMobAbility(skill)
        mob:setLocalVar("nextEnSkill", os.time() + 30)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillId = skill:getID()
    local absorbId = skillToAbsorb[skillId]

    if absorbId then
        -- ----------------------------------------------------------------------
        -- when using en-spell weapon skill, absorb damage of that element type
        -- ----------------------------------------------------------------------

        -- remove previous absorb mod, if set
        local previousAbsorb = mob:getLocalVar("currentAbsorb")

        if previousAbsorb > 0 then
            mob:setMod(previousAbsorb, 0)
        end

        -- add new absorb mod
        mob:setLocalVar("currentAbsorb", absorbId)
        mob:setMod(absorbId, 100)

        -- return TP
        mob:setTP(mob:getLocalVar("currentTP"))

    else
        -- ----------------------------------------------------------------------
        -- when using Light Blade or Great Wheel, can do up to three WS in a row
        -- ----------------------------------------------------------------------

        local wsCount = mob:getLocalVar("wsCount")
        local wsMax = mob:getLocalVar("wsMax")

        if wsCount == 0 then
            wsMax = math.random(0, 2)
            mob:setLocalVar("wsMax", wsMax)
        end

        if wsCount < wsMax then
            mob:setLocalVar("wsCount", wsCount + 1)
            mob:setTP(1000)
        else
            mob:setLocalVar("wsCount", 0)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
