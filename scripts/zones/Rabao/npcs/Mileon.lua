-----------------------------------
-- Area: Rabao
--  NPC: Mileon
-- Type: Lucky Roll Gambler
-- !pos 26.080 8.201 65.297 247
-----------------------------------
local ID = zones[xi.zone.RABAO]
-----------------------------------
---@type TNpcEntity
local entity = {}

local exactRewards =
{
    xi.item.RED_ROCK,
    xi.item.BLUE_ROCK,
    xi.item.YELLOW_ROCK,
    xi.item.GREEN_ROCK,
    xi.item.TRANSLUCENT_ROCK,
    xi.item.PURPLE_ROCK,
    xi.item.BLACK_ROCK,
    xi.item.WHITE_ROCK,
}

local closeRewards =
{
    xi.item.FIRE_CLUSTER,
    xi.item.ICE_CLUSTER,
    xi.item.WIND_CLUSTER,
    xi.item.EARTH_CLUSTER,
    xi.item.LIGHTNING_CLUSTER,
    xi.item.WATER_CLUSTER,
    xi.item.LIGHT_CLUSTER,
    xi.item.DARK_CLUSTER
}

entity.onSpawn = function(npc)
    npc:setLocalVar('[LuckyRoll]Rabao', math.random (150, 250)) -- ~observed range from retail
end

entity.onTrigger = function(player, npc)
    local gil = player:getGil()
    local playCheck = player:getCharVar('[LuckyRoll]Played')
    local winCheck = npc:getLocalVar('[LuckyRoll]RabaoLastWon')

    if playCheck ~= VanadielUniqueDay() and winCheck ~= VanadielUniqueDay() then
        player:startEvent(100, gil)
    else
        player:showText(npc, ID.text.LUCKY_ROLL_GAMEOVER)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    local gil = player:getGil()
    local playCheck = player:getCharVar('[LuckyRoll]Played')
    local winCheck = npc:getLocalVar('[LuckyRoll]RabaoLastWon')

    if playCheck ~= VanadielUniqueDay() and winCheck ~= VanadielUniqueDay() then
        if csid == 100 and option == 0 and gil >= 100 then

            local currentTotal = npc:getLocalVar('[LuckyRoll]Rabao')
            local roll = math.random(1, 6)
            local newTotal = currentTotal + roll

            player:updateEvent(4, roll, 0, newTotal)
            npc:setLocalVar('[LuckyRoll]Rabao', newTotal)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local gil = player:getGil()
    local playCheck = player:getCharVar('[LuckyRoll]Played')
    local winCheck = npc:getLocalVar('[LuckyRoll]RabaoLastWon')

    if playCheck ~= VanadielUniqueDay() and winCheck ~= VanadielUniqueDay() then
        if csid == 100 and option == 0 and gil >= 100 then
            local newTotal = npc:getLocalVar('[LuckyRoll]Rabao')

            if newTotal >= 400 then
                if newTotal == 400 then
                    player:showText(npc, ID.text.LUCKY_ROLL_EXACT)
                    npcUtil.giveItem(player, utils.randomEntry(exactRewards))
                elseif newTotal <= 402 then
                    player:showText(npc, ID.text.LUCKY_ROLL_CLOSE)
                    npcUtil.giveItem(player, utils.randomEntry(closeRewards))
                end

                npc:setLocalVar('[LuckyRoll]Rabao', math.random(150, 250))
                npc:setLocalVar('[LuckyRoll]RabaoLastWon', VanadielUniqueDay())
                player:addGil(10000)
            end

            player:delGil(100)
            player:setCharVar('[LuckyRoll]Played', VanadielUniqueDay())
        end
    end
end

return entity
