-----------------------------------
-- Area: Full Moon Fountain
-- BCNM: Waking the Beast
-----------------------------------
local fullMoonFountainID = zones[xi.zone.FULL_MOON_FOUNTAIN]
-----------------------------------

local loot =
{
    xi.item.CARBUNCLES_CUFFS,
    xi.item.IFRITS_BOW,
    xi.item.SHIVAS_SHOTEL,
    xi.item.TITANS_BASELARDE,
    xi.item.GARUDAS_SICKLE,
    xi.item.LEVIATHANS_COUSE,
    xi.item.RAMUHS_MACE,
}

local avatarTwoHours =
{
    ['Carbuncle_Prime'] = 912,
    ['Garuda_Prime']    = 875,
    ['Ifrit_Prime']     = 848,
    ['Leviathan_Prime'] = 866,
    ['Ramuh_Prime']     = 893,
    ['Shiva_Prime']     = 884,
    ['Titan_Prime']     = 857,
}

-- need the ID of the main carby (spawned at start) for each area
-- as all other mob IDs for the area are calculated relative to this
local mainCarbyIDbyArea =
{
    [1] = fullMoonFountainID.mob.CARBUNCLE_PRIME,
    [2] = fullMoonFountainID.mob.CARBUNCLE_PRIME + 11,
    [3] = fullMoonFountainID.mob.CARBUNCLE_PRIME + 22,
}

-- enum to indicate which type of spawn
local spawnType =
{
    ELEMENTAL_AVATAR = 1,
    CARBUNCLE        = 2,
}

-- function to handle adding the loot to the treasure pool
local handleLoot = function(battlefield)
    local initiatorId, _ = battlefield:getInitiator()
    local players = battlefield:getPlayers()

    -- Get the first player, might be nil
    local playerToAddTreasure = next(players)

    for _, player in pairs(players) do
        if player and player:getID() == initiatorId then
            playerToAddTreasure = player
            break
        end
    end

    if playerToAddTreasure then
        -- Three loot pools with droprates estimated as follows: 40% -> 20% -> 10%
        local lootChance = 40
        for i = 1, 3 do
            if math.random(1, 100) <= lootChance then
                playerToAddTreasure:addTreasure(loot[math.random(1, 7)])
            end

            lootChance = lootChance / 2
        end
    end
end

-- function to check if all carbys are dead in phase 6
-- and thus players should win and get loot
local checkAllCarbyDead = function(mainCarbyID, battlefield)
    local allCarbyDead = true

    for i = 0, 4 do
        local carby = GetMobByID(mainCarbyID + i)
        if carby and carby:isAlive() then
            allCarbyDead = false
            break
        end
    end

    -- check also battlefield status as this function can be called
    -- even after setting battlefield status to won
    if allCarbyDead and battlefield:getStatus() ~= xi.battlefield.status.WON then
        battlefield:setStatus(xi.battlefield.status.WON)
        handleLoot(battlefield)
    end
end

-- utility function to add all the entities in the enmityList param to the enmityList of mob
-- also sets the current target to the entity with the highest enmity
local applyEnmity = function(mob, enmityList, battlefield)
    -- track the highest enmity entity in the list to set as current target
    local highestEnmityTarget = nil
    local highestEnmity = 0

    for i, v in pairs(enmityList) do
        local target = v.entity

        if
            target and
            -- make sure the target is still valid and in the battlefield
            target:getBattlefieldID() == battlefield:getID()
        then
            -- we need to explictly add enmity to make sure the target is one the list
            mob:addEnmity(target, 1, 0)

            local totalEnmity = v.ce + v.ve
            if totalEnmity >= highestEnmity then
                highestEnmity = totalEnmity
                highestEnmityTarget = target
            end
        end
    end

    if highestEnmityTarget then
        mob:updateEnmity(highestEnmityTarget)
    end
end

