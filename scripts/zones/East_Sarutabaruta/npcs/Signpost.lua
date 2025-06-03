-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Signpost
-----------------------------------
local ID = zones[xi.zone.EAST_SARUTABARUTA]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- TODO: These really should be split out into unique NPCs, as this handles all
-- signposts in East Sarutabaruta.
local signPostPositions =
{
-- Offset     xMin,   xMax,    zMin,    zMax
    [0] = {   83.9,   96.7,  -352.6,  -339.8 },
    [1] = {  191.5,  204.3, -277.13, -265.03 },
    [2] = {  212.9,    225,   -37.7,   -24.8 },
    [3] = {   -0.4,   12.6,   -54.9,   -42.9 },
    [4] = { -135.3, -122.3,  -67.14,  -55.04 },
    [5] = {  -80.5,  -67.4,   442.7,   454.8 },
    [6] = {  144.1,  157.1,   374.6,   386.7 },
    [7] = {  -94.9,  -82.9,  -292.4,  -279.5 },
    [8] = {  -55.8,  -43.8,  -133.5,  -120.5 },
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

    for offsetValue, signPost in pairs(signPostPositions) do
        if isNpcInBounds(xPos, zPos, signPost) then
            player:messageSpecial(ID.text.SIGNPOST_OFFSET + offsetValue)
        end
    end
end

return entity
