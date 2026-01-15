-----------------------------------
-- Area: Valley of Sorrows
--  HNM: Aspidochelone
-----------------------------------
local ID = zones[xi.zone.VALLEY_OF_SORROWS]
mixins =
{
    require('scripts/mixins/rage'),
    require('scripts/mixins/draw_in'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

-- Spawn points are for era hnm spawns
entity.spawnPoints =
{
    { x =  19.000, y =  0.089, z =  14.000 },
    { x = -13.446, y =  0.120, z = -19.944 },
    { x =  32.577, y =  0.258, z =  25.914 },
    { x = -37.569, y =  0.656, z = -16.412 },
    { x =   2.662, y =  0.359, z = -11.207 },
    { x = -18.601, y =  0.043, z = -22.954 },
    { x = -17.858, y =  0.005, z = -24.530 },
    { x =  -3.694, y =  0.000, z =   0.751 },
    { x = -35.391, y =  0.175, z =  -6.932 },
    { x = -28.191, y = -0.123, z = -14.568 },
    { x = -13.617, y = -0.148, z =  26.804 },
    { x = -39.004, y =  0.718, z =  15.594 },
    { x =   6.052, y =  0.102, z =   0.360 },
    { x =  -9.340, y = -0.036, z =  27.368 },
    { x =  -8.153, y =  0.109, z = -44.906 },
    { x = -13.026, y = -0.071, z = -13.227 },
    { x =  -2.841, y =  0.953, z = -20.919 },
    { x = -12.025, y = -0.245, z =  27.842 },
    { x =  -3.063, y =  0.136, z =  33.261 },
    { x =  16.246, y =  0.797, z =  -1.231 },
    { x =  31.977, y =  0.200, z =  36.378 },
    { x =  -8.902, y =  0.164, z =  -9.822 },
    { x =   1.318, y =  0.333, z = -28.639 },
    { x = -21.316, y = -0.108, z =  25.146 },
    { x = -36.667, y =  0.270, z =  30.578 },
    { x =  -0.137, y =  0.473, z =  27.229 },
    { x = -20.176, y =  0.006, z = -32.908 },
    { x =  -0.213, y =  0.000, z = -37.221 },
    { x =   2.145, y =  0.220, z = -31.586 },
    { x =  18.788, y =  0.560, z =   6.947 },
    { x = -31.028, y = -0.056, z =  22.976 },
    { x =  19.107, y =  0.381, z =   9.146 },
    { x = -20.133, y = -0.241, z =  26.484 },
    { x =   9.881, y =  0.478, z =  35.204 },
    { x =  -7.217, y =  0.458, z = -17.895 },
    { x =  -1.829, y =  0.890, z =  17.820 },
    { x = -34.581, y =  0.172, z =  -8.047 },
    { x = -21.492, y = -0.262, z =  17.438 },
    { x =   3.332, y =  0.431, z = -25.970 },
    { x = -35.748, y =  0.455, z = -16.297 },
    { x = -33.987, y =  0.212, z = -25.433 },
    { x =   8.049, y =  0.287, z =  -5.186 },
    { x = -41.475, y = -0.002, z =   3.981 },
    { x = -32.682, y =  0.059, z = -25.162 },
    { x = -18.789, y = -0.032, z = -33.083 },
    { x = -32.305, y =  0.184, z =  38.459 },
    { x =  -5.326, y =  0.571, z = -14.812 },
    { x = -30.577, y =  0.141, z =   8.469 },
    { x = -21.907, y = -0.202, z = -18.879 },
    { x =   0.627, y =  0.175, z =  -7.521 }
}

local intoShell = function(mob)
    mob:setLocalVar('changeTime', GetSystemTime() + 90)
    mob:setAnimationSub(1)
    mob:setMobAbilityEnabled(false)
    mob:setAutoAttackEnabled(false)
    mob:setMod(xi.mod.REGEN, 130)
    mob:setMod(xi.mod.UDMGRANGE, -9500)
    mob:setMod(xi.mod.UDMGPHYS, -9500)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
end

local outOfShell = function(mob)
    mob:setMobAbilityEnabled(true)
    mob:setAutoAttackEnabled(true)
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobSpawn = function(mob)
    -- Despawn the ???
    GetNPCByID(ID.npc.ADAMANTOISE_QM):setStatus(xi.status.DISAPPEAR)

    outOfShell(mob) -- Ensure out of shell mods are set on spawn

    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
    mob:setLocalVar('dmgToChange', mob:getHP() - 1000)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.UDMGMAGIC, -3000)
    mob:setMod(xi.mod.CURSERES, 100)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 45) -- 130 total weapon damage
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)
    mob:setMod(xi.mod.DEF, 702)
    mob:setMod(xi.mod.ATT, 395)
    mob:setMod(xi.mod.EVA, 310)
    mob:setAnimationSub(0)
end

entity.onMobFight = function(mob, target)
    -- Aspid changes shell state at 1000 HP intervals based on what HP it was at when it last changed shell
    -- If it in its shell, it will come out of shell at the damage threshold, reaching 100% HP, or 90 seconds have passed
    local changeHP = mob:getLocalVar('dmgToChange')

    if -- In shell
        mob:getAnimationSub() == 1 and
        (GetSystemTime() > mob:getLocalVar('changeTime') or
        mob:getHPP() == 100)
    then
        outOfShell(mob)
        mob:setAnimationSub(2)
        mob:setTP(3000) -- Immediately TPs coming out of shell
    end

    if
        changeHP ~= 0 and
        mob:getHP() <= changeHP
    then
        mob:setLocalVar('dmgToChange', 0)

        if mob:getAnimationSub() == 1 then
            outOfShell(mob)
            mob:setAnimationSub(2)
            mob:setTP(3000) -- Immediately TPs coming out of shell
        elseif
            mob:getAnimationSub() == 2 or
            mob:getAnimationSub() == 0
        then
            intoShell(mob)
        end

        -- Complete shell exit/enter animation then set hp change var
        mob:timer(1500, function(mobArg)
            mobArg:setLocalVar('dmgToChange', mob:getHP() - 1000)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.ASPIDOCHELONE_SINKER)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    GetNPCByID(ID.npc.ADAMANTOISE_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
