-----------------------------------
-- Old Dynamis
-- This entire system is using old dat lists from 2008 in order to apply the spawning and mechanics correctly
-- If new DATS are used this system will break and cause crashes
-----------------------------------
require('scripts/globals/battlefield')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/pets/summon')
-----------------------------------
xi = xi or {}
xi.dynamis = xi.dynamis or {}
xi.dynamis.mobType = xi.dynamis.mobType or
{
    NORMAL    = 1,
    STATUE    = 2,
    BOSS      = 3,
    NIGHTMARE = 4,
    MASTER    = 5,
    AVATAR    = 6,
}

-- Debug control
xi.mobinfo = xi.mobinfo or {}
xi.mobinfo.DEBUG = false

local function debugPrint(message)
    if xi.mobinfo.DEBUG then
        print('[DynaDebug] ' .. message)
    end
end

local timerTargetLocalVar = 'dynamisTimerTargetID'

local function setTimerTarget(mob, target)
    local targetID = 0

    if target then
        targetID = target:getID()
    end

    mob:setLocalVar(timerTargetLocalVar, targetID)
end

local function getTimerTarget(mob)
    local targetID = mob:getLocalVar(timerTargetLocalVar)
    if targetID == 0 then
        return nil
    end

    local target = GetPlayerByID(targetID)
    if target then
        if target:getZoneID() == mob:getZoneID() then
            return target
        end

        return nil
    end

    return GetEntityByID(targetID, mob:getInstance(), true)
end

local function isStationaryMob(mob)
    local zoneId         = mob:getZoneID()
    local stationaryMobs = xi.dynamis.stationary and xi.dynamis.stationary[zoneId]
    if not stationaryMobs then
        return false
    end

    local mobId = mob:getID()
    for _, stationaryMobId in pairs(stationaryMobs) do
        if stationaryMobId == mobId then
            return true
        end
    end

    return false
end

local function spawnWithAnim(mob)
    mob:spawn()

    -- Set spawn animation to normal after 3 seconds
    mob:timer(10000, function(mobArg)
        mobArg:setSpawnAnimation(xi.spawnAnimation.NORMAL)
    end)
end

-- Apparently NO_MOVE mod locks them in place including their facing direction
-- This looks really ugly and that is because it is but its the only way I got
local function faceHeldTarget(mob)
    if not mob:isSpawned() or mob:getLocalVar('spawnHoldActive') == 0 then
        return
    end

    local target = mob:getTarget() or getTimerTarget(mob)
    if target then
        mob:clearPath()
        mob:lookAt(target:getPos())
    end

    mob:timer(250, function(mobArg)
        faceHeldTarget(mobArg)
    end)
end

-- Handles initial spawn of mobs
local function holdSpawnedAdd(mob, durationMs)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setMobAbilityEnabled(false)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)

    mob:setLocalVar('spawnHoldActive', 1)
    faceHeldTarget(mob)

    mob:timer(durationMs, function(mobArg)
        if not mobArg:isSpawned() then
            return
        end

        mobArg:setLocalVar('spawnHoldActive', 0)
        mobArg:setAutoAttackEnabled(true)
        mobArg:setMagicCastingEnabled(true)
        mobArg:setMobAbilityEnabled(true)
        mobArg:setMobMod(xi.mobMod.NO_MOVE, 0)
    end)
end

-- This is a workaround for when the statue is casting while being engaged/pulled.
-- The mob that is casting should spawn its adds immediately, even if its in the middle of a cast
-- Added setting for how frequently to poll the enmity list during a cast so we can tweak as needed
local castAggroPollMs   = 500
local castAggroPollsMax = 60

-- castAggroPolls: 0 = not watching, otherwise the number of polls so far
local function pollCastAggro(mob)
    local polls = mob:getLocalVar('castAggroPolls')
    if
        polls == 0 or
        not mob:isSpawned() or
        mob:isDead()
    then
        return
    end

    if
        mob:isEngaged() or
        mob:getLocalVar('engageCheck') == 1 or
        polls >= castAggroPollsMax
    then
        mob:setLocalVar('castAggroPolls', 0)
        return
    end

    for _, entry in pairs(mob:getEnmityList()) do
        if entry.entity then
            mob:setLocalVar('castAggroPolls', 0)
            xi.dynamis.onSharedEngage(mob, entry.entity)
            xi.dynamis.checkEyeColor(mob)
            return
        end
    end

    mob:setLocalVar('castAggroPolls', polls + 1)
    mob:timer(castAggroPollMs, function(mobArg)
        pollCastAggro(mobArg)
    end)
end

local function addCastAggroListeners(mob)
    mob:removeListener('DYNAMIS_CAST_AGGRO_START')
    mob:addListener('MAGIC_START', 'DYNAMIS_CAST_AGGRO_START', function(mobArg)
        if
            mobArg:isEngaged() or
            mobArg:getLocalVar('engageCheck') == 1 or
            mobArg:getLocalVar('castAggroPolls') > 0
        then
            return
        end

        mobArg:setLocalVar('castAggroPolls', 1)
        pollCastAggro(mobArg)
    end)

    mob:removeListener('DYNAMIS_CAST_AGGRO_EXIT')
    mob:addListener('MAGIC_STATE_EXIT', 'DYNAMIS_CAST_AGGRO_EXIT', function(mobArg)
        mobArg:setLocalVar('castAggroPolls', 0)
    end)