-- function to spawn the elemental (non-carby) avatars in phases 1, 3, and 5
local spawnElementalAvatars = function(spawnPosition, battlefield, numberAvatarsToSpawn, phase, content)
    for i = 1, numberAvatarsToSpawn do
        local avatarOrder = battlefield:getLocalVar('avatarOrder')
        -- use mod to get the right most digit (which represents the next avatar in the order)
        local nextIndex = avatarOrder % 10
        -- need an additional offset of 4 to skip the other 4 carbys to get to the avatar IDs
        local avatarID = mainCarbyIDbyArea[battlefield:getArea()] + 4 + nextIndex

        -- set special spawn animation so the avatars enter with their summoning animation
        local avatarPreSpawn = GetMobByID(avatarID)
        if avatarPreSpawn then
            avatarPreSpawn:setSpawnAnimation(1)
        end

        local avatarPostSpawn = SpawnMob(avatarID)

        if avatarPostSpawn then
            -- also have the avatar track the phase they spawn in
            avatarPostSpawn:setLocalVar('phase', phase)

            -- add death listener for setting some useful tracking variables for battlefield
            avatarPostSpawn:addListener('DEATH', 'WTB_SET_DEATH_VARS',
                function(deadAvatar)
                    -- set some local variables useful in determining the phases of the fight
                    deadAvatar:setLocalVar('wasDefeated', 1)
                    battlefield:setLocalVar('avatarsDefeated', battlefield:getLocalVar('avatarsDefeated') + 1)
                end
            )

            -- set back to normal spawn animation after spawning so players moving into
            -- range (of 50 yalms) get just the normal animation
            avatarPostSpawn:queue(3000, function(avatarArg)
                avatarArg:setSpawnAnimation(0)
            end)

            avatarPostSpawn:setPos(spawnPosition.x + math.random(-3, 3), spawnPosition.y, spawnPosition.z + math.random(-3, 3), spawnPosition.rot)
            local enmityList = content.lastEnmityList[battlefield:getArea()]
            -- if there is a saved enmityList and it is not empty
            if enmityList and next(enmityList) ~= nil then
                applyEnmity(avatarPostSpawn, enmityList, battlefield)
            end

            -- remove that right most digit and update the order
            battlefield:setLocalVar('avatarOrder', math.floor(avatarOrder / 10))

            -- about half the time have a single avatar of the phase show the specified text
            -- need to delay the showText by 2000 seconds to wait for the mob to appear
            if i == numberAvatarsToSpawn and math.random(1, 2) == 1 then
                avatarPostSpawn:queue(2000, function(avatarArg)
                    if avatarArg then
                        local players = avatarArg:getBattlefield():getPlayers()
                        for _, player in pairs(players) do
                            if player then
                                player:showText(avatarArg, fullMoonFountainID.text.LEAVE_THE_AFFAIRS_OF_GODS_TO)
                            end
                        end
                    end
                end)
            end
        end
    end
end

-- function to spawn carby(s) in phases 2, 4, and 6
local spawnCarby = function(carbyID, battlefield, content)
    local mainCarbyHP = battlefield:getLocalVar('mainCarbyHP')

    local carby = SpawnMob(carbyID) -- need nil check
    if carby then
        carby:setHP(mainCarbyHP)

        -- add death listener for setting some useful tracking variables for battlefield
        -- note that for carby this is only really needed in phase 6 so does not matter if not added to phase 0 carby
        carby:addListener('DEATH', 'WTB_SET_DEATH_VARS',
            function(deadCarby)
                -- set some local variables useful in determining the phases of the fight
                deadCarby:setLocalVar('wasDefeated', 1)
            end
        )

        local enmityList = content.lastEnmityList[battlefield:getArea()]
        -- if there is a saved enmityList and it is not empty
        if enmityList and next(enmityList) ~= nil then
            applyEnmity(carby, enmityList, battlefield)
        end
    end
end

-- function to despawn carby at the end of phases 0, 2, and 4
local despawnCarby = function(mainCarby, battlefield, content)
    -- set the lastEnmityList here instead of death function like elemental avatars
    -- because need to disengage (which clears enmity list) to get correct despawn animation
    content.lastEnmityList[battlefield:getArea()] = mainCarby:getEnmityList()
    battlefield:setLocalVar('mainCarbyHP', mainCarby:getHP())
    -- disengage first to get the correct despawn animation
    mainCarby:disengage()
    -- set untargetable so player does not hit carby during despawn process
    mainCarby:setUntargetable(true)
    -- send despawn animation packet so carby looks like he despawns
    -- cannot just setHP(0) here because otherwise player sees HP go to zero and gets death message
    mainCarby:setAnimation(xi.animation.DESPAWN)

    -- after the despawn animation plays then remove the left over name by setting status
    -- and then actually kill carby with setHP(0) (will not produce message for player)
    -- and allow carby to be targeted again (in preparation for next spawn)
    mainCarby:timer(7000, function(mobArg)
        if mobArg then
            mobArg:setStatus(xi.status.DISAPPEAR)
            mobArg:setHP(0)
            mobArg:setUntargetable(false)
        end
    end)
