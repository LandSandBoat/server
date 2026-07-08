-----------------------------------
-- Area: Uleguerand Range
--  Mob: Jormungand
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
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
    mob:setMobSkillAttack(732)
    mob:addStatusEffect(xi.effect.ALL_MISS, { power = 1, origin = mob, icon = 0 })
    mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.NO_TURN)))
    mob:setLocalVar('flightTime', GetSystemTime() + 30)
    mob:setLocalVar('changeHP', math.max(0, mob:getHP() - 6000))
    mob:setAnimationSub(1)
end

local function exitFlight(mob)
    mob:setMobSkillAttack(0)
    mob:delStatusEffect(xi.effect.ALL_MISS)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setLocalVar('flightTime', GetSystemTime() + 60)
    mob:setLocalVar('changeHP', math.max(0, mob:getHP() - 6000))
    mob:useMobAbility(xi.mobSkill.TOUCHDOWN_4)
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.TERROR)

    mob:setCarefulPathing(true)
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)

    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
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
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MODIFIER, 158) -- 255 total weapon damage
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
end

entity.onMobEngage = function(mob, target)
    local currentTime = GetSystemTime()
    local flightTime  = mob:getLocalVar('flightTime')

    if flightTime == 0 then
        mob:setLocalVar('flightTime', currentTime + 30)
    else
        mob:setLocalVar('flightTime', currentTime + flightTime)
    end

    mob:setLocalVar('twohourTime', currentTime + 210)
    mob:setLocalVar('changeHP', math.max(0, mob:getHP() - 6000))
end

entity.onMobFight = function(mob, target)
    -- Draw in, prevents Jormungand from leaving the spawn area.
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

    local currentAnimation = mob:getAnimationSub()

    -- Wakes up if slept during air phase.
    if
        currentAnimation == 1 and
        mob:hasStatusEffect(xi.effect.SLEEP_I)
    then
        mob:wakeUp()
    end

    -- No Casting or TP Abilities during Blood Weapon.
    local bloodWeaponActive = mob:hasStatusEffect(xi.effect.BLOOD_WEAPON)

    mob:setMobAbilityEnabled(not bloodWeaponActive)
    mob:setMagicCastingEnabled(not bloodWeaponActive)

    -- Cannot change phases while Blood Weapon is active.
    if
        bloodWeaponActive or
        xi.combat.behavior.isEntityBusy(mob)
    then
        return
    end

    local currentTime      = GetSystemTime()
    local currentHP        = mob:getHP()

    if
        currentAnimation == 2 and
        currentTime > mob:getLocalVar('twohourTime')
    then
        mob:useMobAbility(xi.mobSkill.BLOOD_WEAPON_1)
        mob:setLocalVar('twohourTime', currentTime + 300)
        return
    end

    if
        currentTime > mob:getLocalVar('flightTime') or
        currentHP < mob:getLocalVar('changeHP')
    then
        if currentAnimation == 1 then
            exitFlight(mob)
        else
            enterFlight(mob)
        end
    end
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    if
        mob:getHPP() > 25 or
        mob:getAnimationSub() == 1 or
        skill:getID() ~= xi.mobSkill.HORRID_ROAR_4
    then
        return
    end

    mob:setMagicCastingEnabled(false)
    mob:setLocalVar('isBusy', 1)
    local roarCount = mob:getLocalVar('roarCount')

    if roarCount < 2 then
        if not target:isBehind(mob, 96) then
            mob:useMobAbility(xi.mobSkill.HORRID_ROAR_4)
        else
            mob:useMobAbility(xi.mobSkill.SPIKE_FLAIL_4)
        end

        mob:setLocalVar('roarCount', roarCount + 1)
    else
        mob:setMagicCastingEnabled(true)
        mob:setLocalVar('isBusy', 0)
        mob:setLocalVar('roarCount', 0)
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.BLIZZAGA_III,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [2] = { xi.magic.spell.PARALYGA,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [3] = { xi.magic.spell.BINDGA,          target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [4] = { xi.magic.spell.ICE_SPIKES,      mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ICE_SPIKES, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 20,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.ICE,
        basePower      = math.floor(damage / 2),
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

entity.onMobDisengage = function(mob)
    if mob:getAnimationSub() == 1 then
        local flightTime = math.max(mob:getLocalVar('flightTime') - GetSystemTime(), 1)

        mob:setLocalVar('flightTime', flightTime)
        mob:setAnimationSub(0)
        mob:delStatusEffect(xi.effect.ALL_MISS)
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
        mob:setMobSkillAttack(0)
        mob:setLocalVar('changeHP', 0)
    end

    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setAnimationSub(0)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.WORLD_SERPENT_SLAYER)
    end
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

return entity
