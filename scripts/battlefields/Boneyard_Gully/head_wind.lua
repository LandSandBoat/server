-----------------------------------
-- Head Wind
-- Boneyard Gully mission battlefield
-----------------------------------
local ID = zones[xi.zone.BONEYARD_GULLY]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.BONEYARD_GULLY,
    battlefieldId         = xi.battlefield.id.HEAD_WIND,
    canLoseExp            = false,
    isMission             = true,
    allowTrusts           = true,
    maxPlayers            = 6,
    levelCap              = 50,
    timeLimit             = utils.minutes(30),
    index                 = 0,
    entryNpc              = '_081',
    exitNpcs              = { '_082', '_084', '_086' },

    missionArea           = xi.mission.log_id.COP,
    mission               = xi.mission.id.cop.THREE_PATHS,
    missionStatus         = xi.mission.status.COP.ULMIA,
    missionStatusArea     = xi.mission.log_id.COP,
    requiredMissionStatus = 7,

    grantXP               = 1000,
    title                 = xi.title.DELTA_ENFORCER,
})

-- Key for 3-mob skillchain lookup (all shikarees alive)
local allAlive = 1

-- Message offset lookup by base mob ID
local msgOffsets =
{
    [ID.mob.SHIKAREE_X_HW] = ID.text.SHIKAREE_X_OFFSET,
    [ID.mob.SHIKAREE_Y_HW] = ID.text.SHIKAREE_Y_OFFSET,
    [ID.mob.SHIKAREE_Z_HW] = ID.text.SHIKAREE_Z_OFFSET,
}

-- Skillchain execution logic
-- Shikarees are referenced by the base mob ID (without battlefield area offset)
-- Always has a specific order depending on which Shikaree is leading and how many are alive
-- Table is keyed off the Shikaree initiating the skillchain, with sub-tables for which shikarees are alive to skillchain with
-- Array position determines execution order
local skillchainData =
{
    -- Shikaree X initiated
    [ID.mob.SHIKAREE_X_HW] =
    {
        -- All shikaree are alive: X Evisceration → Y Vorpal Scythe → Z Impulse Drive
        [allAlive] =
        {
            { mobId = ID.mob.SHIKAREE_X_HW, skill = xi.mobSkill.EVISCERATION  },
            { mobId = ID.mob.SHIKAREE_Y_HW, skill = xi.mobSkill.VORPAL_SCYTHE },
            { mobId = ID.mob.SHIKAREE_Z_HW, skill = xi.mobSkill.IMPULSE_DRIVE },
        },
        -- Shikaree X and Y are alive: X Evisceration → Y Vorpal Scythe
        [ID.mob.SHIKAREE_Y_HW] =
        {
            { mobId = ID.mob.SHIKAREE_X_HW, skill = xi.mobSkill.EVISCERATION  },
            { mobId = ID.mob.SHIKAREE_Y_HW, skill = xi.mobSkill.VORPAL_SCYTHE },
        },
        -- Shikaree X and Z are alive: X Dancing Edge → Z Penta Thrust
        [ID.mob.SHIKAREE_Z_HW] =
        {
            { mobId = ID.mob.SHIKAREE_X_HW, skill = xi.mobSkill.DANCING_EDGE },
            { mobId = ID.mob.SHIKAREE_Z_HW, skill = xi.mobSkill.PENTA_THRUST },
        },
    },

    -- Shikaree Y initiated
    [ID.mob.SHIKAREE_Y_HW] =
    {
        -- All shikaree are alive: Y Guillotine → X Shadowstitch → Z Wheeling Thrust
        [allAlive] =
        {
            { mobId = ID.mob.SHIKAREE_Y_HW, skill = xi.mobSkill.GUILLOTINE_1    },
            { mobId = ID.mob.SHIKAREE_X_HW, skill = xi.mobSkill.SHADOWSTITCH    },
            { mobId = ID.mob.SHIKAREE_Z_HW, skill = xi.mobSkill.WHEELING_THRUST },
        },
        -- Shikaree Y and X are alive: Y Spiral Hell → X Shadowstitch
        [ID.mob.SHIKAREE_X_HW] =
        {
            { mobId = ID.mob.SHIKAREE_Y_HW, skill = xi.mobSkill.SPIRAL_HELL  },
            { mobId = ID.mob.SHIKAREE_X_HW, skill = xi.mobSkill.SHADOWSTITCH },
        },
        -- Shikaree Y and Z are alive: Y Spiral Hell → Z Impulse Drive
        [ID.mob.SHIKAREE_Z_HW] =
        {
            { mobId = ID.mob.SHIKAREE_Y_HW, skill = xi.mobSkill.SPIRAL_HELL   },
            { mobId = ID.mob.SHIKAREE_Z_HW, skill = xi.mobSkill.IMPULSE_DRIVE },
        },
    },

    -- Shikaree Z initiated
    [ID.mob.SHIKAREE_Z_HW] =
    {
        -- All shikaree are alive: Z Skewer → Y Spiral Hell → X Evisceration
        [allAlive] =
        {
            { mobId = ID.mob.SHIKAREE_Z_HW, skill = xi.mobSkill.SKEWER       },
            { mobId = ID.mob.SHIKAREE_Y_HW, skill = xi.mobSkill.SPIRAL_HELL  },
            { mobId = ID.mob.SHIKAREE_X_HW, skill = xi.mobSkill.EVISCERATION },
        },
        -- Shikaree Z and X are alive: Z Wheeling Thrust → X Shark Bite
        [ID.mob.SHIKAREE_X_HW] =
        {
            { mobId = ID.mob.SHIKAREE_Z_HW, skill = xi.mobSkill.WHEELING_THRUST },
            { mobId = ID.mob.SHIKAREE_X_HW, skill = xi.mobSkill.SHARK_BITE      },
        },
        -- Shikaree Z and Y are alive: Z Skewer → Y Spiral Hell
        [ID.mob.SHIKAREE_Y_HW] =
        {
            { mobId = ID.mob.SHIKAREE_Z_HW, skill = xi.mobSkill.SKEWER      },
            { mobId = ID.mob.SHIKAREE_Y_HW, skill = xi.mobSkill.SPIRAL_HELL },
        },
    },
}

