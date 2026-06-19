-----------------------------------
-- Salvage : Silver Sea Remnants
-----------------------------------
local ID = zones[xi.zone.SILVER_SEA_REMNANTS]
-----------------------------------

local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return xi.salvage.registryRequirements(player)
end

instanceObject.entryRequirements = function(player)
    return xi.salvage.entryRequirements(player)
end

-- Called on the instance once it is created and ready
instanceObject.onInstanceCreated = function(instance)
    instance:setStage(1)
    instance:setProgress(1)
end

-- Once the instance is ready inform the requester that it's ready
instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instanceObject.afterInstanceRegister = function(player)
    xi.salvage.afterInstanceRegister(player, xi.item.CAGE_OF_S_REMNANTS_FIREFLIES)
end

-- Instance 'tick'
instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

-- On fail
instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    local mobs  = instance:getMobs()

    for _, entity in pairs(mobs) do
        DespawnMob(entity:getID(), instance)
    end

    for _, players in ipairs(chars) do
        players:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        players:startCutscene(1)
    end
end

instanceObject.onTriggerAreaEnter = function(player, triggerArea, instance)
    local triggerAreaID = triggerArea:getTriggerAreaID()

    if triggerAreaID >= 2 and triggerAreaID <= 9 then
        player:startEvent(198 + triggerAreaID)
    end
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
    local stage = instance:getStage()

    if stage == 1 and progress == 9 then
        SpawnMob(ID.mob[1][2].hammerblow, instance)
    end
end

-- On win
instanceObject.onInstanceComplete = function(instance)
end

-- Standard event hooks, these will take priority over everything apart from m_event.Script
-- Omitting this will fallthrough to the same calls in the Zone.lua
instanceObject.onEventUpdate = function(player, csid, option, npc)
end

instanceObject.onEventFinish = function(player, csid, option, npc)
    local instance = player:getInstance()
    local chars    = instance:getChars()
    local csidSsr  = xi.salvage.csid.SSR

    if csid == 1 then
        for _, players in ipairs(chars) do
            players:setPos(580, 0, 500, 192, xi.zone.ALZADAAL_UNDERSEA_RUINS)
        end
    end

    if option ~= 1 then
        return
    end

    if csid == csidSsr.FLOOR_1_TO_2_START then
        local pos = player:getPos()

        -- xi.salvage.resetTempBoxes(player, instance)

        for _, v in ipairs(chars) do
            if v:getID() ~= player:getID() then
                if v:isInEvent() then
                    v:release()
                end

                v:queue(300, function(p)
                    p:startEvent(3)
                end)

                v:queue(5000, function(p)
                    p:setPos(pos.x, pos.y, pos.z, pos.rot)
                end)
            end

            v:setHP(v:getMaxHP())
            v:setMP(v:getMaxMP())
            local pet = v:getPet()
            if pet then
                pet:setHP(pet:getMaxHP())
                pet:setMP(pet:getMaxMP())
            end
        end

        instance:setStage(2)
        instance:setProgress(0)

        for id = ID.mob[1][1].mobs_start, ID.mob[1][3].mobs_end do
            DespawnMob(id, instance)
        end
    end
end

return instanceObject