end

-- Need to add a table to track spawn positions
xi.dynamis.insideSpawnAdds = xi.dynamis.insideSpawnAdds or {}

local function isDefaultInsideSpawnPosition(spawnPos)
    return
        spawnPos ~= nil and
        spawnPos.x == 1.000 and
        spawnPos.y == 1.000 and
        spawnPos.z == 1.000
end

local function isDefaultInsideAdd(mob)
    local mobId = mob:getID()

    if xi.dynamis.insideSpawnAdds[mobId] == nil then
        xi.dynamis.insideSpawnAdds[mobId] = isDefaultInsideSpawnPosition(mob:getSpawnPos())
    end

    return xi.dynamis.insideSpawnAdds[mobId]
end

-- ---------------------
-- General Info functions
-- ---------------------
-- Must be called in onMobInitialize so that setStatRank runs before CalculateMobStats on first spawn.
-- Stat ranks come from the dynamis_* ecosystems; DEF is the only rank they don't define.
xi.dynamis.onSharedInitialize = function(mob)
    mob:setStatRank(xi.stat.DEF, xi.statRank.A)

    mob:addMod(xi.mod.STR, 10)
    mob:addMod(xi.mod.DEX, 10)
    mob:addMod(xi.mod.VIT, 10)
    mob:addMod(xi.mod.AGI, 10)
    mob:addMod(xi.mod.INT, 10)
    mob:addMod(xi.mod.MND, 10)
    mob:addMod(xi.mod.CHR, 10)

    mob:setMobMod(xi.mobMod.GIL_BONUS, -100)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
end

xi.dynamis.generalInfo = function(mob, modelSize)
    mob:setTrueDetection(true)
    mob:setSpawnAnimation(xi.spawnAnimation.SPECIAL)
    mob:setMobMod(xi.mobMod.CHARMABLE, 0)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 1)
    mob:setMobMod(xi.mobMod.NO_DESPAWN, 1)
    mob:setMobMod(xi.mobMod.CLAIM_TYPE, xi.claimType.NON_EXCLUSIVE)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setRoamFlags(xi.roamFlag.SCRIPTED)

    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING))
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 12)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 4)
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)

    mob:setModelSize(modelSize)
end

-- ---------------------------
-- Shared Event Handlers
-- ---------------------------
xi.dynamis.onSharedEngage = function(mob, target)
    local mobID   = mob:getID()
    local mobName = mob:getName()

    debugPrint('Mob engaged, checking for spawns...')
    debugPrint('Engaged mob ID: ' .. mobID .. ' (' .. mobName .. ') isSpawned: ' .. tostring(mob:isSpawned()))

    -- Stop the spawning if the mob is re-engaged after a wipe
    if mob:getLocalVar('engageCheck') == 1 then
        return
    end

    mob:setLocalVar('engageCheck', 1)
    local zoneId = mob:getZoneID()

    mob:setMobMod(xi.mobMod.MAGIC_DELAY, math.randomInt(5, 15)) -- Random magic delay to make the casts delayed

    local lineSpawnConfig = xi.dynamis.lineSpawns and xi.dynamis.lineSpawns[zoneId] and xi.dynamis.lineSpawns[zoneId][mobID]
    local firstAdd        = GetMobByID(mobID + 1)
    local defaultInside   = firstAdd ~= nil and isDefaultInsideAdd(firstAdd)

    -- Default inside statues use a short stun; explicit line spawns keep the normal stun.
    -- Stun would interrupt a cast, so a statue pulled mid-cast finishes it instead.
    if mob:getCurrentAction() ~= xi.action.category.MAGIC_CASTING then
        if lineSpawnConfig or not defaultInside then
            mob:stun(3000) -- Stun for 3 seconds
        else
            mob:stun(1000) -- Stun for 1 second
        end
    end

    -- Check for mobs on aggro conditions
    xi.dynamis.spawnAggroStatues(mob, target)

    -- If the mob has spawned from the master mob then do not check for more spawns
    if mob:getLocalVar('spawnedFromMaster') == 1 then
        debugPrint('I am an add, not spawning more mobs')
        return
    end

    local zoneSpawnTable = xi.dynamis.spawnTable and xi.dynamis.spawnTable[zoneId]
    local spawnEntry     = zoneSpawnTable and zoneSpawnTable[mobID]
    if not spawnEntry then
        debugPrint('No spawn table entry for engaged mob ID: ' .. mobID .. ' (' .. mobName .. ') in zone ID: ' .. zoneId)
        return
    end

    local count = spawnEntry[1]
    debugPrint('Spawn count from onSharedEngage: ' .. count)
    if count > 0 then
        xi.dynamis.spawnNextMobsOnce(mob, count, target)
    end
