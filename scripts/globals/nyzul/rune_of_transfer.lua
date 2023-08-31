-----------------------------------
-- Nyzul Isle: Rune of transfer global.
-----------------------------------
local ID = zones[xi.zone.NYZUL_ISLE]
-----------------------------------
xi = xi or {}
xi.nyzul = xi.nyzul or {}
-----------------------------------

-----------------------------------
-- Handle first Rune of Transfer (Allows floor selection)
-----------------------------------
local floorCostTable =
{
    [ 1] = { level =  1, cost =    0 },
    [ 2] = { level =  6, cost =  500 },
    [ 3] = { level = 11, cost =  550 },
    [ 4] = { level = 16, cost =  600 },
    [ 5] = { level = 21, cost =  650 },
    [ 6] = { level = 26, cost =  700 },
    [ 7] = { level = 31, cost =  750 },
    [ 8] = { level = 36, cost =  800 },
    [ 9] = { level = 41, cost =  850 },
    [10] = { level = 46, cost =  900 },
    [11] = { level = 51, cost = 1000 },
    [12] = { level = 56, cost = 1100 },
    [13] = { level = 61, cost = 1200 },
    [14] = { level = 66, cost = 1300 },
    [15] = { level = 71, cost = 1400 },
    [16] = { level = 76, cost = 1500 },
    [17] = { level = 81, cost = 1600 },
    [18] = { level = 86, cost = 1700 },
    [19] = { level = 91, cost = 1800 },
    [20] = { level = 96, cost = 1900 },
}

xi.nyzul.firstRuneOfTransferOnTrigger = function(player, npc)
    local instance      = player:getInstance()
    local tokens        = player:getCurrency('nyzul_isle_assault_point')
    local prefered      = player:getCharVar('[Nyzul]preferredItems')
    local floorGroup    = math.floor(player:getCharVar('NyzulFloorProgress') / 5)
    local floorProgress = 0xFFFFFFFC - bit.bxor(bit.lshift(2, floorGroup + 1) - 1, 3)

    if not player:hasKeyItem(xi.ki.RUNIC_DISC) then
        player:messageSpecial(ID.text.NEW_USER, xi.ki.RUNIC_DISC)
        npcUtil.giveKeyItem(player, xi.ki.RUNIC_DISC)
    elseif instance:getLocalVar('runeHandler') ~= 0 then
        player:messageSpecial(ID.text.IN_OPERATION)

        return
    else
        instance:setLocalVar('runeHandler', player:getID())
        player:startEvent(94, xi.ki.RUNIC_DISC, tokens, 1, prefered, 100, 200, 300, floorProgress)
    end

end

xi.nyzul.firstRuneOfTransferOnEventFinish = function(player, csid, option, npc)
    local instance = npc:getInstance()
    local chars    = instance:getChars()

    if
        csid == 94 and
        option > 0 and
        option < 21 and
        instance:getLocalVar('runeHandler') == player:getID()
    then
        local floorCost = floorCostTable[option]

        if player:getCurrency('nyzul_isle_assault_point') >= floorCost.cost then
            player:delCurrency('nyzul_isle_assault_point', floorCost.cost)
            instance:setLocalVar('Nyzul_Isle_StartingFloor', floorCost.level)
            instance:setLocalVar('[Nyzul]CurrentFloor', floorCost.level)
            instance:setLocalVar('diskHolder', player:getID())

            local playerCount = 0

            for _, players in pairs(chars) do
                playerCount = playerCount + 1

                if players:isInEvent() and players:getID() ~= player:getID() then
                    players:release()
                end

                players:timer(1500, function(char)
                    char:startEvent(95)
                end)
            end

            instance:setLocalVar('[Nyzul]PlayerCount', playerCount)
        else
            player:messageSpecial(ID.text.INSUFFICIENT_TOKENS)
            instance:setLocalVar('runeHandler', 0)
        end
    else
        instance:setLocalVar('runeHandler', 0)
    end
end

-----------------------------------
-- Handle floor Rune of Transfer
-----------------------------------
