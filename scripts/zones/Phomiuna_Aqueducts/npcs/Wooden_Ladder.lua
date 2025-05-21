-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: Wooden Ladder
-- !pos 101.9 -1.5 -101.9
-- !pos 101.948 -1.5 -18.016
-- !pos -61.888 -1.5 -18.079
-- !pos -218.109 -1.499 18.081
-- !pos -61.903 -1.5 138.099
-- !pos 21.901 -1.5 138.096
-- !pos 101.902 -1.5 181.902
-- !pos  -159.32 -2.5 60
-- !pos -159.38 -22.559 60
-- !pos 199.317 -2.5 60
-- !pos 199.38 -22.559 60
-- !pos -200.679 -8.57 60
-----------------------------------
local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Ladder positions which have events associated with them.  There is one
-- ladder that only displays a message, which is marked as 99.  This is
-- a placeholder to detect that.
local ladderPositions =
{
-- Event        xMin,    xMax,  yMin, yMax,   zMin,  zMax
    [21] = {    95.9,   107.9,    -1,    1, -108.9,   -98 },
    [22] = {    95.9,   107.9,    -1,    1,    -24,   -12 },
    [23] = { -67.888, -55.888,    -1,    1,    -24,   -12 },
    [24] = {  -224.1,  -212.1,    -1,    1,     12,    24 },
    [25] = {   -67.9,   -55.9,    -1,    1,    132,   144 },
    [26] = {    15.9,    27.9,    -1,    1,    132,   144 },
    [27] = {    95.9,   107.9,    -1,    1,  175.9, 187.9 },
    [28] = {  -168.3,  -153.3,    -2,    0,     54,    66 },
    [29] = {  -168.3,  -153.3,   -24,  -22,     54,    66 },
    [30] = {   193.3,   205.3,    -2,    0,     54,    66 },
    [31] = {   193.3,   205.3,   -24,  -22,     54,    66 },
    [99] = {  -206.6,  -194.6,    -8,   -6,     54,    66 },
}

-- This same function is used in other signposts as well, though making this
-- a global would encourage more things like this instead of splitting NPCs.
local function isNpcInBounds(npcXpos, npcYpos, npcZpos, ladderTable)
    if
        npcXpos >= ladderTable[1] and
        npcXpos <= ladderTable[2] and
        npcYpos >= ladderTable[3] and
        npcYpos <= ladderTable[4] and
        npcZpos >= ladderTable[5] and
        npcZpos <= ladderTable[6]
    then
        return true
    end

    return false
end

entity.onTrigger = function(player, npc)
    local xPos = player:getXPos()
    local yPos = player:getYPos()
    local zPos = player:getZPos()
    local distanceToLadder = player:checkDistance(npc)

    for eventID, ladder in pairs(ladderPositions) do
        if isNpcInBounds(xPos, yPos, zPos, ladder) then
            if distanceToLadder >= 1.95 then
                player:messageSpecial(ID.text.CANNOT_REACH_LADDER)
            elseif
                eventID == 28 and
                player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.DISTANT_BELIEFS and
                xi.mission.getVar(player, xi.mission.log_id.COP, xi.mission.id.cop.DISTANT_BELIEFS, 'Status') == 1
            then
                player:startEvent(35)
            elseif eventID == 99 then
                player:messageSpecial(ID.text.DOOR_SEALED_SHUT)
            else
                player:startOptionalCutscene(eventID)
            end
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 35 then
        xi.mission.setVar(player, xi.mission.log_id.COP, xi.mission.id.cop.DISTANT_BELIEFS, 'Status', 2)
    end
end

return entity
