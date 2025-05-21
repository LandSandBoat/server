-----------------------------------
-- Area: King Ranperre's Tomb
--   NM: Vrtra
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPointTable =
{
    { x = 228.000, y = 7.134, z = -311.000 },
    { x = 220.463, y = 8.136, z = -302.294 },
    { x = 204.672, y = 7.500, z = -271.593 },
    { x = 214.618, y = 7.457, z = -286.165 },
    { x = 223.101, y = 8.025, z = -315.119 },
    { x = 247.336, y = 7.494, z = -304.864 },
    { x = 234.925, y = 8.097, z = -293.001 },
    { x = 235.257, y = 7.176, z = -322.734 },
    { x = 207.240, y = 7.613, z = -277.323 },
    { x = 209.889, y = 6.901, z = -323.897 },
    { x = 233.434, y = 7.474, z = -315.569 },
    { x = 244.405, y = 7.500, z = -318.060 },
    { x = 209.411, y = 8.072, z = -311.097 },
    { x = 196.773, y = 8.252, z = -308.707 },
    { x = 212.375, y = 8.006, z = -309.179 },
    { x = 205.479, y = 7.084, z = -284.712 },
    { x = 226.669, y = 7.500, z = -308.960 },
    { x = 205.457, y = 7.780, z = -299.290 },
    { x = 229.418, y = 7.924, z = -281.928 },
    { x = 234.193, y = 7.500, z = -327.967 },
    { x = 229.321, y = 8.725, z = -296.566 },
    { x = 248.498, y = 7.700, z = -287.928 },
    { x = 212.373, y = 7.891, z = -273.686 },
    { x = 219.563, y = 8.500, z = -280.989 },
    { x = 235.472, y = 6.751, z = -284.453 },
    { x = 213.845, y = 7.951, z = -273.953 },
    { x = 226.365, y = 8.500, z = -319.678 },
    { x = 225.367, y = 8.098, z = -296.425 },
    { x = 200.939, y = 7.846, z = -289.484 },
    { x = 227.849, y = 8.500, z = -320.373 },
    { x = 196.482, y = 8.226, z = -300.558 },
    { x = 237.806, y = 8.372, z = -304.311 },
    { x = 236.669, y = 7.483, z = -310.887 },
    { x = 197.317, y = 8.213, z = -294.733 },
    { x = 194.723, y = 7.272, z = -314.654 },
    { x = 223.670, y = 8.183, z = -278.056 },
    { x = 215.315, y = 8.183, z = -282.985 },
    { x = 213.837, y = 8.386, z = -277.434 },
    { x = 239.121, y = 7.477, z = -311.985 },
    { x = 204.118, y = 7.840, z = -296.797 },
    { x = 204.809, y = 7.510, z = -293.735 },
    { x = 218.759, y = 8.385, z = -314.973 },
    { x = 218.131, y = 8.442, z = -282.762 },
    { x = 217.237, y = 8.473, z = -315.697 },
    { x = 219.195, y = 8.338, z = -314.381 },
    { x = 234.118, y = 7.500, z = -319.658 },
    { x = 243.304, y = 7.563, z = -286.714 },
    { x = 201.935, y = 7.500, z = -323.092 },
    { x = 209.553, y = 7.118, z = -292.888 },
    { x = 213.200, y = 8.350, z = -316.937 },
}

local spawnUndead = function(vrtra, undead, vrtraPos)
    vrtra:entityAnimationPacket(xi.animationString.CAST_SUMMONER_START)
    vrtra:setAutoAttackEnabled(false)
    vrtra:setMagicCastingEnabled(false)
    vrtra:setMobAbilityEnabled(false)
    vrtra:setMobMod(xi.mobMod.NO_MOVE, 1)
    vrtra:timer(3000, function(vrtraArg)
        vrtraArg:entityAnimationPacket(xi.animationString.CAST_SUMMONER_STOP)
        vrtraArg:setAutoAttackEnabled(true)
        vrtraArg:setMagicCastingEnabled(true)
        vrtraArg:setMobAbilityEnabled(true)
        vrtraArg:setMobMod(xi.mobMod.NO_MOVE, 0)
        undead:setSpawn(vrtraPos.x, vrtraPos.y, vrtraPos.z, vrtraPos.rot)
        undead:spawn()
        if vrtraArg:isEngaged() then
            undead:updateEnmity(vrtraArg:getTarget())
        end
    end)
