-----------------------------------
-- Area: North Gustaberg
--  NPC: qm1 (???)
-- Involved in Quest "The Siren's Tear"
-----------------------------------
local ID = zones[xi.zone.NORTH_GUSTABERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

local positions =
{
    [0] = { 309.600, 2.600, 324.000 }, -- starting position (from db)
    [1] = { 290.000, 0.600, 332.100 }, -- alternative starting position
    [2] = { 296.000, 3.000, 220.000 },
    [3] = { 349.480, 3.300, 208.000 },
    [4] = { 332.100, 6.000, 150.100 },
}

-- send the QM to one of the two northern starting locations
-- if it's already at one, send it to the other one
local function resetSirenTear(npc)
    local currentPos = npc:getLocalVar('pos')
    local nextPos

    if currentPos == 0 then
        nextPos = 1
    elseif currentPos == 1 then
        nextPos = 0
    else
        nextPos = math.random(0, 1)
    end

    npc:setLocalVar('pos', nextPos)
    npc:setPos(unpack(positions[nextPos]))
end

-- move the QM downstream (south)
-- if it's at the southern end, reset it to one of the two starting positions
local function moveSirenTear(npc)
    local currentPos = npc:getLocalVar('pos')
    if currentPos == 4 then
        resetSirenTear(npc)
    else
        local nextPos = (currentPos == 0) and 2 or (currentPos + 1)
        npc:setLocalVar('pos', nextPos)
        npc:setPos(unpack(positions[nextPos]))
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(10)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10 and option == 0 then
        if
            player:getEquipID(xi.slot.MAIN) == 0 and
            player:getEquipID(xi.slot.SUB) == 0
        then
            if player:hasItem(xi.item.SIRENS_TEAR) then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED_TWICE, xi.item.SIRENS_TEAR)
            elseif npcUtil.giveItem(player, xi.item.SIRENS_TEAR) then
                resetSirenTear(npc)
            end
        else
            player:messageSpecial(ID.text.SHINING_OBJECT_SLIPS_AWAY)
            moveSirenTear(npc)
        end
    end
end

return entity
