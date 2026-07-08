-----------------------------------
-- Area: Castle Oztroja
--  NPC: Brass Statue
-- Type: Passageway Machine
-- !pos -60.061 -4.348 -61.538 151 (1)
-- !pos -60 22 -100 151            (2)
-- !pos -18.599 -19.307 20.024 151 (3)
-- !pos -100 -72 -19 151           (4)
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TNpcEntity
local entity = {}

local passwords =
{
    [ID.text.DEGGI] = 'Deggi',
    [ID.text.HAQA]  = 'Haqa',
    [ID.text.MJUU]  = 'Mjuu',
    [ID.text.PUQU]  = 'Puqu',
    [ID.text.OUZI]  = 'Ouzi',
    [ID.text.DUZU]  = 'Duzu',
    [ID.text.GADU]  = 'Gadu',
    [ID.text.MONG]  = 'Mong',
    [ID.text.BUXU]  = 'Buxu',
    [ID.text.XICU]  = 'Xicu',
}

local passwordLocalVarNames =
{
    'firstWord',
    'secondWord',
    'thirdWord',
}

entity.onTrigger = function(player, npc)
    local statue          = npc:getID()
    local firstWordIndex  = GetNPCByID(ID.npc.TRAP_DOOR_FLOOR_4):getLocalVar(passwordLocalVarNames[1])
    local secondWordIndex = GetNPCByID(ID.npc.TRAP_DOOR_FLOOR_4):getLocalVar(passwordLocalVarNames[2])
    local thirdWordIndex  = GetNPCByID(ID.npc.TRAP_DOOR_FLOOR_4):getLocalVar(passwordLocalVarNames[3])

    if statue == ID.npc.FIRST_PASSWORD_STATUE then
        player:messageSpecial(ID.text.FIRST_WORD)
        player:messageSpecial(firstWordIndex)
    elseif statue == ID.npc.SECOND_PASSWORD_STATUE then
        player:messageSpecial(ID.text.SECOND_WORD)
        player:messageSpecial(secondWordIndex)
    elseif statue == ID.npc.THIRD_PASSWORD_STATUE then
        player:messageSpecial(ID.text.THIRD_WORD)
        player:messageSpecial(thirdWordIndex)
    elseif statue == ID.npc.FINAL_PASSWORD_STATUE then
        player:startEvent(13)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    local passwordGuess   = player:getLocalVar('passwordGuess')
    local firstWordIndex  = GetNPCByID(ID.npc.TRAP_DOOR_FLOOR_4):getLocalVar(passwordLocalVarNames[1])
    local secondWordIndex = GetNPCByID(ID.npc.TRAP_DOOR_FLOOR_4):getLocalVar(passwordLocalVarNames[2])
    local thirdWordIndex  = GetNPCByID(ID.npc.TRAP_DOOR_FLOOR_4):getLocalVar(passwordLocalVarNames[3])

    if
        csid == 13 and
        option == passwords[firstWordIndex] and
        passwordGuess == 0
    then
        player:updateEvent(1)
        player:setLocalVar('passwordGuess', 1)
    elseif
        csid == 13 and
        option == passwords[secondWordIndex] and
        passwordGuess == 1
    then
        player:updateEvent(2)
        player:setLocalVar('passwordGuess', 2)
    elseif
        csid == 13 and
        option == passwords[thirdWordIndex] and
        passwordGuess == 2
    then
        player:updateEvent(3)
        player:setLocalVar('passwordGuess', 3)
    else
        player:messageSpecial(ID.text.INCORRECT)
        player:setLocalVar('passwordGuess', 0)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local passwordGuess = player:getLocalVar('passwordGuess')

    if csid == 13 and passwordGuess == 3 then
        GetNPCByID(ID.npc.TRAP_DOOR_FLOOR_4):openDoor(6)
        player:setLocalVar('passwordGuess', 0)
    end
end

return entity
