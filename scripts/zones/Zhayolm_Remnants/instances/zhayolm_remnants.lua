-----------------------------------
-- Salvage : Zhayolm Remnants
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
-----------------------------------

local mobTable =
{
    [1] =
    {
        [1] =
        {
            STAGE_START =
            {
                ID.mob.PUK,
                ID.mob.ZIZ,
                ID.mob.VAGRANT_LINDWURM,
                ID.mob.BULL_BUGARD,
                utils.slice(ID.mob.MAMOOL_JA_ZENIST, 1, 4),
            },
        },
    },
    [2] =
    {
        [1] =
        {
            STAGE_START =
            {
                NORTH_EAST =
                {
                    utils.slice(ID.mob.DRACO_LIZARD, 9, 16),
                },
            },
        },
        [2] =
        {
            STAGE_START =
            {
                SOUTH_EAST =
                {
                    utils.slice(ID.mob.DRACO_LIZARD, 1, 8),
                },
            },
        },
        [3] =
        {
            STAGE_START =
            {
                SOUTH_WEST =
                {
                    utils.slice(ID.mob.WYVERN, 9, 16),
                },
            },
        },
        [4] =
        {
            STAGE_START =
            {
                NORTH_WEST =
                {
                    utils.slice(ID.mob.WYVERN, 1, 8),
                },
            },
        },
    },
    [3] =
    {
        [0] =
        {
            STAGE_START =
            {
                SOUTH_PATH =
                {
                    utils.slice(ID.mob.MAMOOL_JA_ZENIST, 6, 12),
                    utils.slice(ID.mob.MAMOOL_JA_SPEARMAN, 2, 8),
                    utils.slice(ID.mob.MAMOOL_JA_STRAPER, 1, 7),
                    utils.slice(ID.mob.MAMOOL_JA_BOUNDER, 2, 4),
                    ID.mob.ARCHAIC_RAMPART[1],
                },
                NORTH_PATH =
                {
                    utils.slice(ID.mob.MAMOOL_JA_SAVANT, 2, 11),
                    utils.slice(ID.mob.MAMOOL_JA_SOPHIST, 1, 10),
                    utils.slice(ID.mob.MAMOOL_JA_MIMICKER, 1, 12),
                    ID.mob.ARCHAIC_RAMPART[2],
                },
            },
        },
    },
    [4] =
    {
        [1] = -- south path
        {
            STAGE_START =
            {
                ID.mob.MAMOOL_JA_ZENIST[13],
                ID.mob.MAMOOL_JA_SPEARMAN[9],
                ID.mob.MAMOOL_JA_STRAPER[8],
                ID.mob.MAMOOL_JA_BOUNDER[5],
                ID.mob.FIRST_RAMPART[1],
                ID.mob.SECOND_RAMPART[1],
                ID.mob.THIRD_RAMPART[1],
                ID.mob.FOURTH_RAMPART[1],
                utils.slice(ID.mob.POROGGO_GENT, 5, 12),
            },
        },
        [2] = -- north path (random 2, 3)
        {
            STAGE_START =
            {
                utils.slice(ID.mob.MAMOOL_JA_SAVANT, 12, 13),
                utils.slice(ID.mob.MAMOOL_JA_SOPHIST, 10, 11),
                utils.slice(ID.mob.MAMOOL_JA_MIMICKER, 13, 14),
                ID.mob.FIRST_RAMPART[2],
                ID.mob.SECOND_RAMPART[2],
                ID.mob.THIRD_RAMPART[2],
                ID.mob.FOURTH_RAMPART[2],
                utils.slice(ID.mob.POROGGO_GENT, 13, 24),
            },
        },
        [3] =
        {
            STAGE_START =
            {
                utils.slice(ID.mob.MAMOOL_JA_SAVANT, 14, 15),
                utils.slice(ID.mob.MAMOOL_JA_SOPHIST, 12, 13),
                utils.slice(ID.mob.MAMOOL_JA_MIMICKER, 15, 16),
                ID.mob.FIRST_RAMPART[3],
                ID.mob.SECOND_RAMPART[3],
                ID.mob.THIRD_RAMPART[3],
                ID.mob.FOURTH_RAMPART[3],
                utils.slice(ID.mob.POROGGO_GENT, 25, 36),
            },
        },
    },
    [5] =
    {
        [1] =
        {
            STAGE_START = -- north
            {
                FIRST_ROOM_GEARS =
                {
                    utils.slice(ID.mob.ARCHAIC_GEARS, 1, 8),
                },
                GEARS_NO_PATH =
                {
                    utils.slice(ID.mob.ARCHAIC_GEARS, 9, 12),
                },
                SECOND_ROOM_GEARS =
                {
                    utils.slice(ID.mob.ARCHAIC_GEARS, 25, 32),
                },
                THIRD_ROOM_GEARS =
                {
                    utils.slice(ID.mob.ARCHAIC_GEARS, 13, 24),
                },
                utils.slice(ID.mob.ARCHAIC_RAMPART, 7, 10),
                ID.mob.ARCHAIC_CHARIOT[2],
            },
        },
        [2] =
        {
            STAGE_START = -- south
            {
                FIRST_ROOM_GEAR =
                {
                    utils.slice(ID.mob.ARCHAIC_GEAR, 1, 8),
                },
                SECOND_ROOM_GEAR =
                {
                    utils.slice(ID.mob.ARCHAIC_GEAR, 17, 20),
                },
                THIRD_ROOM_GEAR =
                {
                    utils.slice(ID.mob.ARCHAIC_GEAR, 9, 16),
                },
                utils.slice(ID.mob.ARCHAIC_RAMPART, 3, 6),
                ID.mob.ARCHAIC_CHARIOT[2],
            },
        },
    },
    [6] =
    {
        [1] =
        {
            STAGE_START =
            {
                ID.mob.ARCHAIC_CHARIOT[3],
                utils.slice(ID.mob.ARCHAIC_RAMPART, 11, 12),
            },
        },
    },
    [7] =
    {
        [1] =
        {
            STAGE_START =
            {
                ID.mob.BATTLECLAD_CHARIOT,
            },
        },
    },
}