end

-- ---------------------
-- Statue functions
-- ---------------------
xi.dynamis.statueOnSpawn = function(mob, modelSize)
    -- Apply the general stats to from dynamis mobs
    xi.dynamis.generalInfo(mob, modelSize)
    mob:setSpawnAnimation(xi.spawnAnimation.NORMAL)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1) -- Statues do not stand back
    mob:setMod(xi.mod.UDMGMAGIC, -5000) -- 50% damage from magic
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.SILENCE)
    addCastAggroListeners(mob)

    if mob:getName() == 'Vanguard_Eye' then
        mob:setBaseSpeed(35)
    else
        mob:setBaseSpeed(15)
    end

    -- The statue behind the palace by Maat never leaves its spot, even while engaged
    if mob:getID() == xi.jeuno.mobs.GOBLIN_STATUE_64 then
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    end

    local mobId  = mob:getID()
    local zoneId = mob:getZoneID()
    -- If it paths its eyes should be open
    if
        xi.dynamis.paths and
        xi.dynamis.paths[zoneId] and
        xi.dynamis.paths[zoneId][mobId]
    then
        xi.dynamis.checkEyeColor(mob)
    else
        mob:setAnimationSub(0) -- Set statue to closed eye state
    end

    -- Lets check if it has an eye color. If it does we need to set it to not die
    -- Set the eye color before the 1 shot happens
    local eyeColor = xi.dynamis.eyeColor and xi.dynamis.eyeColor[zoneId] and xi.dynamis.eyeColor[zoneId][mobId]
    if eyeColor and eyeColor ~= xi.dynamis.eye.RED then
        mob:setUnkillable(true)
    end

    xi.dynamis.generatePath(mob)
end

xi.dynamis.checkEyeColor = function(mob)
    local zoneId = mob:getZoneID()
    local mobID  = mob:getID()

    -- Check if table values exist to prevent nil errors
    local eyeColor = xi.dynamis.eyeColor and xi.dynamis.eyeColor[zoneId] and xi.dynamis.eyeColor[zoneId][mobID]
    if
        eyeColor == xi.dynamis.eye.BLUE or
        eyeColor == xi.dynamis.eye.GREEN
    then
        mob:setAnimationSub(eyeColor)
    else
        mob:setAnimationSub(xi.dynamis.eye.RED) -- Default to red if none specified
    end
end

xi.dynamis.spawnAggroStatues = function(mob, target)
    local zoneId   = mob:getZoneID()
    local statueId = mob:getID()
    -- Check special spawns on aggro conditions
    local zoneAggro          = xi.dynamis.aggro[zoneId]
    local nonAggressiveSpawn = zoneAggro.nonAggressive and zoneAggro.nonAggressive[statueId]
    local aggressiveSpawn    = zoneAggro.aggressive and zoneAggro.aggressive[statueId]

    if nonAggressiveSpawn then
        for _, mobId in ipairs(nonAggressiveSpawn) do
            local mobToSpawn = GetMobByID(mobId)
            if mobToSpawn and not mobToSpawn:isSpawned() then
                mobToSpawn:spawn()
            end
        end
    end

    if aggressiveSpawn then
        for _, mobId in ipairs(aggressiveSpawn) do
            local mobToSpawn = GetMobByID(mobId)
            debugPrint('Aggressive Spawn Mob ID: ' .. mobId)
            if mobToSpawn and not mobToSpawn:isSpawned() then
                mobToSpawn:spawn()

                if target then
                    setTimerTarget(mobToSpawn, target)
                    mobToSpawn:timer(500, function(mobArg)
                        if mobArg then
                            local timerTarget = getTimerTarget(mobArg)
                            if timerTarget then
                                mobArg:updateEnmity(timerTarget)
                            end
                        end
                    end)
                end
            end
        end
    end
end

xi.dynamis.onStatueFight = function(mob, target)
    -- If its a normal statue don't try to do the restore effect
    local zoneId = mob:getZoneID()
    local eye    = xi.dynamis.eyeColor and xi.dynamis.eyeColor[zoneId] and xi.dynamis.eyeColor[zoneId][mob:getID()]
    if eye ~= xi.dynamis.eye.BLUE and eye ~= xi.dynamis.eye.GREEN then
        return
    end

    -- Need to check if the var was triggered already otherwise it will trigger the retore more than once
    -- The mob is unkillable so it will never die and trigger the death function, so we have to check the HP directly
    if
        mob:getHP() ~= 1 or
        mob:getLocalVar('hp1check') == 1
    then
        return
    end

    debugPrint('I am at 1 HP')
    -- I can probably just remove RED from everything, including the spawn files and use RED as default

    local zone    = mob:getZone()
    local players = zone:getPlayers()

    for _, playerObj in pairs(players) do
        -- Test is dead player triggers this
        if mob:checkDistance(playerObj) < 30 then
            if eye == xi.dynamis.eye.BLUE then
                debugPrint('Restoring HP to nearby players')
                local missingHP = playerObj:getMaxHP() - playerObj:getHP()
                playerObj:restoreHP(missingHP)
                playerObj:wakeUp()
                playerObj:messageBasic(xi.msg.basic.RECOVERS_HP, 0, missingHP)
                mob:injectActionPacket(playerObj:getID(), 11, 772, 0, 0, xi.msg.basic.AOE_REGAIN_HP, 0, missingHP)
            else
                local missingMP = playerObj:getMaxMP() - playerObj:getMP()
                playerObj:restoreMP(missingMP)
                playerObj:messageBasic(xi.msg.basic.RECOVERS_MP, 0, missingMP)
                mob:injectActionPacket(playerObj:getID(), 11, 773, 0, 0, xi.msg.basic.AOE_REGAIN_MP, 0, missingMP)
            end
        end
    end

    mob:setLocalVar('hp1check', 1)
    mob:timer(1000, function(mobArg)
        mobArg:setUnkillable(false)
        mobArg:setHP(0)
    end)
