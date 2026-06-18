-----------------------------------
-- Mob Hunt campaign
-----------------------------------

xi = xi or {}
xi.events = xi.events or {}
xi.events.mobHunt = xi.events.mobHunt or {}

local scheduledEvent = xi.events.ScheduledEvent
local logPath = 'log/mobHunt_audit.log'

local event = scheduledEvent:new('mobHunt')

local function safeLog(msg)
    local logFile = io.open(logPath, 'a')
    if logFile then
        logFile:write(msg)
        logFile:close()
    end
end

xi.events.mobHunt.getIsActive = function()
    if type(event.getIsActive) == 'function' then
        return event:getIsActive()
    end

    return false
end

local mobHuntZones =
{
    xi.zone.EAST_RONFAURE, xi.zone.WEST_RONFAURE, xi.zone.LA_THEINE_PLATEAU, xi.zone.JUGNER_FOREST, xi.zone.BATALLIA_DOWNS,
    xi.zone.SOUTH_GUSTABERG, xi.zone.NORTH_GUSTABERG, xi.zone.KONSCHTAT_HIGHLANDS, xi.zone.PASHHOW_MARSHLANDS, xi.zone.ROLANBERRY_FIELDS,
    xi.zone.WEST_SARUTABARUTA, xi.zone.EAST_SARUTABARUTA, xi.zone.TAHRONGI_CANYON, xi.zone.MERIPHATAUD_MOUNTAINS, xi.zone.SAUROMUGUE_CHAMPAIGN,
    xi.zone.VALKURM_DUNES, xi.zone.BUBURIMU_PENINSULA, xi.zone.QUFIM_ISLAND,
}

local hintChance = 0.33

local mobHuntConfrontation = 2025

xi.events.mobHunt.isHuntTargetActive = function()
    local huntTargetID = GetServerVariable('[MobHunt]Target')

    if huntTargetID == 0 then
        return false
    end

    local huntTarget = GetMobByID(huntTargetID)

    if not huntTarget or not huntTarget:isAlive() then
        return false
    end

    if huntTarget:getLocalVar('[MobHunt]isTarget') == 0 then
        return false
    end

    return true
end

