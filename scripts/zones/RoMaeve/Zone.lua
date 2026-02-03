-----------------------------------
-- Zone: RoMaeve (122)
-----------------------------------
local ID = zones[xi.zone.ROMAEVE]
-----------------------------------
---@type TZone
local zoneObject = {}

local function handleFullMoon()
    local shouldDoorsOpen = (getVanadielMoonCycle() == xi.moonCycle.FULL_MOON and VanadielHour() >= 18 and VanadielHour() < 6)

    -- Set targetable status.
    local moongate1 = GetNPCByID(ID.npc.MOONGATE_OFFSET)
    if moongate1 then
        moongate1:setUntargetable(shouldDoorsOpen)
    end

    local moongate2 = GetNPCByID(ID.npc.MOONGATE_OFFSET + 1)
    if moongate2 then
        moongate2:setUntargetable(shouldDoorsOpen)
    end

    -- Determine what the animation/status of the NPCs should be.
    local doorStatus = shouldDoorsOpen and xi.anim.OPEN_DOOR or xi.anim.CLOSE_DOOR

    -- Loop over the affected NPCs: Moongates, bridges and fountain
    for i = ID.npc.MOONGATE_OFFSET, ID.npc.MOONGATE_OFFSET + 7 do
        local npc = GetNPCByID(i)
        if npc and npc:getAnimation() ~= doorStatus then
            npc:setAnimation(doorStatus)
        end
    end
end

local function handleBastokQM(onInitialize)
    local bastokMissionQM = GetNPCByID(ID.npc.BASTOK_7_1_QM)
    if not bastokMissionQM then
        return
    end

    local newPosition = npcUtil.pickNewPosition(ID.npc.BASTOK_7_1_QM, ID.npc.BASTOK_7_1_QM_POS, onInitialize)
    if onInitialize then
        bastokMissionQM:setPos(newPosition.x, newPosition.y, newPosition.z)
        return
    end

    local vanadielHour = VanadielHour()
    if
        vanadielHour == 0 or
        vanadielHour == 6 or
        vanadielHour == 12 or
        vanadielHour == 18
    then
        npcUtil.queueMove(bastokMissionQM, newPosition)
    end
end

zoneObject.onInitialize = function(zone)
    handleFullMoon()
    handleBastokQM(true)
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
        player:setPos(-0.008, -33.595, 123.478, 62)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameHour = function(zone)
    handleFullMoon()
    handleBastokQM(false)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