-- Skillchain states
local scStateList =
{
    IDLE      = 0,
    READY     = 1,
    STARTING  = 2,
    EXECUTING = 3,
    SOLO      = 4,
}

-- Initiate skillchain with dynamic participant list
local function readySkillChain(leaderShikaree, aliveShikarees)
    local leaderMob = GetMobByID(leaderShikaree)
    if not leaderMob then
        return
    end

    local battlefield = leaderMob:getBattlefield()
    if not battlefield then
        return
    end

    -- Get leader's current target to share with all participants
    local leaderTarget = leaderMob:getTarget()
    if not leaderTarget then
        return
    end

    -- Select appropriate skillchain data based on alive shikaree count
    local chainData    = nil
    local offset       = (battlefield:getArea() - 1) * 5
    local leaderBaseID = leaderShikaree - offset
    local leaderData   = skillchainData[leaderBaseID]

    if #aliveShikarees == 3 then
        -- Use 3-mob skillchain
        chainData = leaderData[allAlive]
    else
        -- Use 2-mob skillchain: index by the other alive mob's baseID
        for i = 1, 2 do
            if aliveShikarees[i] ~= leaderShikaree then
                local otherBaseID = aliveShikarees[i] - offset
                chainData = leaderData[otherBaseID]
                break
            end
        end
    end

    if not chainData then
        return
    end

    battlefield:setLocalVar('scState', scStateList.STARTING)

    -- Setup Shikarees with their skill sequence order and behavior
    -- chainData is an array where position determines execution order
    for i, data in ipairs(chainData) do
        local mobID       = data.mobId + offset
        local shikareeMob = GetMobByID(mobID)

        if shikareeMob then
            -- Leader of skillchains uses message offset + 2, followers use offset + 3
            local msgOffset = msgOffsets[data.mobId] + (i == 1 and 2 or 3)

            shikareeMob:setLocalVar('scSkill', data.skill)
            shikareeMob:setLocalVar('scMessage', msgOffset)
            shikareeMob:setMagicCastingEnabled(false)

            -- Force all Shikarees to target the leader's target
            if mobID ~= leaderShikaree then
                shikareeMob:updateEnmity(leaderTarget)
            end

            -- Set next mob in chain (next entry in array, or 0 if last)
            local nextData = chainData[i + 1]
            local nextID   = nextData and (nextData.mobId + offset) or 0
            shikareeMob:setLocalVar('scNextID', nextID)
        end
    end