end

-- NONE    = 0,
-- RED     = 1, -- Default statue eye color
-- BLUE    = 2, -- HP refill
-- GREEN   = 3, -- MP refill
xi.dynamis.onStatueDeath = function(mob, player, optParams)
    if not optParams.isKiller then
        return
    end

    -- Make sure this only runs once FOR all players. Death functions get called for every single player
    if mob:getLocalVar('statueDeathCheck') == 1 then
        return
    end

    -- If the statue gets 1 shotted we need to force spawn the statues for aggro conditions
    if mob:getLocalVar('engageCheck') == 0 then
        xi.dynamis.spawnAggroStatues(mob, nil)
    end

    -- If the mob is one shotted we need to force spawn configured adds.
    local zoneId         = mob:getZoneID()
    local statueId       = mob:getID()
    local zoneSpawnTable = xi.dynamis.spawnTable and xi.dynamis.spawnTable[zoneId]
    local spawnEntry     = zoneSpawnTable and zoneSpawnTable[statueId]

    if
        mob:getLocalVar('engageCheck') == 0 and
        spawnEntry and
        spawnEntry[1] > 0
    then
        xi.dynamis.spawnNextMobsOnce(mob, spawnEntry[1], nil) -- Spawn the next X amount of IDs from that statue
    end

    mob:setLocalVar('statueDeathCheck', 1)

    -- This will check for TEs and NM deaths
    xi.dynamis.onMobDeath(mob, player, optParams)
end

-- ---------------------
-- Regular Mob functions
-- ---------------------
xi.dynamis.onMobSpawn = function(mob, mobType, modelSize)
    xi.dynamis.generalInfo(mob, modelSize)

    if
        mobType == xi.dynamis.mobType.NIGHTMARE and
        mob:getZoneID() ~= xi.zone.DYNAMIS_TAVNAZIA
    then
        mob:setRoamFlags(xi.roamFlag.NONE)
    end

    if isStationaryMob(mob) then
        mob:setRoamFlags(bit.bor(mob:getRoamFlags(), xi.roamFlag.SCRIPTED))
    end
end

xi.dynamis.onMobDisengage = function(mob)
    local spawnPos = mob:getSpawnPos()
    mob:timer(3000, function(mobArg)
        -- Check if mob is far from spawn position
        if mobArg:checkDistance(spawnPos) > 1 then
        -- Return to original spawn position
            mobArg:pathThrough({ spawnPos }, xi.path.flag.COORDS)
        end
    end)
end

xi.dynamis.onMobRoam = function(mob)
    if mob:getLocalVar('currentPath') == 1 then
        return
    end

    -- Check the rotation after the mob casts a spell on a party member
    local spawnPos = mob:getSpawnPos()
    if mob:checkDistance(spawnPos) < 1 then
        mob:setRotation(spawnPos.rot)
        return
    end
end

xi.dynamis.onMobDeath = function(mob, player, optParams)
    if not optParams.isKiller then
        return
    end

    if mob:getLocalVar('deathCheck') == 1 then
        return
    end

    local zone   = mob:getZone()
    local zoneId = mob:getZoneID()

    -- Check for time extensions
    xi.dynamis.addTimeToDynamis(zone, mob)

    -- Check for NM death actions
    xi.dynamis.onNMDeath(mob, player, optParams)

    -- Zone specific death actions
    if
        zoneId == xi.zone.DYNAMIS_VALKURM and
        mob:getName() == 'Nightmare_Fly'
    then
        xi.dynamis.flyCheck(zone)
    end

    if zoneId == xi.zone.DYNAMIS_TAVNAZIA then
        if
            mob:getName() == 'Nightmare_Worm' or
            mob:getName() == 'Nightmare_Antlion'
        then
            xi.dynamis.sjDeathCheck(zone)
        end

        local vanguardEyes =
        {
            [xi.tav.mobs.VANGUARD_EYE_9]  = true,
            [xi.tav.mobs.VANGUARD_EYE_15] = true,
            [xi.tav.mobs.VANGUARD_EYE_67] = true,
            [xi.tav.mobs.VANGUARD_EYE_75] = true,
        }

        if vanguardEyes[mob:getID()] then
            xi.dynamis.checkQmSpawn(mob, zone, zoneId)
        end
    end

    mob:setLocalVar('deathCheck', 1)