local removedPathos = function(instance)
    local count = 0
    local chars = instance:getChars()

    for _, players in pairs(chars) do
        if
            not players:hasStatusEffect(xi.effect.ENCUMBRANCE_I) and
            not players:hasStatusEffect(xi.effect.OBLIVISCENCE) and
            not players:hasStatusEffect(xi.effect.OMERTA) and
            not players:hasStatusEffect(xi.effect.IMPAIRMENT) and
            not players:hasStatusEffect(xi.effect.DEBILITATION)
        then
            count = count + 1
        end
    end

    return count
end

local instanceObject = {}

-- Requirements for the first player registering the instance
instanceObject.registryRequirements = function(player)
    return player:getMainLvl() >= 65 and player:hasKeyItem(xi.ki.REMNANTS_PERMIT)
end

-- Requirements for further players entering an already-registered instance
instanceObject.entryRequirements = function(player)
    return player:getMainLvl() >= 65 and player:hasKeyItem(xi.ki.REMNANTS_PERMIT)
end

-- Called on the instance once it is created and ready
instanceObject.onInstanceCreated = function(instance)
    instance:setStage(1)
    instance:setProgress(1)
    instance:setLocalVar('dayElement', VanadielDayOfTheWeek() + 1) -- have to +1 due to firesday (0)
    instance:setLocalVar('timeEntered', GetSystemTime())
    xi.salvage.spawnGroup(instance, mobTable[1][1].STAGE_START)
    GetNPCByID(ID.npc.DOOR_1_0, instance):setLocalVar('unSealed', 1)
end

-- Once the instance is ready inform the requester that it's ready
instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

-- When the player zones into the instance
instanceObject.afterInstanceRegister = function(player)
    xi.salvage.instanceRegister(player, xi.item.CAGE_OF_Z_REMNANTS_FIREFLIES)
end

-- Instance 'tick'
instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)

    if instance:getStage() == 5 then
        if instance:getLocalVar('spawned5th') == 0 then
            local count    = removedPathos(instance)
            local progress = instance:getProgress()

            if progress == 1 and count >= 3 then
                instance:setLocalVar('spawned5th', 1)
                SpawnMob(ID.mob.POROGGO_MADAME[7], instance)
            elseif progress == 2 and count >= 1 then
                SpawnMob(ID.mob.POROGGO_MADAME[6], instance)
                instance:setLocalVar('spawned5th', 1)
            end
        end
    end
end

instanceObject.onInstanceFailure = function(instance)
    xi.salvage.onFailure(instance)
end

instanceObject.onTriggerAreaEnter = function(player, triggerArea)
    local instance = player:getInstance()
    local areaID   = triggerArea:getTriggerAreaID()

    if
        instance:getLocalVar('stageComplete') == instance:getStage() or
        instance:completed()
    then
        if areaID <= 11 then
            player:startOptionalCutscene(199 + areaID, { cs_option = 1 })
        elseif
            instance:getLocalVar('exitPoint') == areaID and
            player:getLocalVar('responded') == 0
        then
            player:startOptionalCutscene(211, { cs_option = 1 })
            player:setLocalVar('responded', 1)
        end
    -- Floor 4 return code
    elseif areaID == 9 and instance:getLocalVar('notComplete') == 1 then
        player:startOptionalCutscene(206, { cs_option = 1 })
    elseif player:getLocalVar('responded') == 0 then
        player:messageSpecial(ID.text.NOT_RESPONDING)
        player:setLocalVar('responded', 1)
    end
end

instanceObject.onTriggerAreaLeave = function(player, triggerArea)
    if player:getLocalVar('responded') == 1 then
        player:setLocalVar('responded', 0)
    end
end

-- When something in the instance calls: instance:setProgress(...)
instanceObject.onInstanceProgressUpdate = function(instance, progress)
end

-- On win
instanceObject.onInstanceComplete = function(instance)
end

