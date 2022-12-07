-----------------------------------
-- Area: Norg
--  NPC: Repat
-- Type: Lucky Roll Gambler
-- !pos -15.29 1.09 146.00 252
-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
require("scripts/globals/npc_util")
-----------------------------------

local entity = {}

entity.onSpawn = function(npc)
    npc:setLocalVar("[LuckyRoll]Norg", math.random (150, 250)) -- ~observed range from retail
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local gil = player:getGil()
    local playCheck = player:getCharVar("[LuckyRoll]Played")
    local winCheck = npc:getLocalVar("[LuckyRoll]NorgLastWon")

    if playCheck ~= VanadielUniqueDay() and winCheck ~= VanadielUniqueDay() then
        player:startEvent(174, gil)
    else
        player:showText(npc, ID.text.LUCKY_ROLL_GAMEOVER)
    end

end

entity.onEventUpdate = function(player, csid, option)
    if csid == 174 and option == 0 then

        local npc = GetNPCByID(ID.npc.REPAT)
        local currentTotal = npc:getLocalVar("[LuckyRoll]Norg")
        local roll = math.random(1, 6)
        local newTotal = currentTotal + roll

        player:updateEvent(4, roll, 0, newTotal)
        npc:setLocalVar("[LuckyRoll]Norg", newTotal)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 174 and option == 0 then
        local npc = GetNPCByID(ID.npc.REPAT)
        local newTotal = npc:getLocalVar("[LuckyRoll]Norg")

        if newTotal >= 400 then

            if newTotal == 400 then
                player:showText(npc, ID.text.LUCKY_ROLL_EXACT)
                npcUtil.giveItem(player, math.random(4104, 4111))
            elseif (newTotal == 401 or newTotal == 402) then
                player:showText(npc, ID.text.LUCKY_ROLL_CLOSE)
                npcUtil.giveItem(player, math.random(769, 776))
            end

            npc:setLocalVar("[LuckyRoll]Norg", math.random(150, 250))  -- observed range from retail
            npc:setLocalVar("[LuckyRoll]NorgLastWon", VanadielUniqueDay())
            player:addGil(10000)
        end

        player:delGil(100)
        player:setCharVar("[LuckyRoll]Played", VanadielUniqueDay())
    end
end

return entity