end

local function resetSkillchain(battlefield, offsetID)
    battlefield:setLocalVar('scState', scStateList.IDLE)
    battlefield:setLocalVar('scLeader', 0)

    -- Re-enable magic casting and clean up for all alive Shikarees
    for i = 0, 2 do
        local currentID   = offsetID + i
        local shikareeMob = GetMobByID(currentID)

        if shikareeMob and shikareeMob:isAlive() then
            shikareeMob:setMagicCastingEnabled(true)
            shikareeMob:setLocalVar('scSkill', 0)
            shikareeMob:setLocalVar('scMessage', 0)
            shikareeMob:setLocalVar('scNextID', 0)
            shikareeMob:setLocalVar('scPendingTime', 0)
        end
    end
end

local function getAliveShikarees(offsetID, scLeaderID)
    local result =
    {
        shikarees       = {},
        count           = 0,
        lastAlive       = nil,
        allReady        = true,
        leaderShikaree  = nil,
    }

    for i = 0, 2 do
        local currentID   = offsetID + i
        local shikareeMob = GetMobByID(currentID)

        if shikareeMob and shikareeMob:isAlive() then
            result.count     = result.count + 1
            result.lastAlive = currentID
            table.insert(result.shikarees, currentID)

            if shikareeMob:getTP() < 1000 then
                result.allReady = false
            end

            if currentID == scLeaderID then
                result.leaderShikaree = currentID
            end
        end
    end

    return result
end

-- Check if a Shikaree should become the skillchain leader (called in IDLE state)
local function checkForNewLeader(battlefield, offsetID)
    for i = 0, 2 do
        local currentID   = offsetID + i
        local baseID      = ID.mob.SHIKAREE_Z_HW + i
        local shikareeMob = GetMobByID(currentID)

        if shikareeMob and shikareeMob:isAlive() and shikareeMob:getTP() >= 1000 then
            local leaderMsgOffset = msgOffsets[baseID]

            if leaderMsgOffset then
                battlefield:setLocalVar('scState', scStateList.READY)
                battlefield:setLocalVar('scLeader', currentID)
                shikareeMob:messageText(shikareeMob, leaderMsgOffset + 1)

                return
            end
        end
    end
end

-- Kick off the beginning of the skillchain
local function startSkillChain(battlefield, offsetID, scLeaderID)
    local leaderMob = GetMobByID(scLeaderID)

    if
        not leaderMob or
        not leaderMob:isAlive()
    then
        resetSkillchain(battlefield, offsetID)

        return
    end

    if xi.combat.behavior.isEntityBusy(leaderMob) then
        return
    end

    if not leaderMob:getTarget() then
        return
    end

    local scSkill = leaderMob:getLocalVar('scSkill')

    if scSkill > 0 then
        leaderMob:useMobAbility(scSkill, leaderMob:getTarget())
    end
end

-- Find the next pending mob that's ready to execute their skill
local function findPendingMob(aliveShikarees)
    for _, shikareeID in ipairs(aliveShikarees) do
        local shikareeMob = GetMobByID(shikareeID)

        if
            shikareeMob and
            shikareeMob:isAlive() and
            not xi.combat.behavior.isEntityBusy(shikareeMob) and
            shikareeMob:getLocalVar('scSkill') > 0 and
            shikareeMob:getLocalVar('scPendingTime') > 0 and
            GetSystemTime() >= shikareeMob:getLocalVar('scPendingTime')
        then
            return shikareeMob, shikareeMob:getLocalVar('scSkill')
        end
    end

    return nil, 0
end

-- Check if all participants have completed their skills
local function isSkillchainComplete(aliveShikarees)
    for _, shikareeID in ipairs(aliveShikarees) do
        local shikareeMob = GetMobByID(shikareeID)

        if shikareeMob and shikareeMob:isAlive() then
            if shikareeMob:getLocalVar('scSkill') > 0 then
                return false
            end
        end
    end

    return true