end

-- ---------------------
-- NM Mob functions
-- ---------------------
-- NM Death Actions - define conditional spawns when specific NMs die
xi.dynamis.onNMDeath = function(mob, player, optParams)
    if not optParams.isKiller then
        return
    end

    local zoneId = mob:getZoneID()
    local mobID = mob:getID()
    local zone = mob:getZone()

    -- Get the death var for this mob
    local deathVarByMob = xi.dynamis.deathVarByMob[zoneId]
    if not deathVarByMob or not deathVarByMob[mobID] then
        return
    end

    local deathVar = deathVarByMob[mobID]

    -- We set the var for three reasons:
    -- 1. To track that this NM has been killed for future checks
    -- 2. To prevent double spawns if the NM is revived and killed again
    -- 3. To allow GMs in case of bugs/crashes to reset the var and respawn the NM
    zone:setLocalVar(deathVar, 1)

    -- Check spawnCheck table for any spawn conditions that are now met
    local spawnCheckTable = xi.dynamis.spawnCheck[zoneId]
    if not spawnCheckTable or #spawnCheckTable == 0 then
        return
    end

    for _, spawnCheck in ipairs(spawnCheckTable) do
        -- Only evaluate if it hasn't spawned yet and spawnedVar is valid
        local spawnedVar = spawnCheck.spawnedVar and zone:getLocalVar(spawnCheck.spawnedVar)
        if spawnedVar ~= 1 then
            -- Check if all required vars are met
            local allRequiredVarsMet = true

            for _, requiredVar in ipairs(spawnCheck.requiredVars or {}) do
                if zone:getLocalVar(requiredVar) ~= 1 then
                    allRequiredVarsMet = false
                    break
                end
            end

            -- If all conditions are met, spawn and set the var to prevent respawn
            if allRequiredVarsMet and spawnCheck.spawn and spawnCheck.spawnedVar then
                local spawn = spawnCheck.spawn
                if type(spawn) == 'function' then
                    spawn = spawn()
                end

                xi.dynamis.spawnWave(spawn)
                zone:setLocalVar(spawnCheck.spawnedVar, 1)
            end
        end
    end
end

-- ---------------------
-- Boss functions
-- ---------------------
xi.dynamis.onBossInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.TERROR)

    -- Need to set this NMs pets differently
    if mob:getName() == 'Dagourmarche' then
        xi.pet.setMobPet(mob, 2, 'Dagourmarches_Avatar')
    end
end

xi.dynamis.onBossSpawn = function(mob, modelSize)
    mob:setSpawnAnimation(xi.spawnAnimation.NORMAL)
end

xi.dynamis.onBossEngage = function(mob, target)
    -- TODO: for qufim bosses maybe
end

xi.dynamis.onBossRoam = function(mob)
end

xi.dynamis.onBossDeath = function(mob, player, optParams)
    if not optParams.isKiller then
        return
    end

    -- Death happens once per player - only run once per mob
    if mob:getLocalVar('deathTriggered') == 1 then
        return
    end

    mob:setLocalVar('deathTriggered', 1)

    -- Set position for win QM
    local zoneId = mob:getZoneID()
    local pos    = mob:getPos()
    local winQM  = GetNPCByID(xi.dynamis.dynaInfoEra[zoneId].winQM)

    if winQM then
        winQM:setPos(pos.x, pos.y, pos.z, pos.rot)
        winQM:setStatus(xi.status.NORMAL)
    end

    -- Run normal dead function
    xi.dynamis.onMobDeath(mob, player, optParams)
end

-- ---------------------
-- Summoner and Beastmaster 2 hour functions
-- ---------------------
-- Dynamis summon mechanics:
-- SMN: Call a random avatar shortly after spawning
--      Summon stays out and fights. Once the master goes below a certain % it uses astral flow
-- BST: Call its pet shortly after spawning (same summoning animation as SMN masters)
--      The pet is never resummoned. 2hr is Familiar if the pet is alive, Charm if it is dead
local possibleAvatars =
{
    xi.pets.summon.type.CARBUNCLE,
    xi.pets.summon.type.IFRIT,
    xi.pets.summon.type.TITAN,
    xi.pets.summon.type.LEVIATHAN,
    xi.pets.summon.type.GARUDA,
    xi.pets.summon.type.SHIVA,
    xi.pets.summon.type.RAMUH,
}

-- Regular TP skill lists (Mob_Avatar_* in mob_skill_lists); the shared pool only carries Carbuncle's.
local avatarSkillLists =
{
    [xi.pets.summon.type.CARBUNCLE] = 721,
    [xi.pets.summon.type.IFRIT    ] = 715,
    [xi.pets.summon.type.TITAN    ] = 716,
    [xi.pets.summon.type.LEVIATHAN] = 717,
    [xi.pets.summon.type.GARUDA   ] = 718,
    [xi.pets.summon.type.SHIVA    ] = 719,
    [xi.pets.summon.type.RAMUH    ] = 720,
}

