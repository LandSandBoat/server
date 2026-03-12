-----------------------------------
-- Tango with a Tracker
-- Boneyard Gully quest battlefield
-- !addkeyitem 719
-----------------------------------
local ID = zones[xi.zone.BONEYARD_GULLY]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.BONEYARD_GULLY,
    battlefieldId    = xi.battlefield.id.TANGO_WITH_A_TRACKER,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 5,
    entryNpc         = '_081',
    exitNpcs         = { '_082', '_084', '_086' },
    questArea        = xi.questLog.OTHER_AREAS,
    quest            = xi.quest.id.otherAreas.TANGO_WITH_A_TRACKER,

    requiredKeyItems =
    {
        xi.keyItem.LETTER_FROM_SHIKAREE_X,
        message = ID.text.BURSTS_INTO_FLAMES,
        onlyInitiator = true,
    },
})

-- Message offset lookup by base mob ID
local msgOffsets =
{
    [ID.mob.SHIKAREE_X_ROS_TWT] = ID.text.SHIKAREE_X_OFFSET,
    [ID.mob.SHIKAREE_Y_ROS_TWT] = ID.text.SHIKAREE_Y_OFFSET,
}

-- Skillchain execution logic for 2 shikarees (Y and X only)
local skillchainData =
{
    -- Shikaree X initiated: X Evisceration → Y Vorpal Scythe
    [ID.mob.SHIKAREE_X_ROS_TWT] =
    {
        { mobId = ID.mob.SHIKAREE_X_ROS_TWT, skill = xi.mobSkill.EVISCERATION  },
        { mobId = ID.mob.SHIKAREE_Y_ROS_TWT, skill = xi.mobSkill.VORPAL_SCYTHE },
    },

    -- Shikaree Y initiated: Y Spiral Hell → X Shadowstitch
    [ID.mob.SHIKAREE_Y_ROS_TWT] =
    {
        { mobId = ID.mob.SHIKAREE_Y_ROS_TWT, skill = xi.mobSkill.SPIRAL_HELL  },
        { mobId = ID.mob.SHIKAREE_X_ROS_TWT, skill = xi.mobSkill.SHADOWSTITCH },
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

-- Initiate skillchain with both shikarees
local function readySkillChain(leaderShikaree)
    local leaderMob = GetMobByID(leaderShikaree)
    if not leaderMob then
        return
    end

    local battlefield = leaderMob:getBattlefield()
    if not battlefield then
        return
    end

    -- Get leader's current target to share with both shikarees
    local leaderTarget = leaderMob:getTarget()
    if not leaderTarget then
        return
    end

    -- Select skillchain data based on leader
    local offset       = (battlefield:getArea() - 1) * 6
    local leaderBaseID = leaderShikaree - offset
    local chainData    = skillchainData[leaderBaseID]

    if not chainData then
        return
    end

    battlefield:setLocalVar('scState', scStateList.STARTING)

    -- Setup both Shikarees with their skill sequence order
    for i, data in ipairs(chainData) do
        local mobID       = data.mobId + offset
        local shikareeMob = GetMobByID(mobID)

        if shikareeMob then
            -- Leader uses message offset + 2, follower uses offset + 3
            local msgOffset = msgOffsets[data.mobId] + (i == 1 and 2 or 3)

            shikareeMob:setLocalVar('scSkill', data.skill)
            shikareeMob:setLocalVar('scMessage', msgOffset)
            shikareeMob:setMagicCastingEnabled(false)

            -- Force both to target the leader's target
            if mobID ~= leaderShikaree then
                shikareeMob:updateEnmity(leaderTarget)
            end

            -- Set next mob in chain (second entry or 0 if last)
            local nextData = chainData[i + 1]
            local nextID   = nextData and (nextData.mobId + offset) or 0
            shikareeMob:setLocalVar('scNextID', nextID)
        end
    end
end

local function resetSkillchain(battlefield, offsetID)
    battlefield:setLocalVar('scState', scStateList.IDLE)
    battlefield:setLocalVar('scLeader', 0)

    -- Re-enable magic casting and clean up for both Shikarees
    for i = 1, 2 do
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

    for i = 0, 1 do
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
    for i = 0, 1 do
        local currentID   = offsetID + i
        local baseID      = ID.mob.SHIKAREE_Y_ROS_TWT + i
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

-- Check if both shikarees have completed their skills
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

    -- Reset when both shikarees have completed their skills
    if isSkillchainComplete(aliveShikarees) then
        resetSkillchain(battlefield, offsetID)
    end
end

function content:onBattlefieldTick(battlefield, tick)
    Battlefield.onBattlefieldTick(self, battlefield, tick)

    local offset     = (battlefield:getArea() - 1) * 6
    local offsetID   = ID.mob.SHIKAREE_Y_ROS_TWT + offset
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
            if aliveData.count == 2 and aliveData.allReady and aliveData.leaderShikaree then
                readySkillChain(aliveData.leaderShikaree)
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

-- Registrant must have shikaree key item to initiate battlefield
-- Other players can enter if they have the key item or have completed Tango with a Tracker previously
function content:checkRequirements(player, npc, isRegistrant, trade)
    if isRegistrant then
        return Battlefield.checkRequirements(self, player, npc, isRegistrant, trade)
    end

    if not self:isValidEntry(player, npc) then
        return false
    end

    return player:hasKeyItem(xi.keyItem.LETTER_FROM_SHIKAREE_X) or
        player:hasCompletedQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.TANGO_WITH_A_TRACKER)
end

content.groups =
{
    {
        mobIds =
        {
            {
                ID.mob.SHIKAREE_Y_ROS_TWT,      -- Shikaree Y
                ID.mob.SHIKAREE_X_ROS_TWT,      -- Shikaree X
            },

            {
                ID.mob.SHIKAREE_Y_ROS_TWT + 6,  -- Shikaree Y
                ID.mob.SHIKAREE_X_ROS_TWT + 6,  -- Shikaree X
            },

            {
                ID.mob.SHIKAREE_Y_ROS_TWT + 12, -- Shikaree Y
                ID.mob.SHIKAREE_X_ROS_TWT + 12, -- Shikaree X
            },
        },

        superlinkGroup = 1,
        allDeath       = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        mobIds =
        {
            { ID.mob.SHIKAREE_X_ROS_TWT +  2 }, -- Shikaree X's Rabbit
            { ID.mob.SHIKAREE_X_ROS_TWT +  8 }, -- Shikaree X's Rabbit
            { ID.mob.SHIKAREE_X_ROS_TWT + 14 }, -- Shikaree X's Rabbit
        },

        superlinkGroup = 1,
    },
}

return content:register()
