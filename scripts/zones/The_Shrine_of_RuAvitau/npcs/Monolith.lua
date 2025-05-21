-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  NPC: Monolith
-- !pos <many>
-----------------------------------
local ID = zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

local doors =
{
    [ 0] = 'y', [ 4] = 'b',
    [ 1] = 'y', [ 5] = 'b',
    [ 2] = 'y', [ 6] = 'b',
    [ 3] = 'y', [ 7] = 'b',
    [ 8] = 'y', [ 9] = 'b',
    [12] = 'y', [10] = 'b',
    [13] = 'y', [11] = 'b',
    [14] = 'y', [16] = 'b',
    [15] = 'y', [17] = 'b',
    [19] = 'y', [18] = 'b',
    [21] = 'y', [20] = 'b',
}

local monoliths =
{
    [ 0] = 'y', [ 4] = 'b',
    [ 1] = 'y', [ 5] = 'b',
    [ 2] = 'y', [ 6] = 'b',
    [ 3] = 'y', [ 7] = 'b',
    [ 9] = 'y', [ 8] = 'b',
    [12] = 'y', [10] = 'b',
    [13] = 'y', [11] = 'b',
    [16] = 'y', [14] = 'b',
    [17] = 'y', [15] = 'b',
    [18] = 'y', [19] = 'b',
}

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.MONOLITH_OFFSET
    if offset >= 0 and offset <= 38 then
        local colorTouched = monoliths[offset / 2]
        for i = 0, 21 do
            local anim = doors[i] == colorTouched and xi.anim.OPEN_DOOR or xi.anim.CLOSE_DOOR
            GetNPCByID(ID.npc.DOOR_OFFSET + i):setAnimation(anim)
        end

        for i = 0, 19 do
            local anim = monoliths[i] == colorTouched and xi.anim.OPEN_DOOR or xi.anim.CLOSE_DOOR
            GetNPCByID(ID.npc.MONOLITH_OFFSET + (i * 2) - 1):setAnimation(anim)
        end
    end
end

return entity