-- pet is master + 1
local function getMasterPet(master)
    local pet = GetMobByID(master:getID() + 1)
    if pet then
        return pet
    end

    return nil
end

-- Retry the summon until it goes off (note: callPets fails while slept/stunned)
-- Once the pet is out, death is permanent - thank you BO
local function trySummonPet(mob)
    if not mob:isSpawned() or mob:isDead() then
        return
    end

    local pet = getMasterPet(mob)
    if not pet or pet:isAlive() then
        return
    end

    local callPetParams =
    {
        callPetJob   = xi.job.SMN, -- BST masters use the SMN summoning animation too
        inactiveTime = 3000, -- Casting animation time
        superLink    = true,
        dieWithOwner = mob:getMainJob() == xi.job.SMN, -- BST pets stay alive if master dies
        maxSpawns    = 1,
    }

    if not xi.mob.callPets(mob, pet:getID(), callPetParams) then
        mob:timer(3000, function(mobArg)
            trySummonPet(mobArg)
        end)
    end
end

-- Shared spawn logic for SMN and BST masters
xi.dynamis.masterOnSpawn = function(mob)
    local masterJob = mob:getMainJob()
    if masterJob ~= xi.job.SMN and masterJob ~= xi.job.BST then
        return
    end

    local pet = getMasterPet(mob)
    if not pet then
        return
    end

    if masterJob == xi.job.SMN then
        -- Remove the spell list because when it casts a spell the entire summons dont work
        mob:setSpellList(0)

        -- avatar is +1
        mob:setMobMod(xi.mobMod.ASTRAL_PET_OFFSET, 1)
    else
        -- Removes call beast from the skill list
        mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 0)
    end

    -- Randomize the HP% that triggers the 2hr
    mob:setLocalVar('twoHourHPP', math.randomInt(25, 75))

    -- Stop the job mixin
    mob:setLocalVar('[jobSpecial]chance', 0)

    -- Call the pet shortly after spawning
    -- Might need tweaking
    mob:timer(2000, function(mobArg)
        trySummonPet(mobArg)
    end)
end

xi.dynamis.summonerOnFight = function(mob, target)
    local pet = getMasterPet(mob)
    if not pet then
        return
    end

    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Do the 2hr and set the var for astral flow
    if
        mob:getLocalVar('twoHourUsed') == 0 and
        mob:getHPP() < mob:getLocalVar('twoHourHPP')
    then
        mob:setLocalVar('twoHourUsed', 1)

        if pet:isAlive() then
            -- Engage the avatar and tell it to fire its flow ability
            pet:updateEnmity(target)
            pet:setLocalVar('astralFlowUsed', 1)
            debugPrint('Master ' .. mob:getID() .. ' 2hr with avatar ' .. pet:getID() .. ' alive')
        else
            -- Avatar died: Astral Flow instantly spawns it back (no summon cast)
            if pet:isSpawned() then
                DespawnMob(pet:getID())
            end

            local pos = mob:getPos()
            pet:setSpawn(pos.x + 2, pos.y, pos.z + 2, pos.rot)
            pet:spawn()
            pet:updateEnmity(target)
            pet:setLocalVar('astralFlowUsed', 1)
            debugPrint('Master ' .. mob:getID() .. ' 2hr: instantly revived avatar ' .. pet:getID())
        end

        mob:useMobAbility(xi.mobSkill.ASTRAL_FLOW_1)
        return
    end
end

xi.dynamis.beastmasterOnFight = function(mob, target)
    local pet = getMasterPet(mob)
    if not pet then
        return
    end

    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Can only use the 2hrs once
    -- Familiar if the pet is still alive
    -- Charm if it is dead
    if
        mob:getLocalVar('twoHourUsed') == 0 and
        mob:getLocalVar('twoHourHPP') > 0 and
        mob:getHPP() < mob:getLocalVar('twoHourHPP')
    then
        mob:setLocalVar('twoHourUsed', 1)

        if pet:isAlive() then
            mob:useMobAbility(xi.mobSkill.FAMILIAR_1)
            debugPrint('Master ' .. mob:getID() .. ' 2hr Familiar with pet ' .. pet:getID() .. ' alive')
        else
            mob:useMobAbility(xi.mobSkill.CHARM)
            debugPrint('Master ' .. mob:getID() .. ' 2hr Charm, pet dead')
        end
    end
end

