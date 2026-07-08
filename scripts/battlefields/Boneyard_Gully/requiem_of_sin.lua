-----------------------------------
-- Requiem of Sin
-- Boneyard Gully quest battlefield
-- !addkeyitem 721
-----------------------------------
local ID = zones[xi.zone.BONEYARD_GULLY]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.BONEYARD_GULLY,
    battlefieldId    = xi.battlefield.id.REQUIEM_OF_SIN,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 6,
    entryNpc         = '_081',
    exitNpcs         = { '_082', '_084', '_086' },
    questArea        = xi.questLog.OTHER_AREAS,
    quest            = xi.quest.id.otherAreas.REQUIEM_OF_SIN,

    requiredKeyItems =
    {
        {
            xi.keyItem.LETTER_FROM_SHIKAREE_Y,
            xi.keyItem.LETTER_FROM_THE_MITHRAN_TRACKERS,
        },

        message = ID.text.BURSTS_INTO_FLAMES
    },

    armouryCrates    =
    {
        ID.mob.SHIKAREE_Z_ROS + 5,
        ID.mob.SHIKAREE_Z_ROS + 11,
        ID.mob.SHIKAREE_Z_ROS + 17,
    },
})

-- Override: Quest status does not matter for entry, only key items.
function content:checkRequirements(player, npc, isRegistrant, trade)
    if not self:isValidEntry(player, npc) then
        return false
    end

    return player:hasKeyItem(xi.keyItem.LETTER_FROM_SHIKAREE_Y) or
        player:hasKeyItem(xi.keyItem.LETTER_FROM_THE_MITHRAN_TRACKERS)
end

-- Key for 3-mob skillchain lookup (all shikarees alive)
local allAlive = 1

-- Message offset lookup by base mob ID
local msgOffsets =
{
    [ID.mob.SHIKAREE_X_ROS_TWT] = ID.text.SHIKAREE_X_OFFSET,
    [ID.mob.SHIKAREE_Y_ROS_TWT] = ID.text.SHIKAREE_Y_OFFSET,
    [ID.mob.SHIKAREE_Z_ROS    ] = ID.text.SHIKAREE_Z_OFFSET,
}