end

-- function to check if the carbys should 2hr in phase 6
local checkCarbyTwoHour = function(mainCarbyID, battlefield)
    -- if at least one carby has HPP < 10% then trigger 2hr on all carbys
    -- also trigger every 3 mins after that
    local triggerCoordTwoHour = false
    local lastCoorTwoHourTime = battlefield:getLocalVar('lastCoordTwoHour')

    -- if never triggered before then wait until 10% threshold
    if lastCoorTwoHourTime == 0 then
        for i = 0, 4 do
            local carby = GetMobByID(mainCarbyID + i)
            if
                carby and
                -- either defeated already
                ((carby:isDead() and carby:getLocalVar('wasDefeated') == 1) or
                -- or is alive with < 10% HPP
                (carby:isAlive() and carby:getHPP() < 10))
            then
                triggerCoordTwoHour = true
                battlefield:setLocalVar('lastCoordTwoHour', os.time())
                break
            end
        end
    -- else check the 3 min timer
    elseif os.time() > (lastCoorTwoHourTime + 180) then
        triggerCoordTwoHour = true
        battlefield:setLocalVar('lastCoordTwoHour', os.time())
    end

    if triggerCoordTwoHour then
        for i = 0, 4 do
            local carby = GetMobByID(mainCarbyID + i)
            if
                carby and
                carby:isAlive() and
                carby:isEngaged()
            then
                carby:useMobAbility(avatarTwoHours[carby:getName()])
            end
        end
    end
end

-- function to check if the elemental (non-carby) avatars should 2hr in phases 1, 3, and 5
local checkElementalAvatarTwoHour = function(mainCarbyID, battlefield, phase)
    -- if at least one avatar (in the given phase) has HPP < 10% or is dead
    -- then trigger 2hr on all avatars in the phase also trigger every 3 mins after that
    local triggerCoordTwoHour = false
    local lastCoorTwoHourTime = battlefield:getLocalVar('lastCoordTwoHour')

    -- if never triggered before then wait until 10% threshold
    if lastCoorTwoHourTime == 0 then
        for i = 5, 10 do
            local avatar = GetMobByID(mainCarbyID + i)
            if
                avatar and
                avatar:getLocalVar('phase') == phase and
                -- either dead
                ((avatar:isDead() and avatar:getLocalVar('wasDefeated') == 1) or
                -- or is alive with <10% HPP
                (avatar:isAlive() and avatar:getHPP() < 10))
            then
                triggerCoordTwoHour = true
                battlefield:setLocalVar('lastCoordTwoHour', os.time())
                break
            end
        end
    -- else check the 3 min timer
    elseif os.time() > (lastCoorTwoHourTime + 180) then
        triggerCoordTwoHour = true
        battlefield:setLocalVar('lastCoordTwoHour', os.time())
    end

    if triggerCoordTwoHour then
        for i = 5, 10 do
            local avatar = GetMobByID(mainCarbyID + i)
            if
                avatar and
                avatar:getLocalVar('phase') == phase and
                avatar:isAlive() and
                avatar:isEngaged()
            then
                avatar:useMobAbility(avatarTwoHours[avatar:getName()])
            end
        end
    end
end

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.FULL_MOON_FOUNTAIN,
    battlefieldId    = xi.battlefield.id.WAKING_THE_BEAST_FULLMOON,
    canLoseExp       = false,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = 'MS_Entrance',
    exitNpc          = 'Moon_Spiral',
    questArea = xi.questLog.OTHER_AREAS,
    quest     = xi.quest.id.otherAreas.WAKING_THE_BEAST,
})