xi.dynamis.avatarOnSpawn = function(mob)
    -- Remove all the mixin listeners
    mob:removeListener('AVATAR_SPAWN')
    mob:removeListener('AVATAR_ENGAGE')
    mob:removeListener('AVATAR_MOBSKILL_FINISHED')

    -- Random avatar appearance, spell list, astral flow ability and TP skill list
    local avatar = possibleAvatars[math.randomInt(1, #possibleAvatars)]
    xi.pets.summon.setupSummon(mob, { avatar })
    mob:setMobMod(xi.mobMod.SKILL_LIST, avatarSkillLists[avatar])

    xi.combat.behavior.enableAllActions(mob)

    debugPrint('Avatar ' .. mob:getID() .. ' spawned | astralFlowId ' .. mob:getLocalVar('astralFlowId'))
end

xi.dynamis.avatarOnFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    if
        mob:getLocalVar('astralFlowUsed') == 1 and
        mob:checkDistance(target) <= 25
    then
        mob:useMobAbility(mob:getLocalVar('astralFlowId'))
        mob:setLocalVar('astralFlowUsed', 0)
    end
end

-- ---------------------
-- Spawn mechanics
-- ---------------------
local function isValidSpawnNumber(value)
    return type(value) == 'number' and value == value
end

local function getLineSpawnRotation(statuePos)
    local rot     = isValidSpawnNumber(statuePos.rot) and statuePos.rot or 0
    local radians = 2 * math.pi - (rot / 256) * 2 * math.pi
    return math.cos(radians), math.sin(radians)
end

local function setSpawnPosition(mobToSpawn, x, y, z, rot, fallbackPos)
    if
        not isValidSpawnNumber(x) or
        not isValidSpawnNumber(y) or
        not isValidSpawnNumber(z)
    then
        if
            not fallbackPos or
            not isValidSpawnNumber(fallbackPos.x) or
            not isValidSpawnNumber(fallbackPos.y) or
            not isValidSpawnNumber(fallbackPos.z)
        then
            return
        end

        x = fallbackPos.x
        y = fallbackPos.y
        z = fallbackPos.z
    end

    if not isValidSpawnNumber(rot) then
        rot = 0
    end

    mobToSpawn:setSpawn(x, y, z, rot)
end

local function calculateBehindLineSpawnPosition(statuePos, behindDistance, sideDistance)
    local cosRot, sinRot = getLineSpawnRotation(statuePos)

    return
        statuePos.x + cosRot * -behindDistance - sinRot * sideDistance,
        statuePos.y,
        statuePos.z + sinRot * -behindDistance + cosRot * sideDistance,
        true,
        false
end

local function calculateBehindSpawnPosition(statuePos, distance)
    local cosRot, sinRot = getLineSpawnRotation(statuePos)

    return
        statuePos.x + cosRot * -distance,
        statuePos.y,
        statuePos.z + sinRot * -distance,
        true,
        false
end

local function calculateSideSpawnPosition(statuePos, distance)
    local cosRot, sinRot = getLineSpawnRotation(statuePos)

    return
        statuePos.x + sinRot * distance,
        statuePos.y,
        statuePos.z + cosRot * distance,
        true,
        false
end

local function calculateRingSpawnPosition(statuePos, spawnedCount, count, radius)
    local angle = (spawnedCount / count) * 2 * math.pi

    return
        statuePos.x + math.cos(angle) * radius,
        statuePos.y,
        statuePos.z + math.sin(angle) * radius
end

local function calculateLineSpawnPosition(statuePos, lineSpawnConfig, spawnedCount, defaultInside)
    local spawnIndex = spawnedCount + 1

    if lineSpawnConfig then
        local behindLine = lineSpawnConfig.behindLine
        if behindLine then
            local rawBehind      = behindLine.behind
            local behindDistance = type(rawBehind) == 'table' and (rawBehind[spawnIndex] or 0) or (rawBehind or 0)
            local sideDistance   = behindLine.side and behindLine.side[spawnIndex] or 0

            return calculateBehindLineSpawnPosition(statuePos, behindDistance, sideDistance)
        end

        local behindDistance = lineSpawnConfig.behind and lineSpawnConfig.behind[spawnIndex]
        if behindDistance then
            return calculateBehindSpawnPosition(statuePos, behindDistance)
        end

        local sideDistance = lineSpawnConfig.side and lineSpawnConfig.side[spawnIndex]
        if sideDistance then
            return calculateSideSpawnPosition(statuePos, sideDistance)
        end

        local offset = lineSpawnConfig[spawnIndex]
        if offset then
            return statuePos.x + offset[1], statuePos.y + offset[2], statuePos.z + offset[3], true, false
        end
    end

    if defaultInside then
        return statuePos.x, statuePos.y, statuePos.z, true, true
    end

    return statuePos.x, statuePos.y, statuePos.z, false, false
end

xi.dynamis.spawnNextMobsOnce = function(statue, count, target)
    debugPrint('Spawning next mobs once...')
    if
        count <= 0 or
        statue:getLocalVar('spawnedAdds') == 1
    then
        return
    end

    statue:setLocalVar('spawnedAdds', 1)

    local statueId        = statue:getID()
    local statuePos       = statue:getPos()
    local randomHoldTime  = math.randomInt(4000, 8000)
    local zoneId          = statue:getZoneID()
    local zoneSpawnTable  = xi.dynamis.spawnTable and xi.dynamis.spawnTable[zoneId]
    local lineSpawnConfig = xi.dynamis.lineSpawns and xi.dynamis.lineSpawns[zoneId] and xi.dynamis.lineSpawns[zoneId][statueId]
    local isAnimatedMob   = statue:getName():find('^Animated') ~= nil
    local spawnedCount    = 0
    local i               = 1

    -- i <= 20 is a safeguard
    while spawnedCount < count and i <= 20 do
        local mobId = statueId + i

        if zoneSpawnTable and zoneSpawnTable[mobId] then
            debugPrint('Stopping add scan for statue ' .. statueId .. ' at next configured statue ' .. mobId)
            break
        end

        local mobToSpawn = GetMobByID(mobId)

        -- If the mob you are trying to spawn is a pet, skip it and keep walking IDs.
        if
            mobToSpawn == nil or
            mobToSpawn:getMaster() ~= nil or
            mobToSpawn:isSpawned()
        then
            i = i + 1
        else
            -- mobToSpawn:setMobMod(xi.mobMod.SUPERLINK, statue:getTargID())
            mobToSpawn:setRoamFlags(xi.roamFlag.SCRIPTED)

            -- Learn the classification now, before any setSpawn below overwrites the DB sentinel
            local defaultInside = isDefaultInsideAdd(mobToSpawn)

            local spawnX, spawnY, spawnZ, shouldSetSpawn, spawnOnTop
            if isAnimatedMob then
                spawnX, spawnY, spawnZ = calculateRingSpawnPosition(statuePos, spawnedCount, count, 3)
                shouldSetSpawn         = true
                spawnOnTop             = false
            else
                spawnX, spawnY, spawnZ, shouldSetSpawn, spawnOnTop = calculateLineSpawnPosition(statuePos, lineSpawnConfig, spawnedCount, defaultInside)
            end

            -- Inside adds share the statue's position, so spread their return points or they stack after disengaging
            if spawnOnTop then
                spawnX, spawnY, spawnZ = calculateRingSpawnPosition(statuePos, spawnedCount, count, 1.5)
            end

            if shouldSetSpawn then
                setSpawnPosition(mobToSpawn, spawnX, spawnY, spawnZ, statuePos.rot, statuePos)
            end

            -- Sets the "pet" model sizes to one below its master
            local mainSize = statue:getModelSize()
            if string.find(mobToSpawn:getName(), 'Nightmare') then
                if mainSize > 1 then
                    mobToSpawn:setModelSize(mainSize - 1)
                end
            end

            if spawnOnTop then
                -- Start after 2 seconds, then spawn 2 seconds apart at wherever the statue is by then.
                local capturedMob    = mobToSpawn
                local capturedIndex  = spawnedCount
                local capturedDelay  = (spawnedCount + 1) * 2000
                local capturedTarget = target
                statue:timer(capturedDelay, function(statueArg)
                    if not capturedMob or capturedMob:isSpawned() then
                        return
                    end

                    local currentPos = statueArg:getPos()
                    local ringX, ringY, ringZ = calculateRingSpawnPosition(currentPos, capturedIndex, count, 1.5)
                    setSpawnPosition(capturedMob, ringX, ringY, ringZ, currentPos.rot, currentPos)

                    spawnWithAnim(capturedMob)

                    capturedMob:setLocalVar('spawnedFromMaster', 1)
                    setTimerTarget(capturedMob, capturedTarget)
                    local timerTarget = getTimerTarget(capturedMob)
                    if timerTarget then
                        capturedMob:updateEnmity(timerTarget)
                    end
                end)
            else
                spawnWithAnim(mobToSpawn)
                mobToSpawn:setLocalVar('spawnedFromMaster', 1)
                setTimerTarget(mobToSpawn, target)

                -- One-shot force spawns call this without a target, so only normal engage pulls adds in.
                if target then
                    mobToSpawn:updateEnmity(target)
                end

                holdSpawnedAdd(mobToSpawn, randomHoldTime)
            end

            spawnedCount = spawnedCount + 1
            i = i + 1
        end
    end
end

xi.dynamis.spawnWave = function(wave)
    if not wave then
        return
    end

    for _, mobId in ipairs(wave) do
        local mob = GetMobByID(mobId)
        if mob and not mob:isSpawned() then
            mob:spawn()
        end
    end
end

-----------------------------------
--    Dynamis Mob Pathing/Roam   --
-----------------------------------
xi.dynamis.generatePath = function(mob)
    local zoneId = mob:getZoneID()
    local mobId  = mob:getID()

    if
        xi.dynamis.paths and
        xi.dynamis.paths[zoneId] and
        xi.dynamis.paths[zoneId][mobId] ~= nil
    then
        local pathData = xi.dynamis.paths[zoneId][mobId]
        local first = pathData[1]
        local second = pathData[2]
        local pathNodes =
        {
            { x = first[1],  y = first[2],  z = first[3],  wait = 1000 },
            { x = second[1], y = second[2], z = second[3], wait = 1000 }
        }
        mob:pathThrough(pathNodes, xi.path.flag.PATROL)
        mob:setLocalVar('currentPath', 1)
    end
end
