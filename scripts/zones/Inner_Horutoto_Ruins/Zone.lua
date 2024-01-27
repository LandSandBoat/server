-----------------------------------
-- Zone: Inner Horutoto Ruins (192)
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1, -260.7, 0, -30.2, -259.4, 1, -29.1) -- Red
    zone:registerTriggerArea(2, -264.0, 0, -24.7, -262.4, 1, -23.5) -- White
    zone:registerTriggerArea(3, -257.8, 0, -24.9, -256.1, 1, -23.5) -- Black
    zone:registerTriggerArea(4, -261, -3, 182, -257, -1, 186) -- Teleport at H-6

    xi.treasure.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-259.996, 6.399, 242.859, 67)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local circle = ID.npc.PORTAL_CIRCLE_BASE
    local red    = GetNPCByID(circle)
    local white  = GetNPCByID(circle + 1)
    local black  = GetNPCByID(circle + 2)

    -- Prevent negatives..
    if triggerArea:GetCount() < 0 then
        triggerArea:AddCount(math.abs(triggerArea:GetCount()))
    end

    switch (triggerArea:GetTriggerAreaID()): caseof
    {
        [1] = function()  -- Red Circle
            if player:getMainJob() == xi.job.RDM and triggerArea:AddCount(1) == 1 then
                red:setAnimation(xi.anim.OPEN_DOOR)
                red:entityAnimationPacket('smin')
                if
                    white:getAnimation() == xi.anim.OPEN_DOOR and
                    black:getAnimation() == xi.anim.OPEN_DOOR
                then
                    GetNPCByID(circle + 3):openDoor(30)
                    GetNPCByID(circle + 4):openDoor(30)
                end
            end
        end,

        [2] = function()  -- White Circle
            if player:getMainJob() == xi.job.WHM and triggerArea:AddCount(1) == 1 then
                white:setAnimation(xi.anim.OPEN_DOOR)
                white:entityAnimationPacket('smin')
                if
                    red:getAnimation() == xi.anim.OPEN_DOOR and
                    black:getAnimation() == xi.anim.OPEN_DOOR
                then
                    GetNPCByID(circle + 3):openDoor(30)
                    GetNPCByID(circle + 4):openDoor(30)
                end
            end
        end,

        [3] = function()  -- Black Circle
            if player:getMainJob() == xi.job.BLM and triggerArea:AddCount(1) == 1 then
                black:setAnimation(xi.anim.OPEN_DOOR)
                black:entityAnimationPacket('smin')
                if
                    red:getAnimation() == xi.anim.OPEN_DOOR and
                    white:getAnimation() == xi.anim.OPEN_DOOR
                then
                    GetNPCByID(circle + 3):openDoor(30)
                    GetNPCByID(circle + 4):openDoor(30)
                end
            end
        end,

        [4] = function()  -- Teleport at H-6
            player:startEvent(47)
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
    local circle = ID.npc.PORTAL_CIRCLE_BASE
    local red    = GetNPCByID(circle)
    local white  = GetNPCByID(circle + 1)
    local black  = GetNPCByID(circle + 2)

    switch (triggerArea:GetTriggerAreaID()): caseof
    {
        [1] = function()  -- Red Circle
            if player:getMainJob() == xi.job.RDM and triggerArea:DelCount(1) == 0 then
                red:setAnimation(xi.anim.CLOSE_DOOR)
                red:entityAnimationPacket('kmin')
            end
        end,

        [2] = function()  -- White Circle
            if player:getMainJob() == xi.job.WHM and triggerArea:DelCount(1) == 0 then
                white:setAnimation(xi.anim.CLOSE_DOOR)
                white:entityAnimationPacket('kmin')
            end
        end,

        [3] = function()  -- Black Circle
            if player:getMainJob() == xi.job.BLM and triggerArea:DelCount(1) == 0 then
                black:setAnimation(xi.anim.CLOSE_DOOR)
                black:entityAnimationPacket('kmin')
            end
        end,
    }

    -- Prevent negatives
    if triggerArea:GetCount() < 0 then
        triggerArea:AddCount(math.abs(triggerArea:GetCount()))
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
