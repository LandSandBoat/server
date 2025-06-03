-----------------------------------
-- Area: Uleguerand Range
--  Mob: Jormungand
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = -237.096, y = -176.729, z = 66.510  },
    { x = -240.915, y = -176.729, z = 71.196  },
    { x = -244.554, y = -176.729, z = 78.238  },
    { x = -238.398, y = -176.729, z = 77.472  },
    { x = -229.395, y = -176.729, z = 78.389  },
    { x = -222.505, y = -176.729, z = 78.963  },
    { x = -211.989, y = -176.729, z = 76.162  },
    { x = -202.155, y = -176.729, z = 77.074  },
    { x = -194.782, y = -176.729, z = 85.499  },
    { x = -202.779, y = -176.729, z = 89.554  },
    { x = -212.760, y = -176.729, z = 92.678  },
    { x = -221.042, y = -176.729, z = 93.325  },
    { x = -230.205, y = -176.729, z = 94.413  },
    { x = -242.298, y = -176.729, z = 93.812  },
    { x = -248.338, y = -176.729, z = 101.971 },
    { x = -237.421, y = -176.729, z = 105.840 },
    { x = -229.191, y = -176.729, z = 105.774 },
    { x = -221.376, y = -176.729, z = 105.039 },
    { x = -214.032, y = -176.729, z = 104.421 },
    { x = -206.268, y = -176.729, z = 101.888 },
    { x = -183.494, y = -176.729, z = 107.748 },
    { x = -174.858, y = -176.729, z = 108.531 },
    { x = -170.724, y = -176.729, z = 114.058 },
    { x = -173.130, y = -176.729, z = 125.831 },
    { x = -185.503, y = -176.729, z = 125.448 },
    { x = -198.346, y = -176.729, z = 123.670 },
    { x = -211.107, y = -176.729, z = 123.475 },
    { x = -222.266, y = -176.729, z = 123.821 },
    { x = -233.443, y = -176.729, z = 123.330 },
    { x = -242.004, y = -176.729, z = 121.865 },
    { x = -251.956, y = -176.729, z = 122.926 },
    { x = -265.288, y = -176.729, z = 121.749 },
    { x = -276.880, y = -176.729, z = 120.215 },
    { x = -256.298, y = -176.729, z = 139.318 },
    { x = -246.236, y = -176.729, z = 141.755 },
    { x = -232.483, y = -176.729, z = 143.635 },
    { x = -222.317, y = -176.729, z = 143.632 },
    { x = -214.671, y = -176.729, z = 141.788 },
    { x = -205.726, y = -176.729, z = 146.453 },
    { x = -195.846, y = -176.729, z = 153.944 },
    { x = -194.149, y = -176.729, z = 166.793 },
    { x = -206.087, y = -176.729, z = 167.093 },
    { x = -219.294, y = -176.729, z = 166.444 },
    { x = -229.036, y = -176.729, z = 163.847 },
    { x = -237.583, y = -176.729, z = 163.615 },
    { x = -243.581, y = -176.729, z = 152.630 },
    { x = -213.177, y = -176.729, z = 177.619 },
    { x = -201.789, y = -176.729, z = 181.279 },
    { x = -196.297, y = -176.729, z = 167.560 },
    { x = -204.299, y = -176.740, z = 133.447 },
}

local function enterFlight(mob)
    mob:setAnimationSub(1)
    mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
    mob:setMobSkillAttack(732)
    mob:setLocalVar('flightTime', os.time() + 30)
    mob:setLocalVar('changeHP', mob:getHP() - 6000)
end

entity.onMobInitialize = function(mob)
    mob:setCarefulPathing(true)

    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