-- unclear if this is correct or if all players need the quest items
function content:entryRequirement(player, npc, isRegistrant, trade)
    local hasQuestItems = player:hasKeyItem(xi.ki.EYE_OF_FLAMES) and player:hasKeyItem(xi.ki.EYE_OF_FROST) and
    player:hasKeyItem(xi.ki.EYE_OF_GALES) and player:hasKeyItem(xi.ki.EYE_OF_STORMS) and
    player:hasKeyItem(xi.ki.EYE_OF_TIDES) and player:hasKeyItem(xi.ki.EYE_OF_TREMORS) and
    player:hasKeyItem(xi.ki.RAINBOW_RESONATOR)

    local prevCompletedQuest = player:getQuestStatus(self.questArea, self.quest) == xi.questStatus.QUEST_COMPLETED

    -- registrant must actually be doing the quest
    if isRegistrant then
        return hasQuestItems
    -- others can help if they are either doing the quest or already completed the quest
    else
        return hasQuestItems or prevCompletedQuest
    end
end

function content:setupBattlefield(battlefield)
    -- create the random ordering that elemental (non-carby) avatars will be spawned (which avatars in which phases)
    local shuffledAvatarIndexes = utils.shuffle({ 1, 2, 3, 4, 5, 6 })
    -- convert the shuffled indexes into a single number
    local avatarOrder = tonumber(table.concat(shuffledAvatarIndexes, ''))
    battlefield:setLocalVar('avatarOrder', avatarOrder)

    -- reset the local variables on each elemental avatar need this because local vars
    -- only reset on spawn and without reset we could not differentiate between
    -- 1) avatar(s) killed by previous group but not yet fought by current group
    -- 2) avatar(s) killed by current group
    local mainCarbyID = mainCarbyIDbyArea[battlefield:getArea()]
    for i = 5, 10 do
        local avatar = GetMobByID(mainCarbyID + i)
        if avatar then
            avatar:setLocalVar('wasDefeated', 0)
            avatar:setLocalVar('phase', 0)
        end
    end

    -- the main carby is not killable until going through all phases (and thus at phase 6)
    local mainCarby = GetMobByID(mainCarbyID)
    if mainCarby then
        mainCarby:setUnkillable(true)
    end
end

local setBattlefieldLocalVarsForPhase = function(battlefield, phase, numToSpawn, typeToSpawn)
    battlefield:setLocalVar('phase', phase)
    -- set up an avatar spawn in 5 seconds
    battlefield:setLocalVar('spawnTriggerTime', os.time() + 5)
    battlefield:setLocalVar('numToSpawn', numToSpawn)
    battlefield:setLocalVar('typeToSpawn', typeToSpawn)
    battlefield:setLocalVar('lastCoordTwoHour', 0)
end