-- Skillchain execution logic
-- Shikarees are referenced by the base mob ID (without battlefield area offset)
-- Always has a specific order depending on which Shikaree is leading and how many are alive
-- Table is keyed off the Shikaree initiating the skillchain, with sub-tables for which shikarees are alive to skillchain with
-- Array position determines execution order
local skillchainData =
{
    -- Shikaree X initiated
    [ID.mob.SHIKAREE_X_ROS_TWT] =
    {
        -- All shikaree are alive: X Evisceration → Y Vorpal Scythe → Z Impulse Drive
        [allAlive] =
        {
            { mobId = ID.mob.SHIKAREE_X_ROS_TWT, skill = xi.mobSkill.EVISCERATION  },
            { mobId = ID.mob.SHIKAREE_Y_ROS_TWT, skill = xi.mobSkill.VORPAL_SCYTHE },
            { mobId = ID.mob.SHIKAREE_Z_ROS, skill = xi.mobSkill.IMPULSE_DRIVE },
        },
        -- Shikaree X and Y are alive: X Evisceration → Y Vorpal Scythe
        [ID.mob.SHIKAREE_Y_ROS_TWT] =
        {
            { mobId = ID.mob.SHIKAREE_X_ROS_TWT, skill = xi.mobSkill.EVISCERATION  },
            { mobId = ID.mob.SHIKAREE_Y_ROS_TWT, skill = xi.mobSkill.VORPAL_SCYTHE },
        },
        -- Shikaree X and Z are alive: X Dancing Edge → Z Penta Thrust
        [ID.mob.SHIKAREE_Z_ROS] =
        {
            { mobId = ID.mob.SHIKAREE_X_ROS_TWT, skill = xi.mobSkill.DANCING_EDGE },
            { mobId = ID.mob.SHIKAREE_Z_ROS, skill = xi.mobSkill.PENTA_THRUST },
        },
    },

    -- Shikaree Y initiated
    [ID.mob.SHIKAREE_Y_ROS_TWT] =
    {
        -- All shikaree are alive: Y Guillotine → X Shadowstitch → Z Wheeling Thrust
        [allAlive] =
        {
            { mobId = ID.mob.SHIKAREE_Y_ROS_TWT, skill = xi.mobSkill.GUILLOTINE_1    },
            { mobId = ID.mob.SHIKAREE_X_ROS_TWT, skill = xi.mobSkill.SHADOWSTITCH    },
            { mobId = ID.mob.SHIKAREE_Z_ROS, skill = xi.mobSkill.WHEELING_THRUST },
        },
        -- Shikaree Y and X are alive: Y Spiral Hell → X Shadowstitch
        [ID.mob.SHIKAREE_X_ROS_TWT] =
        {
            { mobId = ID.mob.SHIKAREE_Y_ROS_TWT, skill = xi.mobSkill.SPIRAL_HELL  },
            { mobId = ID.mob.SHIKAREE_X_ROS_TWT, skill = xi.mobSkill.SHADOWSTITCH },
        },
        -- Shikaree Y and Z are alive: Y Spiral Hell → Z Impulse Drive
        [ID.mob.SHIKAREE_Z_ROS] =
        {
            { mobId = ID.mob.SHIKAREE_Y_ROS_TWT, skill = xi.mobSkill.SPIRAL_HELL   },
            { mobId = ID.mob.SHIKAREE_Z_ROS, skill = xi.mobSkill.IMPULSE_DRIVE },
        },
    },

    -- Shikaree Z initiated
    [ID.mob.SHIKAREE_Z_ROS] =
    {
        -- All shikaree are alive: Z Skewer → Y Spiral Hell → X Evisceration
        [allAlive] =
        {
            { mobId = ID.mob.SHIKAREE_Z_ROS, skill = xi.mobSkill.SKEWER       },
            { mobId = ID.mob.SHIKAREE_Y_ROS_TWT, skill = xi.mobSkill.SPIRAL_HELL  },
            { mobId = ID.mob.SHIKAREE_X_ROS_TWT, skill = xi.mobSkill.EVISCERATION },
        },
        -- Shikaree Z and X are alive: Z Wheeling Thrust → X Shark Bite
        [ID.mob.SHIKAREE_X_ROS_TWT] =
        {
            { mobId = ID.mob.SHIKAREE_Z_ROS, skill = xi.mobSkill.WHEELING_THRUST },
            { mobId = ID.mob.SHIKAREE_X_ROS_TWT, skill = xi.mobSkill.SHARK_BITE      },
        },
        -- Shikaree Z and Y are alive: Z Skewer → Y Spiral Hell
        [ID.mob.SHIKAREE_Y_ROS_TWT] =
        {
            { mobId = ID.mob.SHIKAREE_Z_ROS, skill = xi.mobSkill.SKEWER      },
            { mobId = ID.mob.SHIKAREE_Y_ROS_TWT, skill = xi.mobSkill.SPIRAL_HELL },
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
    local offset       = (battlefield:getArea() - 1) * 6
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
        local baseID      = ID.mob.SHIKAREE_Z_ROS + i
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

    local offset     = (battlefield:getArea() - 1) * 6
    local offsetID   = ID.mob.SHIKAREE_Z_ROS + offset
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
                ID.mob.SHIKAREE_Z_ROS,
                ID.mob.SHIKAREE_Y_ROS_TWT,
                ID.mob.SHIKAREE_X_ROS_TWT,
            },

            {
                ID.mob.SHIKAREE_Z_ROS + 6,
                ID.mob.SHIKAREE_Y_ROS_TWT + 6,
                ID.mob.SHIKAREE_X_ROS_TWT + 6,
            },

            {
                ID.mob.SHIKAREE_Z_ROS + 12,
                ID.mob.SHIKAREE_Y_ROS_TWT + 12,
                ID.mob.SHIKAREE_X_ROS_TWT + 12,
            },
        },

        superlinkGroup = 1,
        allDeath       = utils.bind(content.handleAllMonstersDefeated, content),
    },

    {
        mobIds =
        {
            { ID.mob.SHIKAREE_Z_ROS +  4 },
            { ID.mob.SHIKAREE_Z_ROS + 10 },
            { ID.mob.SHIKAREE_Z_ROS + 16 },
        },

        superlinkGroup = 1,
    },

    {
        mobIds =
        {
            { ID.mob.SHIKAREE_Z_ROS +  3 },
            { ID.mob.SHIKAREE_Z_ROS +  9 },
            { ID.mob.SHIKAREE_Z_ROS + 15 },
        },

        superlinkGroup = 1,
        spawned        = false,
    },
}

content.loot =
{
    {
        quantity = 2,
        { itemId = xi.item.NONE,                     weight = 7500 },
        { itemId = xi.item.POT_OF_VIRIDIAN_URUSHI,   weight = 3500 },
        { itemId = xi.item.PIECE_OF_CASSIA_LUMBER,   weight = 2500 },
        { itemId = xi.item.DRAGON_BONE,              weight = 2500 },
        { itemId = xi.item.SQUARE_OF_ELTORO_LEATHER, weight = 2500 },
        { itemId = xi.item.SQUARE_OF_GALATEIA,       weight = 2500 },
        { itemId = xi.item.SQUARE_OF_KEJUSU_SATIN,   weight = 2500 },
    },
    {
        { itemId = xi.item.NONE,                     weight = 7500 },
        { itemId = xi.item.XS_KNIFE,                 weight =  500 },
        { itemId = xi.item.YS_SCYTHE,                weight =  500 },
        { itemId = xi.item.ZS_TRIDENT,               weight =  500 },
        { itemId = xi.item.LACQUER_TREE_LOG,         weight =   50 },
        { itemId = xi.item.PHOENIX_FEATHER,          weight =   50 },
        { itemId = xi.item.PHILOSOPHERS_STONE,       weight =   50 },
    },
    {
        { itemId = xi.item.NONE,                     weight =  750 },
        { itemId = xi.item.LACQUER_TREE_LOG,         weight =   50 },
        { itemId = xi.item.PHOENIX_FEATHER,          weight =   50 },
        { itemId = xi.item.PHILOSOPHERS_STONE,       weight =   50 },
    },
    {
        { itemId = xi.item.NONE,                     weight =  800 },
        { itemId = xi.item.PETRIFIED_LOG,            weight =   40 },
        { itemId = xi.item.DIVINE_LOG,               weight =   40 },
        { itemId = xi.item.SQUARE_OF_SHINING_CLOTH,  weight =   40 },
        { itemId = xi.item.SQUARE_OF_RAXA,           weight =   40 },
        { itemId = xi.item.SLAB_OF_GRANITE,          weight =   40 },
    },
}

return content:register()