entity.onMobSpawn = function(mob)
    -- Ensure Jorm spawns with correct ground status
    mob:setAnimationSub(0)
    mob:setMobSkillAttack(0)
    mob:delStatusEffect(xi.effect.ALL_MISS)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)

    mob:setMod(xi.mod.ATT, 348)
    mob:setMod(xi.mod.ACC, 442)
    mob:setMod(xi.mod.CURSE_MEVA, 1000) -- TODO: Needs curse immunity verification
    mob:setMod(xi.mod.DEF, 460)
    mob:setMod(xi.mod.EVA, 410)
    mob:setMod(xi.mod.MATT, 30)
    mob:setMod(xi.mod.REFRESH, 200)
    mob:setMod(xi.mod.REGEN, 22)
    mob:setMod(xi.mod.UFASTCAST, 90)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(xi.mobMod.ROAM_COOL, 55)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 5)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 158) -- 255 total weapon damage
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobRoam = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobEngage = function(mob, target)
    local flightTime = mob:getLocalVar('flightTime')

    -- Set flight time to two min if fresh spawn
    if flightTime == 0 then
        mob:setLocalVar('flightTime', os.time() + 30)
    -- Otherwise, set how many seconds left to fly from last pull
    else
        mob:setLocalVar('flightTime', os.time() + flightTime)
    end

    mob:setLocalVar('twohourTime', os.time() + 210)
    mob:setLocalVar('changeHP', mob:getHP() - 6000)
end

entity.onMobFight = function(mob, target)
    -- Animation (Ground or flight mode) logic.
    if
        not mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) and
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
            mob:useMobAbility(1292) -- Touchdown: This ability also handles animation change to 2.
            mob:setLocalVar('flightTime', os.time() + 60)
            mob:setLocalVar('changeHP', mob:getHP() - 6000)

        -- Subsequent grounded mode.
        elseif animation == 2 then
             -- 2-Hour logic.
            if os.time() > twohourTime then
                mob:useMobAbility(695) -- Blood Weapon
                mob:setLocalVar('twohourTime', os.time() + 300)

            elseif
                os.time() > flightTime or
                mob:getHP() < changeHP
            then
                enterFlight(mob)
            end
        end
    end

    -- Jorm draws in from set boundaries leaving her spawn area
    local drawInTable =
    {
        conditions =
        {
            target:getXPos() < -105 and target:getXPos() > -215 and target:getZPos() > 195,
            target:getXPos() > -250 and target:getXPos() < -212 and target:getZPos() < 55,
            target:getXPos() > -160 and target:getZPos() > 105 and target:getZPos() < 130,
        },
        position = mob:getPos(),
        wait = 3,
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

    -- Do not use mobskills or magic during 2hr
    if mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) then
        mob:setMobAbilityEnabled(false)
        mob:setMagicCastingEnabled(false)
    else
        mob:setMobAbilityEnabled(true)
        mob:setMagicCastingEnabled(true)
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    if mob:getAnimationSub() == 1 then
        mob:setLocalVar('skill_tp', mob:getTP())
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Don't lose TP from autos during flight
    if skill:getID() == 1288 then
        mob:addTP(64) -- Needs to gain TP from flight auto attacks
        mob:setLocalVar('skill_tp', 0)
    elseif skill:getID() == 1292 then -- Don't lose TP from Touchdown
        mob:addTP(mob:getLocalVar('skill_tp'))
        mob:setLocalVar('skill_tp', 0)
    end

    -- Below 25% Jorm can Horrid Roar 3x
    local roarCount = mob:getLocalVar('roarCount')

    if
        mob:getHPP() <= 25 and
        skill:getID() == 1296 and -- Check for Horrid Roar
        (mob:getAnimationSub() == 0 or mob:getAnimationSub() == 2) -- If it flies during horrid roar cancel the remainders
    then
        if roarCount < 2 then
            if not target:isBehind(mob, 96) then
                mob:useMobAbility(1286) -- Use Horrid Roar 3
            else
                mob:useMobAbility(1290) -- Use Spike Flail
            end

            mob:setLocalVar('roarCount', roarCount + 1)
        else
            mob:setLocalVar('roarCount', 0) -- Need to reset once 3x roars are done
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENBLIZZARD, { chance = 20, power = 100 })
end

entity.onMobDisengage = function(mob)
    -- Reset Jorm back to the ground on wipe
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
    player:addTitle(xi.title.WORLD_SERPENT_SLAYER)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

return entity
