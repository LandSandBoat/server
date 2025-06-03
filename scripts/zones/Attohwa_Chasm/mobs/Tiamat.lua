-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Tiamat
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = -509.612, y = -7.883,  z = -57.162 },
    { x = -511.114, y = -8.854,  z = -61.300 },
    { x = -513.979, y = -9.972,  z = -66.404 },
    { x = -516.567, y = -11.228, z = -71.118 },
    { x = -516.019, y = -12.018, z = -77.012 },
    { x = -516.266, y = -12.074, z = -82.299 },
    { x = -520.644, y = -12.033, z = -84.040 },
    { x = -525.511, y = -11.937, z = -79.784 },
    { x = -531.459, y = -12.028, z = -75.823 },
    { x = -537.182, y = -11.317, z = -79.414 },
    { x = -541.642, y = -11.083, z = -80.879 },
    { x = -546.247, y = -11.653, z = -78.959 },
    { x = -550.252, y = -11.713, z = -81.462 },
    { x = -553.738, y = -12.191, z = -83.898 },
    { x = -558.361, y = -12.178, z = -84.656 },
    { x = -562.449, y = -12.202, z = -84.500 },
    { x = -565.689, y = -12.420, z = -79.477 },
    { x = -559.911, y = -11.622, z = -67.839 },
    { x = -556.672, y = -11.939, z = -66.284 },
    { x = -551.187, y = -12.342, z = -67.364 },
    { x = -545.686, y = -11.851, z = -64.526 },
    { x = -540.688, y = -12.420, z = -61.299 },
    { x = -547.407, y = -11.494, z = -56.208 },
    { x = -545.911, y = -11.480, z = -53.302 },
    { x = -543.347, y = -11.080, z = -49.358 },
    { x = -547.281, y = -11.188, z = -46.117 },
    { x = -551.477, y = -11.580, z = -48.592 },
    { x = -555.466, y = -11.945, z = -50.986 },
    { x = -560.512, y = -12.042, z = -51.924 },
    { x = -563.436, y = -12.140, z = -48.995 },
    { x = -563.185, y = -12.002, z = -46.441 },
    { x = -563.587, y = -12.005, z = -43.905 },
    { x = -566.766, y = -12.674, z = -41.782 },
    { x = -563.552, y = -12.000, z = -39.131 },
    { x = -560.329, y = -12.000, z = -37.608 },
    { x = -553.611, y = -11.488, z = -36.440 },
    { x = -547.924, y = -9.652,  z = -32.699 },
    { x = -545.229, y = -9.139,  z = -26.835 },
    { x = -539.781, y = -6.688,  z = -24.802 },
    { x = -537.228, y = -6.278,  z = -21.546 },
    { x = -536.608, y = -4.329,  z = -16.014 },
    { x = -540.775, y = -4.301,  z = -13.786 },
    { x = -547.040, y = -4.759,  z = -13.895 },
    { x = -552.430, y = -5.316,  z = -11.979 },
    { x = -556.140, y = -4.988,  z = -8.711  },
    { x = -560.106, y = -4.234,  z = -5.819  },
    { x = -559.868, y = -4.000,  z = -1.305  },
    { x = -557.823, y = -4.000,  z = 3.232   },
    { x = -553.009, y = -3.918,  z = 4.200   },
    { x = -549.802, y = -8.944,  z = -24.848 },
}

local function enterFlight(mob)
    mob:setAnimationSub(1) -- Change to flight.
    mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
    mob:setMobSkillAttack(730)
    mob:setLocalVar('flightTime', os.time() + 120)
    mob:setLocalVar('changeHP', mob:getHP() - 10000)
end

entity.onMobInitialize = function(mob)
    mob:setCarefulPathing(true) -- Used for drawin

    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

entity.onMobSpawn = function(mob)
    -- Ensure Tiamat spawns with correct ground status
    mob:setMobSkillAttack(0)
    mob:setAnimationSub(0)
    mob:delStatusEffect(xi.effect.ALL_MISS)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)

    mob:setMod(xi.mod.ACC, 444)
    mob:setMod(xi.mod.ATT, 388)
    mob:setMod(xi.mod.COUNTER, 10)
    mob:setMod(xi.mod.CURSE_MEVA, 1000) -- TODO: Needs curse immunity verification
    mob:setMod(xi.mod.DEF, 463)
    mob:setMod(xi.mod.EVA, 397)
    mob:setMod(xi.mod.MATT, 0)
    mob:setMod(xi.mod.REFRESH, 200)
    mob:setMod(xi.mod.REGEN, 22)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UFASTCAST, 50)
    mob:setMod(xi.mod.VIT, 19)
    mob:setMobMod(xi.mobMod.ROAM_COOL, 55)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 5)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 150) -- 247 total weapon damage
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobRoam = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobEngage = function(mob, target)
    local flightTime = mob:getLocalVar('flightTime')

    -- Set flight time to two min if fresh spawn
    if flightTime == 0 then
        mob:setLocalVar('flightTime', os.time() + 120)
    -- Otherwise, set how many seconds left to fly from last pull
    else
        mob:setLocalVar('flightTime', os.time() + flightTime)
    end

    mob:setLocalVar('twohourTime', os.time() + 210)
    mob:setLocalVar('changeHP', mob:getHP() - 10000)
