-----------------------------------
-- Zone: Inner Horutoto Ruins (192)
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, -260.7, 0, -30.2, -259.4, 1, -29.1) -- Red
    zone:registerCuboidTriggerArea(2, -264.0, 0, -24.7, -262.4, 1, -23.5) -- White
    zone:registerCuboidTriggerArea(3, -257.8, 0, -24.9, -256.1, 1, -23.5) -- Black
    zone:registerCuboidTriggerArea(4, -261, -3, 182, -257, -1, 186) -- Teleport at H-6

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
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local circle = ID.npc.PORTAL_CIRCLE_BASE
    local red    = GetNPCByID(circle)
    local white  = GetNPCByID(circle + 1)
    local black  = GetNPCByID(circle + 2)

    -- Prevent negatives..
    if triggerArea:getCount() < 0 then
        triggerArea:addCount(math.abs(triggerArea:getCount()))
    end

    -- TODO: Use common function for handling circles
    switch (triggerArea:getTriggerAreaID()): caseof
    {
        [1] = function()  -- Red Circle
            if player:getMainJob() == xi.job.RDM and triggerArea:addCount(1) == 1 then
                if red then
                    red:setAnimation(xi.anim.OPEN_DOOR)
                    red:entityAnimationPacket(xi.animationString.OPEN_DOOR)
                end

                if
                    white and white:getAnimation() == xi.anim.OPEN_DOOR and
                    black and black:getAnimation() == xi.anim.OPEN_DOOR
                then
                    GetNPCByID(circle + 3):openDoor(30)
                    GetNPCByID(circle + 4):openDoor(30)
                end
            end
        end,

        [2] = function()  -- White Circle
            if player:getMainJob() == xi.job.WHM and triggerArea:addCount(1) == 1 then
                if white then
                    white:setAnimation(xi.anim.OPEN_DOOR)
                    white:entityAnimationPacket(xi.animationString.OPEN_DOOR)
                end

                if
                    red and red:getAnimation() == xi.anim.OPEN_DOOR and
                    black and black:getAnimation() == xi.anim.OPEN_DOOR
                then
                    GetNPCByID(circle + 3):openDoor(30)
                    GetNPCByID(circle + 4):openDoor(30)
                end
            end
        end,

        [3] = function()  -- Black Circle
            if player:getMainJob() == xi.job.BLM and triggerArea:addCount(1) == 1 then
                if black then
                    black:setAnimation(xi.anim.OPEN_DOOR)
                    black:entityAnimationPacket(xi.animationString.OPEN_DOOR)
                end

                if
                    red and red:getAnimation() == xi.anim.OPEN_DOOR and
                    white and white:getAnimation() == xi.anim.OPEN_DOOR
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

    switch (triggerArea:getTriggerAreaID()): caseof
    {
        [1] = function()  -- Red Circle
            if
                red and
                player:getMainJob() == xi.job.RDM and
                triggerArea:delCount(1) == 0
            then
                red:setAnimation(xi.anim.CLOSE_DOOR)
                red:entityAnimationPacket(xi.animationString.CLOSE_DOOR)
            end
        end,

        [2] = function()  -- White Circle
            if
                white and
                player:getMainJob() == xi.job.WHM and
                triggerArea:delCount(1) == 0
            then
                white:setAnimation(xi.anim.CLOSE_DOOR)
                white:entityAnimationPacket(xi.animationString.CLOSE_DOOR)
            end
        end,

        [3] = function()  -- Black Circle
            if
                black and
                player:getMainJob() == xi.job.BLM and
                triggerArea:delCount(1) == 0
            then
                black:setAnimation(xi.anim.CLOSE_DOOR)
                black:entityAnimationPacket(xi.animationString.CLOSE_DOOR)
            end
        end,
    }

    -- Prevent negatives
    if triggerArea:getCount() < 0 then
        triggerArea:addCount(math.abs(triggerArea:getCount()))
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
