-----------------------------------
-- Salvage: Arrapago Remnants
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REMNANTS]
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return xi.salvage.registryRequirements(player)
end

instanceObject.entryRequirements = function(player)
    return xi.salvage.entryRequirements(player)
end

instanceObject.afterInstanceRegister = function(player)
    xi.salvage.afterInstanceRegister(player, xi.item.CAGE_OF_A_REMNANTS_FIREFLIES)
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
        GetNPCByID(ID.npc[6].DOOR, instance):setLocalVar('start', GetSystemTime())
    elseif instance:getStage() == 7 and progress == 0 then
        local door = GetNPCByID(ID.npc[6].DOOR, instance)
        if door then
            door:setLocalVar('current', GetSystemTime())
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
    if option ~= 1 then
        return
    end

    local instance = player:getInstance()
    local csidAr   = xi.salvage.csid.AR

    if csid >= csidAr.FLOOR_1_TO_2_START and csid <= csidAr.FLOOR_1_TO_2_END then
        local offset = csid - (csidAr.FLOOR_1_TO_2_START - 1)

        for id = ID.mob[2][offset].mobs_start, ID.mob[2][offset].mobs_end do
            SpawnMob(id, instance)
        end

        instance:setProgress(offset)
        for id = ID.mob[1][2].rampart, ID.mob[1][2].mobs_end do
            DespawnMob(id, instance)
        end

    elseif csid == csidAr.FLOOR_2_TO_3 then
        for i = 1, 2 do
            for id = ID.mob[3][i].mobs_start, ID.mob[3][i].mobs_end do
                SpawnMob(id, instance)
            end
        end

        instance:setProgress(csid - (csidAr.FLOOR_2_TO_3 - 1))
        for id = ID.mob[2][4].mobs_start, ID.mob[2][0].astrologer do
            DespawnMob(id, instance)
        end

        DespawnMob(ID.mob[2][2].princess, instance)
        DespawnMob(ID.mob[2][3].wahzil, instance)

    elseif csid == csidAr.FLOOR_3_TO_4_S or csid == csidAr.FLOOR_3_TO_4_N then
        local offset = csid - (csidAr.FLOOR_3_TO_4_S - 1)

        for id = ID.mob[4][offset].mobs_start, ID.mob[4][offset].mobs_end do
            SpawnMob(id, instance)
        end

        SpawnMob(ID.mob[4][offset].rampart2, instance)

        instance:setProgress(offset)
        for id = ID.mob[3][1].mobs_start, ID.mob[3].qiqirn_mine_2 do
            DespawnMob(id, instance)
        end

    elseif csid == csidAr.FLOOR_4_TO_5_S or csid == csidAr.FLOOR_4_TO_5_N then
        local offset = csid - (csidAr.FLOOR_4_TO_5_S - 1)

        for i = 1, 3 do
            for id = ID.mob[5][offset][i].mobs_start, ID.mob[5][offset][i].mobs_end do
                SpawnMob(id, instance)
            end
        end

        local mobGroups = ID.mob[5][offset]
        if mobGroups.rampart1 then
            SpawnMob(mobGroups.rampart1, instance)
        end

        if mobGroups.rampart2 then
            SpawnMob(mobGroups.rampart2, instance)
        end

        if mobGroups.rampart3 then
            SpawnMob(mobGroups.rampart3, instance)
        end

        instance:setProgress(offset)
        for id = ID.mob[4][1].mobs_start, ID.mob[4].qiqirn_mine_1 do
            DespawnMob(id, instance)
        end

    elseif csid == csidAr.FLOOR_5_TO_6 then
        for id = ID.mob[6][1].mobs_start, ID.mob[6][1].mobs_end do
            SpawnMob(id, instance)
        end

        SpawnMob(ID.mob[6].rampart1, instance)
        SpawnMob(ID.mob[6].rampart2, instance)
        instance:setProgress(csid - (csidAr.FLOOR_5_TO_6 - 1))
        for id = ID.mob[5][1][1].mobs_start, ID.mob[5][2].chariot do
            DespawnMob(id, instance)
        end

    elseif csid == csidAr.FLOOR_6_TO_BOSS then
        SpawnMob(ID.mob[7][1].chariot, instance)
        instance:setProgress(csid - (csidAr.FLOOR_6_TO_BOSS - 1))
        for id = ID.mob[6].rampart1, ID.mob[6].rampart4 do
            DespawnMob(id, instance)
        end
    end
end

return instanceObject
