-----------------------------------
-- Area: Rabao
--  NPC: Mileon
-- Type: Lucky Roll Gambler
-- !pos 26.080 8.201 65.297 247
-----------------------------------
local ID = require("scripts/zones/Rabao/IDs")
require("scripts/globals/npc_util")
-----------------------------------

local entity = {}

entity.onSpawn = function(npc)
    npc:setLocalVar("[LuckyRoll]Rabao", math.random (150, 250)) -- ~observed range from retail
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local gil = player:getGil()
    local playCheck = player:getCharVar("[LuckyRoll]Played")
    local winCheck = npc:getLocalVar("[LuckyRoll]RabaoLastWon")

    if playCheck ~= VanadielUniqueDay() and winCheck ~= VanadielUniqueDay() then
        player:startEvent(100, gil)
    else
        player:showText(npc, ID.text.LUCKY_ROLL_GAMEOVER)
    end

end

entity.onEventUpdate = function(player, csid, option)
    if csid == 100 and option == 0 then

        local npc = GetNPCByID(ID.npc.MILEON)
        local currentTotal = npc:getLocalVar("[LuckyRoll]Rabao")
        local roll = math.random(1, 6)
        local newTotal = currentTotal + roll

        player:updateEvent(4, roll, 0, newTotal)
        npc:setLocalVar("[LuckyRoll]Rabao", newTotal)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 100 and option == 0 then
        local npc = GetNPCByID(ID.npc.MILEON)
        local newTotal = npc:getLocalVar("[LuckyRoll]Rabao")

        if newTotal >= 400 then

            if newTotal == 400 then
                player:showText(npc, ID.text.LUCKY_ROLL_EXACT)
                npcUtil.giveItem(player, math.random(4104, 4111))
            elseif (newTotal == 401 or newTotal == 402) then
                player:showText(npc, ID.text.LUCKY_ROLL_CLOSE)
                npcUtil.giveItem(player, math.random(769, 776))
            end

            npc:setLocalVar("[LuckyRoll]Rabao", math.random(150, 250))
            npc:setLocalVar("[LuckyRoll]RabaoLastWon", VanadielUniqueDay())
            player:addGil(10000)
        end

        player:delGil(100)
        player:setCharVar("[LuckyRoll]Played", VanadielUniqueDay())
    end
end

return entity
