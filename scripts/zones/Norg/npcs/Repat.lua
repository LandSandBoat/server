-----------------------------------
-- Area: Norg
--  NPC: Repat
-- Type: Lucky Roll Gambler
-- !pos -15.29 1.09 146.00 252
-----------------------------------
local ID = zones[xi.zone.NORG]
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
    npc:setLocalVar('[LuckyRoll]Norg', math.random (150, 250)) -- ~observed range from retail
end

entity.onTrigger = function(player, npc)
    local gil = player:getGil()
    local playCheck = player:getCharVar('[LuckyRoll]Played')
    local winCheck = npc:getLocalVar('[LuckyRoll]NorgLastWon')

    if playCheck ~= VanadielUniqueDay() and winCheck ~= VanadielUniqueDay() then
        player:startEvent(174, gil)
    else
        player:showText(npc, ID.text.LUCKY_ROLL_GAMEOVER)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    local gil = player:getGil()
    local playCheck = player:getCharVar('[LuckyRoll]Played')
    local winCheck = npc:getLocalVar('[LuckyRoll]NorgLastWon')

    if playCheck ~= VanadielUniqueDay() and winCheck ~= VanadielUniqueDay() then
        if csid == 174 and option == 0 and gil >= 100 then

            local currentTotal = npc:getLocalVar('[LuckyRoll]Norg')
            local roll = math.random(1, 6)
            local newTotal = currentTotal + roll

            player:updateEvent(4, roll, 0, newTotal)
            npc:setLocalVar('[LuckyRoll]Norg', newTotal)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local gil = player:getGil()
    local playCheck = player:getCharVar('[LuckyRoll]Played')
    local winCheck = npc:getLocalVar('[LuckyRoll]NorgLastWon')

    if playCheck ~= VanadielUniqueDay() and winCheck ~= VanadielUniqueDay() then
        if csid == 174 and option == 0 and gil >= 100 then
            local newTotal = npc:getLocalVar('[LuckyRoll]Norg')

            if newTotal >= 400 then
                if newTotal == 400 then
                    player:showText(npc, ID.text.LUCKY_ROLL_EXACT)
                    npcUtil.giveItem(player, utils.randomEntry(exactRewards))
                elseif newTotal <= 402 then
                    player:showText(npc, ID.text.LUCKY_ROLL_CLOSE)
                    npcUtil.giveItem(player, utils.randomEntry(closeRewards))
                end

                npc:setLocalVar('[LuckyRoll]Norg', math.random(150, 250))  -- observed range from retail
                npc:setLocalVar('[LuckyRoll]NorgLastWon', VanadielUniqueDay())
                player:addGil(10000)
            end

            player:delGil(100)
            player:setCharVar('[LuckyRoll]Played', VanadielUniqueDay())
        end
    end
end

return entity