-- Standard event hooks, these will take priority over everything apart from m_event.Script
-- Omitting this will fallthrough to the same calls in the Zone.lua
instanceObject.onEventUpdate = function(player, csid, option, npc)
    local instance = player:getInstance()

    if instance:getLocalVar('transportUser') ~= 0 then
        return
    end

    if option == 1 and instance:getLocalVar('stageComplete') == instance:getStage() then
        if csid ~= 3 or csid ~= 211 then
            xi.salvage.onTransportUpdate(player, instance)
        end

        if csid >= 200 and csid <= 203 then
            instance:setStage(2)
            instance:setProgress(csid - 199)
        elseif csid == 204 then
            instance:setStage(3)
            instance:setProgress(0)
            xi.salvage.unsealDoors(instance, { ID.npc.DOOR_3_1, ID.npc.DOOR_3_2 })
        elseif csid == 205 then -- south path
            instance:setStage(4)
            instance:setProgress(1)
            xi.salvage.unsealDoors(instance, ID.npc.DOOR_4_1)
        elseif csid == 206 then -- north path
            instance:setStage(4)
            instance:setProgress(math.random(2, 3))
            xi.salvage.unsealDoors(instance, ID.npc.DOOR_4_2)
        elseif csid == 207 then
            instance:setStage(5)
            instance:setProgress(2)
        elseif csid == 208 then
            instance:setStage(5)
            instance:setProgress(1)
        elseif csid == 209 then
            instance:setStage(6)
            instance:setProgress(1)
            if instance:getLocalVar('killedNMs') >= 4 then
                SpawnMob(ID.mob.POROGGO_MADAME[8], instance)
            end
        elseif csid == 210 then
            instance:setStage(7)
            instance:setProgress(1)
            xi.salvage.unsealDoors(instance, ID.npc.DOOR_7_1)
        end
    -- 4th Floor return mechanics
    elseif option == 1 and csid == 206 and instance:getLocalVar('notComplete') == 1 then
        xi.salvage.onTransportUpdate(player, instance)
        GetNPCByID(ID.npc.DOOR_4_2, instance):setAnimation(xi.animation.CLOSE_DOOR)
        GetNPCByID(ID.npc.DOOR_4_2, instance):setUntargetable(false)
        xi.salvage.unsealDoors(instance, ID.npc.DOOR_4_2)
        instance:setLocalVar('notComplete', 0)
        -- set progess to other
        if instance:getProgress() == 2 then
            instance:setProgress(3)
        else
            instance:setProgress(2)
        end
    end
end

instanceObject.onEventFinish = function(player, csid, option, npc)
    local instance = player:getInstance()
    local chars    = instance:getChars()

    if csid == 1 then
        for _, players in ipairs(chars) do
            players:setPos(-580, 0, -433, 64, xi.zone.ALZADAAL_UNDERSEA_RUINS)
        end
    elseif csid == 101 then
        player:messageSpecial(ID.text.TIME_TO_COMPLETE, 100)
        player:messageSpecial(ID.text.SALVAGE_START, 1)
    elseif csid == 211 and option == 1 then
        for _, players in pairs(chars) do
            players:startCutscene(1)
        end
    end

    if option == 1 and instance:getLocalVar('transportUser') == player:getID() then
        if csid >= 200 and csid <= 210 then
            xi.salvage.teleportGroup(player)
            xi.salvage.spawnGroup(instance, mobTable[instance:getStage()][instance:getProgress()].STAGE_START)
            -- 2nd floor
            if csid == 200 then
                GetNPCByID(ID.npc.SOCKET, instance):setStatus(xi.status.NORMAL)
            elseif csid == 203 then
                GetNPCByID(ID.npc.SLOT, instance):setStatus(xi.status.NORMAL)
            -- to 4th floor
            elseif csid == 205 or csid == 206 then
                local currentTime = GetSystemTime()
                -- 205 = South, 206 = North
                if csid == 205 then
                    local floorBoss = GetMobByID(ID.mob.POROGGO_MADAME[4], instance)
                    if
                        floorBoss and instance:getLocalVar('timeEntered') + (47 * 60) >= currentTime and
                        floorBoss:getLocalVar('spawned') == 0
                    then
                        SpawnMob(ID.mob.POROGGO_MADAME[4], instance)
                        floorBoss:setLocalVar('spawned', 1)
                    end
                elseif csid == 206 then
                    local floorBoss = GetMobByID(ID.mob.POROGGO_MADAME[5], instance)
                    if
                        floorBoss and instance:getLocalVar('timeEntered') + (30 * 60) >= currentTime and
                        floorBoss:getLocalVar('spawned') == 0
                    then
                        SpawnMob(ID.mob.POROGGO_MADAME[5], instance)
                        floorBoss:setLocalVar('spawned', 1)
                    end
                end
            -- to 5th floor
            elseif csid == 207 then
                xi.salvage.unsealDoors(instance, ID.npc.DOOR_5_2)
            elseif csid == 208 then
                xi.salvage.unsealDoors(instance, ID.npc.DOOR_5_1)
            elseif csid == 210 then
                instance:setLocalVar('exitPoint', math.random(12, 13))
            end
        end
    end
end

return instanceObject
