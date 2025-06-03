-----------------------------------
-- Salvage : Bhaflau Remnants
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
-----------------------------------

local mobTable =
{
    [2] =
    {
        [0] =
        {
            STAGE_START = -- Center 4 Flans
            {
                ID.mob.EMPATHIC_FLAN,
            },
        },
    },
    [3] =
    {
        [1] =
        {
            STAGE_START = -- North West
            {
                ID.mob.TROLL_GEMOLOGIST[4],
                ID.mob.TROLL_SMELTER[8],
                ID.mob.TROLL_CAMEIST[8],
                ID.mob.TROLL_IRONWORKER[9],
                utils.slice(ID.mob.TROLL_ENGRAVER, 7, 9),
            },
        },
        [2] =
        {
            STAGE_START = -- South West
            {
                utils.slice(ID.mob.BLACK_PUDDING, 8, 14),
            },
        },
        [3] =
        {
            STAGE_START = -- North East
            {
                ID.mob.TROLL_CAMEIST[7],
                ID.mob.TROLL_GEMOLOGIST[3],
                ID.mob.TROLL_SMELTER[7],
                ID.mob.TROLL_LAPIDARIST[3],
                utils.slice(ID.mob.TROLL_STONEWORKER, 7, 9),
            },
        },
        [4] =
        {
            STAGE_START = -- South East
            {
                utils.slice(ID.mob.BLACK_PUDDING, 1, 7),
            },
        },
    },
    [4] =
    {
        [1] = --west
        {
            STAGE_START =
            {
                utils.slice(ID.mob.ARCHAIC_GEAR, 27, 36),
                ID.mob.ARCHAIC_CHARIOT[2],
                utils.slice(ID.mob.ARCHAIC_GEARS, 8, 12),
            },
        },
        [2] = --east
        {
            STAGE_START =
            {
                utils.slice(ID.mob.ARCHAIC_GEAR, 17, 26),
                ID.mob.ARCHAIC_CHARIOT[1],
                utils.slice(ID.mob.ARCHAIC_GEARS, 3, 7),
            },
        },
    },
    [5] =
    {
        [1] =
        {
            STAGE_START =
            {
                ID.mob.LONG_BOWED_CHARIOT,
            },
        },
    }
}

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
    xi.salvage.unsealDoors(instance, ID.npc.DOOR_1_0)
end

-- Once the instance is ready inform the requester that it's ready
instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

-- When the player zones into the instance
instanceObject.afterInstanceRegister = function(player)
    for i = xi.slot.MAIN, xi.slot.BACK do
        player:unequipItem(i)
    end

    player:addStatusEffectEx(xi.effect.ENCUMBRANCE_I, xi.effect.ENCUMBRANCE_I, 0xFFFF, 0, 6000)
    player:addStatusEffectEx(xi.effect.OBLIVISCENCE, xi.effect.OBLIVISCENCE, 1, 0, 6000)
    player:addStatusEffectEx(xi.effect.OMERTA, xi.effect.OMERTA, 0x3F, 0, 6000)
    player:addStatusEffectEx(xi.effect.IMPAIRMENT, xi.effect.IMPAIRMENT, 3, 0, 6000)
    player:addStatusEffectEx(xi.effect.DEBILITATION, xi.effect.DEBILITATION, 0x1FF, 0, 6000)
    player:addTempItem(xi.item.CAGE_OF_B_REMNANTS_FIREFLIES)
    player:delKeyItem(xi.ki.REMNANTS_PERMIT)
end

-- Instance 'tick'
instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

-- On fail
instanceObject.onInstanceFailure = function(instance)
    xi.salvage.onFailure(instance)
end

instanceObject.onTriggerAreaEnter = function(player, triggerArea)
    local instance = player:getInstance()
    local areaID   = triggerArea:getTriggerAreaID()

    if instance then
        if areaID <= 8 and instance:getLocalVar('stageComplete') == instance:getStage() then
            player:startOptionalCutscene(199 + areaID, { cs_option = 1 })
        elseif areaID >= 9 then
            if instance:getLocalVar('exitPoint') == areaID then
                if instance:completed() then
                    player:startOptionalCutscene(208, { cs_option = 1 })
                else
                    player:messageSpecial(ID.text.NOTHING_HAPPENS)
                end
            end
        end
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

    if instance then
        if csid == 5 then
            local stage = instance:getStage()
            local section = instance:getLocalVar('dormantArea')
            local pos

            if instance:getLocalVar('destination') == 1 then
                pos = ID.pos[stage][section].enter
            else
                pos = ID.pos[stage][section].exit
            end

            player:setPos(unpack(pos))
        end

        if option == 1 and instance:getLocalVar('stageComplete') == instance:getStage() then
            if instance:getLocalVar('transportUser') ~= 0 then
                player:release()
                return
            end

            if csid ~= 4 then
                xi.salvage.onTransportUpdate(player, instance)
            end

            if csid == 200 then
                instance:setStage(2)
                instance:setProgress(0)
                xi.salvage.unsealDoors(instance, ID.npc.DOOR_2_EAST_ENTRANCE)
                xi.salvage.unsealDoors(instance, ID.npc.DOOR_2_WEST_ENTRANCE)
            elseif csid >= 201 and csid <= 204 then
                instance:setStage(3)
                instance:setProgress(csid - 200)
                local doors =
                {
                    ID.npc.DOOR_3_SW_ENTRANCE,
                    ID.npc.DOOR_3_NW_ENTRANCE,
                    ID.npc.DOOR_3_NE_ENTRANCE,
                    ID.npc.DOOR_3_SE_ENTRANCE
                }
                xi.salvage.unsealDoors(instance, doors)
            elseif csid >= 205 and csid <= 206 then
                instance:setStage(4)
                instance:setProgress(csid - 204)
                xi.salvage.unsealDoors(instance, { ID.npc.DOOR_4_EAST_EXIT, ID.npc.DOOR_4_WEST_EXIT })
            elseif csid == 207 then
                instance:setStage(5)
                instance:setProgress(1)
                xi.salvage.unsealDoors(instance, ID.npc.DOOR_5_1)
                instance:setLocalVar('exitPoint', math.random(9, 10))
            end
        end
    end
end

instanceObject.onEventFinish = function(player, csid, option, npc)
    local instance = player:getInstance()

    if instance then
        if csid == 1 then
            player:setPos(0, 0, 0, 0, xi.zone.ALZADAAL_UNDERSEA_RUINS)
        elseif csid == 101 then
            player:messageSpecial(ID.text.TIME_TO_COMPLETE, 100)
            player:messageSpecial(ID.text.SALVAGE_START, 1)
        elseif csid == 208 and option == 1 then
            local chars = instance:getChars()
            for _, entity in pairs(chars) do
                entity:startCutscene(1)
            end
        end

        if option == 1 and instance:getLocalVar('transportUser') == player:getID() then
            if csid >= 200 and csid <= 207 then
                xi.salvage.teleportGroup(player)
                local group = mobTable[instance:getStage()][instance:getProgress()].STAGE_START

                if group then
                    xi.salvage.spawnGroup(instance, group)
                end
            end
        end
    end
end

return instanceObject
