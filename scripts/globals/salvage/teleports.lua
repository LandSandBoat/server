-----------------------------------
-- Salvage: Teleport logic.
-----------------------------------
xi = xi or {}
xi.salvage = xi.salvage or {}

xi.salvage.onTransportUpdate = function(player, instance)
    if instance:getLocalVar('transportUser') == 0 then
        local chars = instance:getChars()

        instance:setLocalVar('transportUser', player:getID())
        instance:setLocalVar('stageComplete', 0)
        xi.salvage.resetTempBoxes(player)
        xi.salvage.deSpawnStage(instance)

        for _, target in pairs(chars) do
            if target:getID() ~= player:getID() then
                if target:isInEvent() then
                    target:release()
                end
            end
        end

        player:timer(10000, function(playerArg)
            instance:setLocalVar('transportUser', 0)
        end)
    else
        return
    end
end

xi.salvage.teleportGroup = function(target)
    local instance = target:getInstance()
    local chars    = instance:getChars()
    local pos      = target:getPos()
    local csid     = target:getZoneID() == xi.zone.BHAFLAU_REMNANTS and 4 or 3

    for _, players in pairs(chars) do
        if players:getID() ~= target:getID() then
            players:startCutscene(csid)
            players:timer(4000, function(targetArg)
                targetArg:setPos(pos.x, pos.y, pos.z, pos.rot)
                targetArg:setHP(targetArg:getMaxHP())
                targetArg:setMP(targetArg:getMaxMP())

                local pet = targetArg:getPet()

                if pet then
                    pet:setPos(pos.x, pos.y, pos.z, pos.rot)
                    pet:setHP(pet:getMaxHP())
                    pet:setMP(pet:getMaxMP())
                end
            end)
        end
    end
end

xi.salvage.deSpawnStage = function(instance)
    local mobs = instance:getMobs()

    for _, enemy in pairs(mobs) do
        DespawnMob(enemy:getID(), instance)
    end
end
