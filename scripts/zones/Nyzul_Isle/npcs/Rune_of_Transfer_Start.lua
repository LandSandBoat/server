-----------------------------------
-- Area:  Nyzul_Isle
-- NPC:   Rune of Transfer
-- Notes: Allows players to select a floor to transport to
-- !pos -20.000 -4.000 -11.000
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/nyzul")
require("scripts/zones/Nyzul_Isle/instances/nyzul_isle_investigation")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local instance      = player:getInstance()
    local tokens        = player:getCurrency("nyzul_isle_assault_point")
    local prefered      = player:getVar("[Nyzul]preferredItems")
    local floorGroup    = math.floor(player:getVar("NyzulFloorProgress") / 5)
    local floorProgress = 0xFFFFFFFC - bit.bxor(bit.lshift(2, floorGroup + 1) - 1, 3)

    if not player:hasKeyItem(xi.ki.RUNIC_DISC) then
        player:messageSpecial(ID.text.NEW_USER, xi.ki.RUNIC_DISC)
        npcUtil.giveKeyItem(player, xi.ki.RUNIC_DISC)
    elseif instance:getLocalVar("runeHandler") ~= 0 then
        player:messageSpecial(ID.text.IN_OPERATION)

        return
    else
        instance:setLocalVar("runeHandler", player:getID())
        player:startEvent(94, xi.ki.RUNIC_DISC, tokens, 1, prefered, 100, 200, 300, floorProgress)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local instance = npc:getInstance()
    local chars    = instance:getChars()

    if
        csid == 94 and
        option > 0 and
        option < 21 and
        instance:getLocalVar("runeHandler") == player:getID()
    then
        local floorCost = xi.nyzul.floorCost[option]

        if player:getCurrency("nyzul_isle_assault_point") >= floorCost.cost then
            player:delCurrency("nyzul_isle_assault_point", floorCost.cost)
            instance:setLocalVar("Nyzul_Isle_StartingFloor", floorCost.level)
            instance:setLocalVar("Nyzul_Current_Floor", floorCost.level)
            instance:setLocalVar("diskHolder", player:getID())

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

            instance:setLocalVar("partySize", playerCount)
        else
            player:messageSpecial(ID.text.INSUFFICIENT_TOKENS)
            instance:setLocalVar("runeHandler", 0)
        end
    else
        instance:setLocalVar("runeHandler", 0)
    end
end

return entity
