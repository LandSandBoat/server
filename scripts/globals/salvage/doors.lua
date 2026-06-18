-----------------------------------
-- Salvage: Door sealing logic.
-----------------------------------
xi = xi or {}
xi.salvage = xi.salvage or {}

xi.salvage.onDoorOpen = function(npc, stage, progress)
    local instance = npc:getInstance()
    local result   = false

    if
        npc:getAnimation() == xi.animation.CLOSE_DOOR and
        npc:getLocalVar('unSealed') == 1
    then
        npc:setLocalVar('unSealed', 0)

        if stage ~= nil then
            instance:setStage(stage)
        end

        if progress ~= nil then
            instance:setProgress(progress)
        end

        npc:setAnimation(xi.animation.OPEN_DOOR)
        npc:setUntargetable(true)
        result = true
    end

    return result
end

xi.salvage.sealDoors = function(instance, indexID)
    if type(indexID) == 'table' then
        for _, id in pairs(indexID) do
            local door = GetNPCByID(id, instance)

            if door then
                door:setLocalVar('unSealed', 0)
            end
        end
    else
        local door = GetNPCByID(indexID, instance)

        if door then
            door:setLocalVar('unSealed', 0)
        end
    end
end

xi.salvage.unsealDoors = function(instance, indexID)
    if type(indexID) == 'table' then
        for _, id in pairs(indexID) do
            local door = GetNPCByID(id, instance)

            if door then
                door:setLocalVar('unSealed', 1)
            end
        end
    else
        local door = GetNPCByID(indexID, instance)

        if door then
            door:setLocalVar('unSealed', 1)
        end
    end
end

xi.salvage.openBossDoor = function(npc)
    if npc:getAnimation() == xi.anim.CLOSE_DOOR then
        local instance = npc:getInstance()

        npc:openDoor(15)
        npc:queue(3000, function(npcArg)
            GetNPCByID(npcArg:getID() - 1, instance):openDoor(10)
        end)
    end
end