-- function that handles main logic of the fight including moving between phases
function content:onBattlefieldTick(battlefield, tick)
    -- call the general Battlefield tick function first then do custom logic
    Battlefield.onBattlefieldTick(self, battlefield, tick)

    -- get the ID of the main carbuncle that is spawned at start (for the specific battlefield area)
    -- all other IDs are derived relative to this ID
    local mainCarbyID = mainCarbyIDbyArea[battlefield:getArea()]
    local mainCarby = GetMobByID(mainCarbyID)

    -- Fight has 7 total phases (stored in the battlefield local var phase) and indexed from 0
    -- 0: main carby 100%-75%
    -- 1: one elemental (non-carby) avatar
    -- 2: main carby 75%-50%
    -- 3: two elemental (non-carby) avatars
    -- 4: main carby 50%-25%
    -- 5: three elemental (non-carby) avatars
    -- 6: five carbys 25%-0%

    -- get the current phase
    local phase = battlefield:getLocalVar('phase')

    -- check if there is a pending spawning of either elemental avatars or carby
    -- the trigger time is set in the phase transition code
    if battlefield:getLocalVar('spawnTriggerTime') > 0 then
        -- if there is a pending spawning then check if time to spawn or need to wait
        if os.time() > battlefield:getLocalVar('spawnTriggerTime') then
            local numToSpawn = battlefield:getLocalVar('numToSpawn')

            if
                mainCarby and
                battlefield:getLocalVar('typeToSpawn') == spawnType.ELEMENTAL_AVATAR
            then
                local spawnPosition = mainCarby:getPos()
                spawnElementalAvatars(spawnPosition, battlefield, numToSpawn, phase, self)
            elseif battlefield:getLocalVar('typeToSpawn') == spawnType.CARBUNCLE then
                -- carby is only spawned either as the single main carby or as the final five carbys
                if numToSpawn == 5 then
                    for i = 0, 4 do
                        spawnCarby(mainCarbyID + i, battlefield, self)
                    end

                    -- the main carby is now killable since it is phase 6
                    if mainCarby then
                        mainCarby:setUnkillable(false)
                    end
                else
                    spawnCarby(mainCarbyID, battlefield, self)
                end
            end

            -- reset the spawn variables
            battlefield:setLocalVar('spawnTriggerTime', 0)
            battlefield:setLocalVar('numToSpawn', 0)
            battlefield:setLocalVar('typeToSpawn', 0)
        end

        -- no need to do any other phase checks while waiting for a spawn trigger
        return
    end

    -- get the total number of elemental (non-carby) avatars defeated (used in phase checks)
    local avatarsDefeated = battlefield:getLocalVar('avatarsDefeated')

    -- check if conditions are met to transition to the next phase of the fight
    -- if so then change phase and return so next tick can start waiting to spawn trigger
    if
        phase == 0 and
        mainCarby and
        mainCarby:isAlive() and
        mainCarby:getHPP() < 75
    then
        phase = phase + 1
        setBattlefieldLocalVarsForPhase(battlefield, phase, 1, spawnType.ELEMENTAL_AVATAR)
        despawnCarby(mainCarby, battlefield, self)
        return
    elseif
        phase == 1 and
        avatarsDefeated == 1
    then
        phase = phase + 1
        setBattlefieldLocalVarsForPhase(battlefield, phase, 1, spawnType.CARBUNCLE)
        return
    elseif
        phase == 2 and
        mainCarby and
        mainCarby:isAlive() and
        mainCarby:getHPP() < 50
    then
        phase = phase + 1
        setBattlefieldLocalVarsForPhase(battlefield, phase, 2, spawnType.ELEMENTAL_AVATAR)
        despawnCarby(mainCarby, battlefield, self)
        return
    elseif
        phase == 3 and
        avatarsDefeated == 3
    then
        phase = phase + 1
        setBattlefieldLocalVarsForPhase(battlefield, phase, 1, spawnType.CARBUNCLE)
        return
    elseif
        phase == 4 and
        mainCarby and
        mainCarby:isAlive() and
        mainCarby:getHPP() < 25
    then
        phase = phase + 1
        setBattlefieldLocalVarsForPhase(battlefield, phase, 3, spawnType.ELEMENTAL_AVATAR)
        despawnCarby(mainCarby, battlefield, self)
        return
    elseif
        phase == 5 and
        avatarsDefeated == 6
    then
        phase = phase + 1
        setBattlefieldLocalVarsForPhase(battlefield, phase, 5, spawnType.CARBUNCLE)
        return
    end

    -- next do additional checks not related to phase transitions
    -- if the phase has elemental (non-carby) avatars (phases 1, 3, 5)
    if phase % 2 == 1 then
        -- check if avatars should use 2hrs
        checkElementalAvatarTwoHour(mainCarbyID, battlefield, phase)
    -- if final phase with five carbys
    elseif phase == 6 then
        -- perform check to see if carbys should use 2hrs
        checkCarbyTwoHour(mainCarbyID, battlefield)
        -- perform check to see if all carbys are dead (and thus should win)
        checkAllCarbyDead(mainCarbyID, battlefield)
    end
end

-- store the enmity table of the last mob that dies
-- need this to be able to send respawned carby(s) at the correct/valid target
-- Note: as content is global (for all bf areas) we index the table by area
content.lastEnmityList = {}

content.groups =
{
    {
        mobIds =
        {
            {
                fullMoonFountainID.mob.CARBUNCLE_PRIME,
            },
            {
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 11,
            },
            {
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 22,
            },
        },

        superlinkGroup = 1,
    },

    {
        -- mobs not spawned at start
        mobIds =
        {
            {
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 1,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 2,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 3,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 4,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 5,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 6,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 7,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 8,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 9,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 10,
            },
            {
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 12,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 13,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 14,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 15,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 16,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 17,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 18,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 19,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 20,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 21,
            },
            {
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 23,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 24,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 25,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 26,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 27,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 28,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 29,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 30,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 31,
                fullMoonFountainID.mob.CARBUNCLE_PRIME + 32,
            },
        },
        spawned = false,
        death = function(battlefield, mob)
            -- store the enmity table of the last mob that dies
            -- need to index by area as content is global (shared by areas)
            content.lastEnmityList[battlefield:getArea()] = mob:getEnmityList()
        end,

        superlinkGroup = 1,
    },
}

return content:register()
