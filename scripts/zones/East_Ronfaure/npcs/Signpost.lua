-----------------------------------
-- Area: East Ronfaure
--  NPC: Signpost
-- Involved in Quest: To Cure a Cough
-- !pos 257 -45 212 101
-----------------------------------
---@type TNpcEntity
local entity = {}

-- TODO: These really should be split out into unique NPCs, as this handles all
-- signposts in East Ronfaure.
local signPostPositions =
{
-- Event      xMin,  xMax,   zMin,   zMax
    [ 3] = { 434.9, 446.9,  136.4,  148.4 },
    [ 5] = { 251.6, 263.6,  207.7,  219.7 },
    [ 7] = { 652.2, 664.2,  299.5,  311.5 },
    [ 9] = { 459.2, 471.2, -179.4, -167.4 },
    [11] = {   532,   544, -390.2, -378.2 },
    [13] = { 273.1, 285.1, -263.6, -251.6 },
    [15] = { 290.5, 302.5, -463.1, -451.1 },
    [17] = { 225.1, 237.1,   56.6,   68.6 },
}

-- This same function is used in other signposts as well, though making this
-- a global would encourage more things like this instead of splitting NPCs.
local function isNpcInBounds(npcXpos, npcZpos, signPostTable)
    if
        npcXpos > signPostTable[1] and
        npcXpos < signPostTable[2] and
        npcZpos > signPostTable[3] and
        npcZpos < signPostTable[4]
    then
        return true
    end

    return false
end

entity.onTrigger = function(player, npc)
    local xPos = npc:getXPos()
    local zPos = npc:getZPos()

    for eventID, signPost in pairs(signPostPositions) do
        if isNpcInBounds(xPos, zPos, signPost) then
            if eventID == 5 and player:hasKeyItem(xi.ki.SCROLL_OF_TREASURE) then
                -- Event for 'To Cure a Cough' reward
                player:startEvent(20)
            else
                player:startEvent(eventID)
            end
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 20 then
        player:delKeyItem(xi.ki.SCROLL_OF_TREASURE)
        npcUtil.giveCurrency(player, 'gil', 3000)
    end
end

return entity
