-----------------------------------
-- Area: Castle Oztroja
--  NPC: Brass Statue
-- Type: Passageway Machine
-- !pos -60.061 -4.348 -61.538 151 (1)
-- !pos -18.599 -19.307 20.024 151 (2)
-- !pos -60 22 -100 151            (3)
-- !pos -100 -72 -19 151           (4)
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
-----------------------------------

local passwordTable =
{
    [0] = {[1] = {15, "Deggi"}, [2] = {16, "Haqa"},  [3] = {17, "Mjuu"}},
    [1] = {[1] = {18, "Puqu"},  [2] = {19, "Ouzi"},  [3] = {20, "Duzu"}},
    [2] = {[1] = {21, "Gadu"},  [2] = {22, "Mong"},  [3] = {23, "Buxu"}},
    [3] = {[1] = {24, "Xicu"},  [2] = {17, "Mjuu"},  [3] = {21, "Gadu"}},
    [4] = {[1] = {16, "Haqa"},  [2] = {20, "Duzu"},  [3] = {21, "Gadu"}},
    [5] = {[1] = {21, "Gadu"},  [2] = {18, "Puqu"},  [3] = {22, "Mong"}},
    [6] = {[1] = {21, "Gadu"},  [2] = {23, "Buxu"},  [3] = {20, "Duzu"}},
    [7] = {[1] = {20, "Duzu"},  [2] = {15, "Deggi"}, [3] = {19, "Ouzi"}},
    [8] = {[1] = {17, "Mjuu"},  [2] = {19, "Ouzi"},  [3] = {23, "Buxu"}},
}

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local statue = npc:getID()
    local passwordIndex = GetNPCByID(ID.npc.TRAP_DOOR_FLOOR_4):getLocalVar("password")
    local password = passwordTable[passwordIndex]

    if statue == ID.npc.FIRST_PASSWORD_STATUE then
        player:messageSpecial(ID.text.FIRST_WORD)
        player:messageSpecial(password[1][1])
    elseif statue == ID.npc.SECOND_PASSWORD_STATUE then
        player:messageSpecial(ID.text.SECOND_WORD)
        player:messageSpecial(password[2][1])
    elseif statue == ID.npc.THIRD_PASSWORD_STATUE then
        player:messageSpecial(ID.text.THIRD_WORD)
        player:messageSpecial(password[3][1])
    elseif statue == ID.npc.FINAL_PASSWORD_STATUE then
        player:startEvent(13)
    end
end

function onEventUpdate(player, csid, option)
    local passwordGuess = player:getLocalVar("passwordGuess")
    local passwordIndex = GetNPCByID(ID.npc.TRAP_DOOR_FLOOR_4):getLocalVar("password")
    local password = passwordTable[passwordIndex]

    if csid == 13 and option == password[1][2] and passwordGuess == 0 then
        player:updateEvent(1)
        player:setLocalVar("passwordGuess", 1)
    elseif csid == 13 and option == password[2][2] and passwordGuess == 1 then
        player:updateEvent(2)
        player:setLocalVar("passwordGuess", 2)
    elseif csid == 13 and option == password[3][2] and passwordGuess == 2 then
        player:updateEvent(3)
        player:setLocalVar("passwordGuess", 3)
    else
        player:messageSpecial(ID.text.INCORRECT)
        player:setLocalVar("passwordGuess", 0)
    end
end

function onEventFinish(player, csid, option)
    local passwordGuess = player:getLocalVar("passwordGuess")

    if csid == 13 and passwordGuess == 3 then
        GetNPCByID(ID.npc.TRAP_DOOR_FLOOR_4):openDoor(6)
        player:setLocalVar("passwordGuess", 0)
    end
end