xi.events.mobHunt.activateNewHuntTarget = function(retries)
    retries = (retries or 0) + 1

    print('[MobHunt]activateNewHuntTarget')

    local previousHuntTargetID = GetServerVariable('[MobHunt]Target')
    local previousHuntTarget   = previousHuntTargetID > 0 and GetMobByID(previousHuntTargetID) or nil
    local previousHuntZoneID   = previousHuntTarget and previousHuntTarget:getZoneID() or 0

    local huntZoneID = mobHuntZones[math.random(#mobHuntZones)]

    if huntZoneID == previousHuntZoneID then
        if retries <= 10 then
            xi.events.mobHunt.activateNewHuntTarget(retries)
        end

        return
    end

    local huntTargetID
    local huntTarget

    local function isValidHuntTarget(mob)
        return
        (
            mob and
            mob:isAlive() and
            mob:getSpawnType() == xi.spawnType.NORMAL and
            not mob:isNM() and
            mob:getRespawnTime() < 600 * 1000 and
            #(mob:getEnmityList() or {}) == 0
        )
    end

    local attempts = 0

    repeat
        attempts = attempts + 1

        -- The first 1024 (0x400) IDs in a zone are reserved for mobs.
        -- Mob IDs include the zone ID in bits 5 - 16, the first four bits are always 0001
        huntTargetID = bit.lshift(0x1000 + huntZoneID, 12) + math.random(0x400) - 1
        huntTarget   = GetMobByID(huntTargetID)
        if huntTarget then
            print('[MobHunt]activateNewHuntTarget ' .. huntTargetID .. ' ' .. huntTarget:getSpawnType() .. ' ' .. huntTarget:getRespawnTime() .. ' ' .. #(huntTarget:getEnmityList() or {}))
        end
    until isValidHuntTarget(huntTarget) or attempts >= 32

    if not isValidHuntTarget(huntTarget) then
        for targetID = 0, 0x400 - 1 do
            huntTargetID = bit.lshift(0x1000 + huntZoneID, 12) + targetID
            huntTarget   = GetMobByID(huntTargetID)

            if isValidHuntTarget(huntTarget) then
                break
            end
        end
    end

    if not isValidHuntTarget(huntTarget) then
        print('[MobHunt] ERROR! Could not find valid hunt target in zone ' .. huntZoneID .. '.')

        if retries <= 10 then
            xi.events.mobHunt.activateNewHuntTarget(retries)
        end

        return
    end

    xi.events.mobHunt.setHuntTarget(huntTarget)
end

local function setWhileSavingMobMod(mob, mobModName, newValue)
    mob:setLocalVar('[MobHunt]' .. mobModName, mob:getMobMod(xi.mobMod[mobModName]))
    mob:setMobMod(xi.mobMod[mobModName], newValue)
end

local function restoreMobMod(mob, mobModName)
    mob:setMobMod(xi.mobMod[mobModName], mob:getLocalVar('[MobHunt]' .. mobModName))
end

xi.events.mobHunt.setHuntTarget = function(huntTarget)
    local previousHuntTargetID = GetServerVariable('[MobHunt]Target')
    local previousHuntTarget   = previousHuntTargetID > 0 and GetMobByID(previousHuntTargetID) or nil

    if previousHuntTarget then
        xi.events.mobHunt.cleanupHuntTarget(previousHuntTarget)
    end

    print('[MobHunt]setHuntTarget')

    huntTarget:getZone():increaseStayAwakeCounter()
    huntTarget:timer(3 * 1000, function(huntTargetLocal)
        huntTargetLocal:getZone():decreaseStayAwakeCounter()
    end)

    SetServerVariable('[MobHunt]Target', huntTarget:getID())
    huntTarget:setLocalVar('[MobHunt]isTarget', 1)

    huntTarget:setMobLevel(40)
    huntTarget:timer(0, function(huntTargetLocal)
        setWhileSavingMobMod(huntTargetLocal, 'CHECK_AS_NM', 1)
        -- setWhileSavingMobMod(huntTargetLocal, 'DRAW_IN', 1) -- Removed for LSB (Not a standard modifier)
        setWhileSavingMobMod(huntTargetLocal, 'ALWAYS_AGGRO', 1)
        setWhileSavingMobMod(huntTargetLocal, 'DETECTION', xi.detects.HEARING)
        setWhileSavingMobMod(huntTargetLocal, 'SOUND_RANGE', 20)
        setWhileSavingMobMod(huntTargetLocal, 'NO_LINK', 1)
        setWhileSavingMobMod(huntTargetLocal, 'CLAIM_TYPE', xi.claimType.UNCLAIMABLE)
        setWhileSavingMobMod(huntTargetLocal, 'NO_DESPAWN', 1)
        huntTargetLocal:setTrueDetection(true)
        huntTargetLocal:addStatusEffect(xi.effect.CONFRONTATION, { power = mobHuntConfrontation, tick = 0, duration = 0, origin = huntTargetLocal })
    end)

    huntTarget:addListener('ENMITY', 'MOB_HUNT_ENMITY', function(mob, target)
        --print('[MobHunt]MOB_HUNT_ENMITY')
        if target:getMaster() then
            target = target:getMaster()
        end

        if target:getLocalVar('[MobHunt]Participated') == 0 then
            target:setLocalVar('[MobHunt]Participated', 1)

            -- Technically this logic is flawed. Players could disconnect or zone and come back, or turn Confrontation off and on.
            -- We will accept this flaw temporarily.
            local participants = target:getLocalVar('[MobHunt]Participants') + 1

            if participants > 6 then
                mob:addMod(xi.mod.HPP, 10)
                mob:updateHealth()
                mob:addHP(mob:getBaseHP() * 0.1)
            end
        end

        xi.events.mobHunt.join(target)
    end)

    huntTarget:addListener('TICK', 'MOB_HUNT_TICK', function(mob)
        local entities = mob:getEntitiesInRange(mob, xi.aoeType.ROUND, xi.aoeRadius.ATTACKER, 20, 0, xi.targetType.PLAYER)
        local time     = GetSystemTime()

        local nearbyPlayer

        for _, entity in pairs(entities) do
            if entity:isPC() then
                nearbyPlayer = entity

                if entity:checkDistance(mob) < 20 then -- Temporary fix since getNearbyEntities() is ignoring distance argument.
                    if
                        entity:getConfrontationEffect() == mobHuntConfrontation and
                        entity:isDead() and
                        time >= entity:getLocalVar('[MobHunt]NextRaise')
                    then
                        entity:setLocalVar('[MobHunt]NextRaise', time + 5)
                        entity:timer(3 * 1000, function(entityLocal)
                            entityLocal:sendRaise(3)
                        end)
                    end

                    if
                        entity:getConfrontationEffect() ~= mobHuntConfrontation and
                        entity:isAlive() and
                        mob:isAlive()
                    then
                        xi.events.mobHunt.join(entity)
                        entity:addStatusEffect(xi.effect.STUN, { power = 1, tick = 0, duration = 3, origin = mob })
                        entity:printToPlayer('The hunt target spotted you!', xi.msg.channel.SYSTEM_3)
                    end

                    if mob:getLocalVar('[MobHunt]Participants') == 0 then
                        mob:setLocalVar('[MobHunt]Participants', 1)
                        mob:setLocalVar('[MobHunt]RageTime', time + 10 * 60)
                        entity:printToPlayer(string.format('%s has discovered the hunt target! Let the battle commence...', entity:getName()), xi.msg.channel.NS_SHOUT)
                        entity:printToArea(string.format('%s has discovered the hunt target! Let the battle commence...', entity:getName()), xi.msg.channel.NS_SHOUT, xi.msg.area.SHOUT)
                    end
                end
            end
        end

        if not nearbyPlayer then
            return
        end

        local rageTime = mob:getLocalVar('[MobHunt]RageTime')
        local rage     = mob:getLocalVar('[MobHunt]Rage')

        if rageTime > 0 and time >= rageTime and rage < 10 then
            local rageData =
            {
                [0] = { offset = 0,                msg = 'The hunt target is starting to get angry...',      mod = true  },
                [1] = { offset = 1.25 * 60,        msg = 'The hunt target is angry...',                      mod = true  },
                [2] = { offset = 2.5 * 60,         msg = 'The hunt target is becoming furious...',           mod = true  },
                [3] = { offset = 3.75 * 60,        msg = 'The hunt target is enraging...',                   mod = true  },
                [4] = { offset = 5 * 60,           msg = 'The hunt target is apoplectic with rage!',         mod = true  },
                [5] = { offset = 10 * 60,          msg = 'The hunt target is getting bored...',              mod = false },
                [6] = { offset = 11.25 * 60,       msg = 'The hunt target is thinking about leaving...',     mod = false },
                [7] = { offset = 12.5 * 60,        msg = 'The hunt target is going to leave soon...',        mod = false },
                [8] = { offset = 13.75 * 60,       msg = 'The hunt target is about to slip away...',         mod = false },
                [9] = { offset = 15 * 60,          msg = 'The hunt target got away!',                        mod = false, escape = true },
            }

            local data = rageData[rage]
            if data and time >= rageTime + data.offset then
                mob:setLocalVar('[MobHunt]Rage', rage + 1)

                if data.mod then
                    mob:addMod(xi.mod.DELAYP, -10)
                    mob:addMod(xi.mod.ATTP, 10)
                end

                nearbyPlayer:printToPlayer(data.msg, xi.msg.channel.NS_SHOUT)
                nearbyPlayer:printToArea(data.msg, xi.msg.channel.NS_SHOUT, xi.msg.area.SHOUT)

                if data.escape then
                    xi.events.mobHunt.huntTargetEscapes(mob)
                end
            end
        end
    end)
end

xi.events.mobHunt.cleanupHuntTarget = function(huntTarget)
    if huntTarget:isAlive() then
        huntTarget:setHP(0)
    end

    print('[MobHunt]cleanupHuntTarget')

    huntTarget:removeListener('MOB_HUNT_ENMITY')
    huntTarget:removeListener('MOB_HUNT_TICK')
    huntTarget:delStatusEffect(xi.effect.CONFRONTATION)

    if huntTarget:getLocalVar('[MobHunt]isTarget') > 0 then
        restoreMobMod(huntTarget, 'CHECK_AS_NM')
        -- restoreMobMod(huntTarget, 'DRAW_IN')
        restoreMobMod(huntTarget, 'ALWAYS_AGGRO')
        restoreMobMod(huntTarget, 'DETECTION')
        restoreMobMod(huntTarget, 'SOUND_RANGE')
        restoreMobMod(huntTarget, 'NO_LINK')
        restoreMobMod(huntTarget, 'CLAIM_TYPE')
        restoreMobMod(huntTarget, 'NO_DESPAWN')
        huntTarget:setMod(xi.mod.DELAYP, 0)
        huntTarget:setMod(xi.mod.ATTP, 0)
        huntTarget:setMod(xi.mod.HPP, 0)
        huntTarget:setLocalVar('[MobHunt]isTarget', 0)
    end

    huntTarget:setTrueDetection(false)
end

xi.events.mobHunt.join = function(player)
    if not player:isPC() then
        return
    end

    if player:getConfrontationEffect() ~= mobHuntConfrontation then
        player:addStatusEffect(xi.effect.CONFRONTATION, { power = mobHuntConfrontation, tick = 0, duration = 0, origin = player })
        player:levelRestriction(30)
    end
end

xi.events.mobHunt.quit = function(player)
    if not player:isPC() then
        return
    end

    if player:getLocalVar('[MobHunt]QuitQueued') == 0 then
        -- This queue (won't run while the player is dead) is a temporary measure to prevent gaining XP
        -- by dropping the level restriction and raising.
        player:setLocalVar('[MobHunt]QuitQueued', 1)
        player:queue(0, function(playerLocal)
            playerLocal:setLocalVar('[MobHunt]QuitQueued', 0)
            if playerLocal:getConfrontationEffect() == mobHuntConfrontation then
                playerLocal:delStatusEffect(xi.effect.CONFRONTATION)
                playerLocal:levelRestriction(0)
                playerLocal:setLocalVar('[MobHunt]Participated', 0)
            end
        end)
    end
end

xi.events.mobHunt.onMobDeath = function(mob, player, isKiller)
    if not xi.events.mobHunt.getIsActive() then
        return
    end

    if not (isKiller or not player) then
        -- Run only once per mob death
        -- Account for mob dying without being claimed (e.g. DoT after everyone died).
        return
    end

    local zoneID       = player:getZoneID()
    local huntTargetID = GetServerVariable('[MobHunt]Target')

    if mob:getID() == huntTargetID and mob:getLocalVar('[MobHunt]isTarget') > 0 then
        return xi.events.mobHunt.onHuntTargetDeath(mob, player, isKiller)
    end

    if
        not isKiller or
        math.random() > hintChance or
        not utils.contains(zoneID, mobHuntZones)
    then
        -- Only give hints in valid zones, and only some of the time.
        return
    end

    print('[MobHunt]onMobDeath hint')

    if not xi.events.mobHunt.isHuntTargetActive() then
        -- Make sure there's a hunt target.
        xi.events.mobHunt.activateNewHuntTarget()
    end

    huntTargetID = GetServerVariable('[MobHunt]Target')

    local huntTarget = GetMobByID(huntTargetID)

    if not huntTarget then
        return
    end

    local huntZoneID = huntTarget:getZoneID()

    player:timer(0, function(playerLocal)
        if playerLocal:getLocalVar('[MobHunt]ReceivedClue') == 0 then
            playerLocal:setLocalVar('[MobHunt]ReceivedClue', 1)
            safeLog(string.format('[%s] %s received a clue in %s.\n', os.date(), playerLocal:getName(), playerLocal:getZoneName()))
        end

        if zoneID == huntZoneID then
            playerLocal:printToPlayer('You suspect the hunt target is somewhere nearby!', xi.msg.channel.SYSTEM_3)
        else
            playerLocal:printToPlayer('You have a feeling the hunt target is somewhere else...', xi.msg.channel.SYSTEM_3)
        end
    end)
end

xi.events.mobHunt.onHuntTargetDeath = function(mob, player, isKiller)
    print('[MobHunt]onHuntTargetDeath')

    safeLog(string.format('[%s] %s was defeated by %s in %s.\n', os.date(), mob:getName(), (player and player:getName() or 'nobody'), mob:getZoneName()))

    mob:timer(0, function(mobLocal)
        local entities = mobLocal:getEntitiesInRange(mobLocal, xi.aoeType.ROUND, xi.aoeRadius.ATTACKER, 50, 0, xi.targetType.PLAYER)

        for _, entity in pairs(entities) do
            if
                entity:getConfrontationEffect() == mobHuntConfrontation and
                entity:getLocalVar('[MobHunt]Participated') > 0
            then
                entity:setLocalVar('[MobHunt]Participated', 0)
                entity:printToPlayer('You defeated the Mob Hunt target!', xi.msg.channel.SYSTEM_3)
                xi.events.mobHunt.distributeRewards(entity)
            end

            xi.events.mobHunt.quit(entity)
        end
    end)

    xi.events.mobHunt.activateNewHuntTarget()
end

xi.events.mobHunt.distributeRewards = function(player)
    player:setVar('LoginPoints', player:getVar('LoginPoints') + 1)
    player:printToPlayer('You gained 1 login point!', xi.msg.channel.NS_SAY)

    local possibleRewards =
    {
        { weight = 40, item = 'gil', minQuantity = 5000, maxQuantity = 10000, },
        { weight = 30, item = 'cruor', minQuantity = 250, maxQuantity = 1000, },
        { weight =  3, item = xi.item.GARRISON_TUNICA, },
        { weight =  3, item = xi.item.GARRISON_BOOTS, },
        { weight =  3, item = xi.item.GARRISON_HOSE, },
        { weight =  3, item = xi.item.GARRISON_GLOVES, },
        { weight =  3, item = xi.item.GARRISON_SALLET, },
    }

    local totalWeight = 0

    for _, reward in ipairs(possibleRewards) do
        totalWeight = totalWeight + reward.weight
    end

    local result

    repeat
        local random = math.random(1, totalWeight)

        for _, reward in ipairs(possibleRewards) do
            if random <= reward.weight then
                result = reward
                break
            end

            random = random - reward.weight
        end
    until result

    local ID = zones[player:getZoneID()]

    if result.signature then
        if player:addItem({ id = result.item, signature = result.signature }) then
            player:messageSpecial(ID.text.ITEM_OBTAINED, result.item)
            local item = player:getItem(result.item)
            safeLog(string.format('[%s] %s earned a "ChocoboColor" %s (%d).\n', os.date(), player:getName(), item:getName(), item:getID()))
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, result.item)
        end
    elseif result.item == 'gil' then
        local gil = math.random(result.minQuantity, result.maxQuantity)
        player:addGil(gil)
        player:messageSpecial(ID.text.GIL_OBTAINED, gil)
        safeLog(string.format('[%s] %s earned %d gil.\n', os.date(), player:getName(), gil))
    elseif result.item == 'cruor' then
        local cruor = math.random(result.minQuantity, result.maxQuantity)
        player:addCurrency('cruor', cruor)
        player:printToPlayer(string.format('Obtained %d cruor.', cruor), xi.msg.channel.NS_SAY)
        safeLog(string.format('[%s] %s earned %d cruor.\n', os.date(), player:getName(), cruor))
    else
        if npcUtil.giveItem(player, result.item) then
            local item = player:getItem(result.item)
            safeLog(string.format('[%s] %s earned a %s (%d).\n', os.date(), player:getName(), item:getName(), item:getID()))
        end
    end
end

xi.events.mobHunt.huntTargetEscapes = function(mob)
    print('[MobHunt]huntTargetEscapes')

    safeLog(string.format('[%s] %s wasn\'t defeated in time and escaped from %s.\n', os.date(), mob:getName(), mob:getZoneName()))

    local entities = mob:getEntitiesInRange(mob, xi.aoeType.ROUND, xi.aoeRadius.ATTACKER, 50, 0, xi.targetType.PLAYER)

    for _, entity in pairs(entities) do
        if
            entity:getConfrontationEffect() == mobHuntConfrontation and
            entity:getLocalVar('[MobHunt]Participated') > 0
        then
            entity:setLocalVar('[MobHunt]Participated', 0)
        end

        xi.events.mobHunt.quit(entity)
    end

    mob:despawn()
    xi.events.mobHunt.activateNewHuntTarget()
end

return xi.events.mobHunt