end

entity.onMobInitialize = function(mob)
    mob:setCarefulPathing(true)
    xi.mob.updateNMSpawnPoint(mob, spawnPointTable)
    mob:setRespawnTime(math.random(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.ACC, 442)
    mob:setMod(xi.mod.ATT, 305)
    mob:setMod(xi.mod.CURSE_MEVA, 1000)
    mob:setMod(xi.mod.DEF, 466)
    mob:setMod(xi.mod.EVA, 401)
    mob:setMod(xi.mod.REGEN, 50)
    mob:setMod(xi.mod.REFRESH, 100)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UFASTCAST, 50)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.ROAM_COOL, 55)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 5)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 30)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 148) -- 245 total weapon damage
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobRoam = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobEngage = function(mob, target)
    -- Reset the onMobFight variables
    mob:setLocalVar('spawnTime', 0)
    mob:setLocalVar('twohourTime', 0)
end

entity.onMobFight = function(mob, target)
    local spawnTime = mob:getLocalVar('spawnTime')
    local twohourTime = mob:getLocalVar('twohourTime')
    local fifteenBlock = mob:getBattleTime() / 15

    if twohourTime == 0 then
        twohourTime = math.random(4, 6)
        mob:setLocalVar('twohourTime', twohourTime)
    end

    if spawnTime == 0 then
        spawnTime = math.random(3, 5)
        mob:setLocalVar('spawnTime', spawnTime)
    end

    if
        fifteenBlock > twohourTime and
        mob:canUseAbilities()
    then
        mob:useMobAbility(710)
        mob:setLocalVar('skill_tp', mob:getTP()) -- 2 hr shouldn't wipe TP
        mob:setLocalVar('twohourTime', fifteenBlock + math.random(4, 6))
    elseif fifteenBlock > spawnTime then
        local mobId     = mob:getID()
        local chosenPet = utils.shuffle({ 1, 2, 3, 4, 5, 6 })

        for _, offset in ipairs(chosenPet) do
            local pet = GetMobByID(mobId + offset)

            if pet and not pet:isSpawned() then
                spawnUndead(mob, pet, mob:getPos())
                break
            end
        end

        spawnTime = math.random(3, 5)
        mob:setLocalVar('spawnTime', fifteenBlock + spawnTime)
    end

    -- Keep pets linked
    for i = 1, 6 do
        local pet = GetMobByID(mob:getID() + i)
        if pet and pet:getCurrentAction() == xi.act.ROAMING then
            pet:updateEnmity(target)
        end
    end

    -- Vrtra draws in if you attempt to leave the room
    local drawInTable =
    {
        conditions =
        {
            target:getXPos() < 180 and target:getZPos() > -305 and target:getZPos() < -290,
        },
        position = mob:getPos(),
        wait = 3,
    }
    if drawInTable.conditions[1] then
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        utils.drawIn(target, drawInTable)
    else
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Don't lose TP from charm 2hr
    if skill:getID() == 710 then
        mob:addTP(mob:getLocalVar('skill_tp'))
        mob:setLocalVar('skill_tp', 0)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENDARK, { power = math.random(55, 90), chance = 25 })
end

entity.onMobDisengage = function(mob)
    -- Despawn undead on disgengage
    for i = 1, 6 do
        DespawnMob(mob:getID() + i)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.VRTRA_VANQUISHER)
end

entity.onMobDespawn = function(mob)
    -- Set Vrtra's spawnpoint and respawn time (3-5 days)
    xi.mob.updateNMSpawnPoint(mob, spawnPointTable)
    mob:setRespawnTime(math.random(144, 240) * 1800) -- 3 to 5 days in 30 minute windows
end

return entity
