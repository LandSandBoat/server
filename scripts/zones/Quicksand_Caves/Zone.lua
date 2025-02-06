-----------------------------------
-- Zone: Quicksand_Caves (208)
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Weight Door System
    zone:registerCylindricalTriggerArea(1, -15, -60, 5)
    zone:registerCylindricalTriggerArea(3, 15, -180, 5)
    zone:registerCylindricalTriggerArea(5, -580, -420, 5)
    zone:registerCylindricalTriggerArea(7, -700, -420, 5)
    zone:registerCylindricalTriggerArea(9, -700, -380, 5)
    zone:registerCylindricalTriggerArea(11, -780, -460, 5)
    zone:registerCylindricalTriggerArea(13, -820, -380, 5)
    zone:registerCylindricalTriggerArea(15, -260, 740, 5)
    zone:registerCylindricalTriggerArea(17, -340, 660, 5)
    zone:registerCylindricalTriggerArea(19, -340, 820, 5)
    zone:registerCylindricalTriggerArea(21, -409, 800, 5)
    zone:registerCylindricalTriggerArea(23, -420, 740, 5)
    zone:registerCylindricalTriggerArea(25, -400, 670, 5)

    -- Hole in the Sand
    zone:registerCuboidTriggerArea(30, 495, -9, -817, 497, -7, -815) -- E-11 (Map 2)
    zone:registerCuboidTriggerArea(31, 815, -9, -744, 817, -7, -742) -- M-9 (Map 2)
    zone:registerCuboidTriggerArea(32, 215, 6, -17, 217, 8, -15)     -- K-6 (Map 3)
    zone:registerCuboidTriggerArea(33, -297, 6, 415, -295, 8, 417)   -- E-7 (Map 6)
    zone:registerCuboidTriggerArea(34, -137, 6, -177, -135, 8, -175) -- G-7 (Map 8)

    xi.treasure.initZone(zone)

    npcUtil.UpdateNPCSpawnPoint(ID.npc.ANTICAN_TAG_QM, 60, 120, ID.npc.ANTICAN_TAG_POSITIONS, '[POP]Antican_Tag')
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-980.193, 14.913, -282.863, 60)
    end

    return cs
end

local function getWeight(player)
    local race = player:getRace()

    if race == xi.race.GALKA or player:hasKeyItem(xi.ki.LOADSTONE) then
        return 3
    elseif race == xi.race.TARU_M or race == xi.race.TARU_F then
        return 1
    else
        return 2
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local triggerAreaID = triggerArea:getTriggerAreaID()

    -- holes in the sand
    if player and triggerAreaID >= 30 then
        switch (triggerAreaID): caseof
        {
            [30] = function()
                player:setPos(496, -6, -816)
            end,

            [31] = function()
                player:setPos(816, -6, -743)
            end,

            [32] = function()
                player:setPos(216, 9, -16)
            end,

            [33] = function()
                player:setPos(-296, 9, 416)
            end,

            [34] = function()
                player:setPos(-136, 9, -176)
            end,
        }

    -- ornate door pressure plates
    else
        local door = GetNPCByID(ID.npc.ORNATE_DOOR_OFFSET + triggerAreaID - 1)
        local plate = GetNPCByID(ID.npc.ORNATE_DOOR_OFFSET + triggerAreaID)

        if
            not plate or
            not door
        then
            return
        end

        local totalWeight = plate:getLocalVar('weight')
        if player then
            totalWeight = totalWeight + getWeight(player)
            plate:setLocalVar('weight', totalWeight)
        end

        if
            totalWeight >= 3 and
            plate:getLocalVar('opening') == 0 and
            door:getAnimation() == xi.anim.CLOSE_DOOR
        then
            SendEntityVisualPacket(plate:getID(), 'unlc') -- Play the light animation
            plate:setLocalVar('opening', 1)

            -- wait 5 seconds to open the door
            door:timer(5000, function(doorArg)
                doorArg:openDoor(10) -- open door with a 10 second time delay.
            end)

            -- allow door to retrigger 17 seconds from now
            plate:timer(17000, function(plateArg)
                plateArg:setLocalVar('opening', 0)

                -- retrigger if weight is still enough to do so
                if plateArg:getLocalVar('weight') >= 3 then
                    -- retrigger, with nil as player arg, player is not necessary to re-open the door if weight is >= 3.
                    -- TODO: Separate nil-based logic out of function call
                    ---@diagnostic disable-next-line param-type-mismatch
                    zoneObject.onTriggerAreaEnter(nil, triggerArea)
                end
            end)
        end
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
    local triggerAreaID = triggerArea:getTriggerAreaID()

    if triggerAreaID < 30 then
        local plate = GetNPCByID(ID.npc.ORNATE_DOOR_OFFSET + triggerAreaID)
        if not plate then
            return
        end

        local totalWeight = plate:getLocalVar('weight')
        totalWeight = totalWeight - getWeight(player)
        plate:setLocalVar('weight', totalWeight)
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
