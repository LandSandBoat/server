-----------------------------------
-- Salvage: Arrapago Remnants
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REMNANTS]
-----------------------------------
local instanceObject = {}

instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
    player:messageSpecial(ID.text.SALVAGE_START, 1)
    player:addStatusEffectEx(xi.effect.ENCUMBRANCE_I, xi.effect.ENCUMBRANCE_I, 0xFFFF, 0, 6000)
    player:addStatusEffectEx(xi.effect.OBLIVISCENCE, xi.effect.OBLIVISCENCE, 0, 0, 6000)
    player:addStatusEffectEx(xi.effect.OMERTA, xi.effect.OMERTA, 0x3F, 0, 6000)
    player:addStatusEffectEx(xi.effect.IMPAIRMENT, xi.effect.IMPAIRMENT, 3, 0, 6000)
    player:addStatusEffectEx(xi.effect.DEBILITATION, xi.effect.DEBILITATION, 0x1FF, 0, 6000)
    for i = 0, 15 do
        player:unequipItem(i)
    end
end

instanceObject.onInstanceCreated = function(instance)
    for _, v in pairs(ID.npc[1][1]) do
        local npc = GetNPCByID(v, instance)

        if npc then
            npc:setStatus(xi.status.NORMAL)
        end
    end

    instance:setStage(1)
    instance:setProgress(0)
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    if instance then
        player:setInstance(instance)
        player:setPos(0, 0, 0, 0, instance:getZone():getID())
    end
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(1)
    end
end

instanceObject.onInstanceComplete = function(instance)
end

instanceObject.onTriggerAreaEnter = function(player, triggerArea, instance)
    if triggerArea:getTriggerAreaID() <= 11 then
        player:startEvent(199 + triggerArea:getTriggerAreaID())
    end
end

instanceObject.onInstanceProgressUpdate = function(instance, progress, elapsed)
    if instance:getStage() == 1 and progress == 10 then
        SpawnMob(ID.mob[1][2].rampart, instance)
    elseif instance:getStage() == 2 and progress == 2 then -- attempt to spawn slot
        GetNPCByID(ID.npc[2][2].SLOT, instance):setStatus(xi.status.NORMAL)
    elseif instance:getStage() == 2 and progress == 3 then -- attempt to spawn socket
        GetNPCByID(ID.npc[2][2].SOCKET, instance):setStatus(xi.status.NORMAL)
    elseif instance:getStage() == 3 and progress == 1 then
        SpawnMob(ID.mob[2][0].astrologer, instance)
    elseif instance:getStage() == 6 and progress == 1 then
        GetNPCByID(ID.npc[6].DOOR, instance):setLocalVar('start', os.time())
    elseif instance:getStage() == 7 and progress == 0 then
        local door = GetNPCByID(ID.npc[6].DOOR, instance)
        if door then
            door:setLocalVar('current', os.time())
            if door:getLocalVar('current') - door:getLocalVar('start') <= 420 then
                SpawnMob(ID.mob[6].treasure_hunter1, instance)
                SpawnMob(ID.mob[6].treasure_hunter2, instance)
                SpawnMob(ID.mob[6].qiqirn_mine_1, instance)
                SpawnMob(ID.mob[6].qiqirn_mine_2, instance)
            end
        end
    end
end

instanceObject.onEventUpdate = function(player, csid, option, npc)
end

instanceObject.onEventFinish = function(player, csid, option, npc)
    local instance = player:getInstance()

    if csid >= 200 and csid <= 203 and option == 1 then
        for id = ID.mob[2][csid - 199].mobs_start, ID.mob[2][csid - 199].mobs_end do
            SpawnMob(id, instance)
        end

        instance:setProgress(csid - 199)
        for id = ID.mob[1][2].rampart, ID.mob[1][2].mobs_end do
            DespawnMob(id, instance)
        end
    elseif csid == 204 and option == 1 then
        for i = 1, 2 do
            for id = ID.mob[3][i].mobs_start, ID.mob[3][i].mobs_end do
                SpawnMob(id, instance)
            end
        end

        instance:setProgress(csid - 203)
            for id = ID.mob[2][4].mobs_start, ID.mob[2][0].astrologer do
                DespawnMob(id, instance)
            end
        DespawnMob(ID.mob[2][2].princess, instance)
        DespawnMob(ID.mob[2][3].wahzil, instance)
    elseif csid == 205 or csid == 206 and option == 1 then
        for id = ID.mob[4][csid - 204].mobs_start, ID.mob[4][csid - 204].mobs_end do
            SpawnMob(id, instance)
            SpawnMob(ID.mob[4][csid - 204].rampart2, instance)
        end

        instance:setProgress(csid - 204)
        for id = ID.mob[3][1].mobs_start, ID.mob[3].qiqirn_mine_2 do
            DespawnMob(id, instance)
        end
    elseif csid == 207 or csid == 208 and option == 1 then
        for i = 1, 3 do
            for id = ID.mob[5][csid - 206][i].mobs_start, ID.mob[5][csid - 206][i].mobs_end do
                SpawnMob(id, instance)
            end
        end

        SpawnMob(ID.mob[5][csid - 206].rampart1, instance)
        SpawnMob(ID.mob[5][csid - 206].rampart2, instance)
        SpawnMob(ID.mob[5][csid - 206].rampart3, instance)
        instance:setProgress(csid - 206)
        for id = ID.mob[4][1].mobs_start, ID.mob[4].qiqirn_mine_1 do
            DespawnMob(id, instance)
        end
    elseif csid == 209 and option == 1 then
        for id = ID.mob[6][1].mobs_start, ID.mob[6][1].mobs_end do
            SpawnMob(id, instance)
        end

        SpawnMob(ID.mob[6].rampart1, instance)
        SpawnMob(ID.mob[6].rampart2, instance)
        instance:setProgress(csid - 208)
        for id = ID.mob[5][1][1].mobs_start, ID.mob[5][2].chariot do
            DespawnMob(id, instance)
        end
    elseif csid == 210 and option == 1 then
        SpawnMob(ID.mob[7][1].chariot, instance)
        instance:setProgress(csid - 209)
        for id = ID.mob[6].rampart1, ID.mob[6].rampart4 do
            DespawnMob(id, instance)
        end
    end
end

return instanceObject