end

-- Handle EXECUTING state: monitor and execute pending skills
local function executeSkillChain(battlefield, offsetID, scLeaderID, aliveShikarees)
    local scLeaderMob = GetMobByID(scLeaderID)
    local scTarget    = scLeaderMob and scLeaderMob:getTarget() or nil

    -- Find and execute pending skill
    local pendingMob, pendingSkill = findPendingMob(aliveShikarees)

    if pendingMob then
        local target = scTarget or pendingMob:getTarget()

        if target then
            if scTarget then
                pendingMob:updateEnmity(scTarget)
            end

            pendingMob:useMobAbility(pendingSkill, target)
        end
    end

    -- Reset when all participants have completed their skills
    if isSkillchainComplete(aliveShikarees) then
        resetSkillchain(battlefield, offsetID)
    end
end

function content:onBattlefieldTick(battlefield, tick)
    Battlefield.onBattlefieldTick(self, battlefield, tick)

    local offset     = (battlefield:getArea() - 1) * 5
    local offsetID   = ID.mob.SHIKAREE_Z_HW + offset
    local scState    = battlefield:getLocalVar('scState')
    local scLeaderID = battlefield:getLocalVar('scLeader')

    -- Reset if leader died before initiating skillchain
    if scState == scStateList.READY and scLeaderID ~= 0 then
        local leaderMob = GetMobByID(scLeaderID)

        if not leaderMob or not leaderMob:isAlive() then
            resetSkillchain(battlefield, offsetID)
            scState = scStateList.IDLE
        end
    end

    -- Get alive shikarees and their status
    local aliveData = getAliveShikarees(offsetID, scLeaderID)

    -- Solo mode: only one Shikaree left
    if aliveData.count == 1 and aliveData.lastAlive then
        local lastMob = GetMobByID(aliveData.lastAlive)

        if lastMob and scState ~= scStateList.SOLO then
            lastMob:setMobAbilityEnabled(true)
            resetSkillchain(battlefield, offsetID)
            battlefield:setLocalVar('scState', scStateList.SOLO)
        end

        return
    end

    switch (scState) : caseof
    {
        [scStateList.IDLE] = function()
            checkForNewLeader(battlefield, offsetID)
        end,

        [scStateList.READY] = function()
            if aliveData.allReady and aliveData.leaderShikaree then
                readySkillChain(aliveData.leaderShikaree, aliveData.shikarees)
            end
        end,

        [scStateList.STARTING] = function()
            startSkillChain(battlefield, offsetID, scLeaderID)
        end,

        [scStateList.EXECUTING] = function()
            executeSkillChain(battlefield, offsetID, scLeaderID, aliveData.shikarees)
        end,
    }
end

content.groups =
{
    {
        mobIds =
        {
            {
                ID.mob.SHIKAREE_Z_HW,
                ID.mob.SHIKAREE_Y_HW,
                ID.mob.SHIKAREE_X_HW,
            },

            {
                ID.mob.SHIKAREE_Z_HW + 5,
                ID.mob.SHIKAREE_Y_HW + 5,
                ID.mob.SHIKAREE_X_HW + 5,
            },

            {
                ID.mob.SHIKAREE_Z_HW + 10,
                ID.mob.SHIKAREE_Y_HW + 10,
                ID.mob.SHIKAREE_X_HW + 10,
            },
        },

        superlinkGroup = 1,
        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        mobIds =
        {
            { ID.mob.SHIKAREE_Z_HW +  4 },
            { ID.mob.SHIKAREE_Z_HW +  9 },
            { ID.mob.SHIKAREE_Z_HW + 14 },
        },

        superlinkGroup = 1,
    },

    -- NOTE: Rabbit is spawned on start, but wyvern is a result of an on engage action.
    {
        mobIds =
        {
            { ID.mob.SHIKAREE_Z_HW +  3 },
            { ID.mob.SHIKAREE_Z_HW +  8 },
            { ID.mob.SHIKAREE_Z_HW + 13 },
        },

        superlinkGroup = 1,
        spawned        = false,
    },
}

return content:register()