end

entity.onMobFight = function(mob, target)
    -- Tiamat draws in from set boundaries leaving her spawn area
    local drawInTable =
    {
        conditions =
        {
            target:getZPos() > 28,
            target:getZPos() > -31 and target:getXPos() > -515,
            target:getZPos() <= -31 and target:getXPos() > -500,
        },
        position = mob:getPos(),
        wait = 5,
    }

    for _, condition in ipairs(drawInTable.conditions) do
        if condition then
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            utils.drawIn(target, drawInTable)
            break
        else
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end

    -- Gains a large attack boost when health is under 25% which cannot be Dispelled.
    local hpp = mob:getHPP()
    if
        hpp <= 25 and
        not mob:hasStatusEffect(xi.effect.ATTACK_BOOST)
    then
        mob:addStatusEffect(xi.effect.ATTACK_BOOST, 75, 0, 0)
        mob:getStatusEffect(xi.effect.ATTACK_BOOST):addEffectFlag(xi.effectFlag.DEATH)
    end

    -- Gains a delay reduction (from 210 to 160) when health is under 10%
    if hpp <= 10 and mob:getLocalVar('appliedDelayReduction') == 0 then
        mob:addMod(xi.mod.DELAY, 833)
        mob:setLocalVar('appliedDelayReduction', 1)
    elseif hpp > 10 and mob:getLocalVar('appliedDelayReduction') == 1 then
        mob:delMod(xi.mod.DELAY, 833)
        mob:setLocalVar('appliedDelayReduction', 0)
    end

    -- Animation (Ground or flight mode) logic.
    if
        not mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) and
        mob:actionQueueEmpty()
    then
        local flightTime  = mob:getLocalVar('flightTime')
        local twohourTime = mob:getLocalVar('twohourTime')
        local changeHP    = mob:getLocalVar('changeHP')
        local animation   = mob:getAnimationSub()

        -- Initial grounded mode.
        if
            animation == 0 and
            (os.time() > flightTime and mob:getHP() < changeHP)
        then
            enterFlight(mob)

        -- Flight mode.
        elseif
            animation == 1 and
            (os.time() > flightTime and mob:getHP() < changeHP) and
            mob:checkDistance(target) <= 6 -- This 2 checks are a hack until we can handle skills targeting a position and not an entity.
        then
            mob:useMobAbility(1282) -- This ability also handles animation change to 2.
            mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
            mob:setLocalVar('flightTime', os.time() + 120)
            mob:setLocalVar('changeHP', mob:getHP() - 10000)

        -- Subsequent grounded mode.
        elseif animation == 2 then
             -- 2-Hour logic.
            if os.time() > twohourTime then
                mob:useMobAbility(688) -- Mighty Strikes
                mob:setLocalVar('twohourTime', os.time() + 210)

            elseif
                os.time() > flightTime or
                mob:getHP() < changeHP
            then
                enterFlight(mob)
            end
        end
    end

    -- Tiamat wakes from sleep in air
    if
        (mob:hasStatusEffect(xi.effect.SLEEP_I) or
        mob:hasStatusEffect(xi.effect.SLEEP_II) or
        mob:hasStatusEffect(xi.effect.LULLABY)) and
        mob:getAnimationSub() == 1
    then
        mob:wakeUp()
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    if mob:getAnimationSub() == 1 then
        mob:setLocalVar('skill_tp', mob:getTP())
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Don't lose TP from autos during flight
    if skill:getID() == 1278 then
        mob:addTP(64) -- Needs to gain TP from flight auto attacks
        mob:setLocalVar('skill_tp', 0)
    elseif skill:getID() == 1282 then -- Don't consume TP on touchdown
        mob:addTP(mob:getLocalVar('skill_tp'))
        mob:setLocalVar('skill_tp', 0)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENFIRE, { chance = 20, power = 100 })
end

entity.onMobDisengage = function(mob)
    -- Reset Tiamat back to the ground on wipe
    if mob:getAnimationSub() == 1 then
        local flightTime = mob:getLocalVar('flightTime')
        mob:setLocalVar('flightTime', flightTime - os.time()) -- Get seconds left to fly for next pull
        mob:setAnimationSub(0)
        mob:delStatusEffect(xi.effect.ALL_MISS)
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
        mob:setMobSkillAttack(0)
        mob:setLocalVar('changeHP', 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.TIAMAT_TROUNCER)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

return entity
