-----------------------------------
-- Module: Chatoyant Staff Trade
--   Area: Lower Jeuno
--    NPC: Sweepstox
-- Desc: Trade Heroism Aggregate + Moldy Staff for Chatoyant Staff.
--       Trade 50k gil + 20k Mafia Points for Moldy Staff.
-----------------------------------
require('scripts/globals/npc_util')
-----------------------------------

xi = xi or {}
xi.chatStaffTrade = xi.chatStaffTrade or {}

local moldyStaffGilCost   = 50000
local moldyStaffPointCost = 20000

local mafiaPointThresholds =
{
    { points = 20000, msg = 'Ok... Ok.. Keep it down... will ya? This stuff isn\'t for the faint of heart you know?' },
    { points = 15000, msg = 'Huh?!? What...? \'Black Market\'? ..I ..I have no idea what you\'re talking about' },
    { points = 10000, msg = 'I don\'t have anything to do with this \'Mafia\'.. I would never work for them!' },
    { points =  5000, msg = 'I haven\'t heard of any \'Mafia\'.. Now get out of my face..' },
    { points =     0, msg = 'You lost..?' },
}

local function getMafiaPoints(player)
    return player:getCurrency('Legion_point')
end

xi.chatStaffTrade.onTrade = function(player, npc, trade)
    local mafiaPoints = getMafiaPoints(player)

    -- Trade Heroism Aggregate + Moldy Staff for Chatoyant Staff
    if npcUtil.tradeHasExactly(trade, { xi.item.HEROISM_AGGREGATE, xi.item.MOLDY_STAFF }) then
        player:confirmTrade()
        player:printToPlayer('Hey, you just remember who your friends are, you hear me?', xi.msg.channel.SAY, 'Sweepstox')
        player:addItem(xi.item.CHATOYANT_STAFF)
        player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, xi.item.CHATOYANT_STAFF)

    -- Trade 50k gil + 20k Mafia Points for Moldy Staff
    elseif
        trade:getGil() == moldyStaffGilCost and
        trade:getItemCount() == 1 and
        mafiaPoints >= moldyStaffPointCost
    then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, xi.item.MOLDY_STAFF)
        else
            player:confirmTrade()
            player:delCurrency('Legion_point', moldyStaffPointCost)
            if player:addItem(xi.item.MOLDY_STAFF) then
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, xi.item.MOLDY_STAFF)
                player:printToPlayer('A deal is a deal, pleasure doing business with you.', xi.msg.channel.SAY, 'Sweepstox')
                player:queue(1000, function(p)
                    p:printToPlayer('What? It\'s just a little mold...', xi.msg.channel.SAY, 'Sweepstox')
                end)
            end
        end
    end
end

xi.chatStaffTrade.onTrigger = function(player, npc)
    local mafiaPoints = getMafiaPoints(player)

    -- Player has both items ready for the final trade
    if
        player:hasItem(xi.item.MOLDY_STAFF) and
        player:hasItem(xi.item.HEROISM_AGGREGATE)
    then
        player:printToPlayer('You actually found a Heroism Aggregate? I never thought I would ever see one of these again...', xi.msg.channel.SAY, 'Sweepstox')
        player:queue(1000, function(p)
            p:printToPlayer('Trade me both the Staff and the Aggregate, I\'ll make it worth your while!', xi.msg.channel.SAY, 'Sweepstox')
        end)

    -- Player has the Moldy Staff but still needs the Aggregate
    elseif player:hasItem(xi.item.MOLDY_STAFF) then
        player:printToPlayer('Whew...I can smell that moldy staff from here...', xi.msg.channel.SAY, 'Sweepstox')
        player:queue(1000, function(p)
            p:printToPlayer('Find me a Heroism Aggregate, I could fix it right up for you!', xi.msg.channel.SAY, 'Sweepstox')
        end)

    -- Mafia point-based dialogue
    elseif mafiaPoints >= moldyStaffPointCost then
        player:printToPlayer('Ok... Ok.. Keep it down... will ya? This stuff isn\'t for the faint of heart you know?', xi.msg.channel.SAY, 'Sweepstox')
        player:queue(1000, function(p)
            p:printToPlayer('I\'ve been watching you. Behind the scenes. I know you\'ve got enough mafia points to make me just a little more famous around here...', xi.msg.channel.SAY, 'Sweepstox')
        end)

        player:queue(2000, function(p)
            p:printToPlayer('Why don\'t we make a little \'off the books\' trade.. I happen to have a very elusive item I might be able to part ways with', xi.msg.channel.SAY, 'Sweepstox')
        end)

        player:queue(3000, function(p)
            p:printToPlayer('What do you say? 20,000 Mafia points, and of course a 50,000 gil transaction fee. You give me the gil, I\'ll take care of the rest.. heh', xi.msg.channel.SAY, 'Sweepstox')
        end)
    else
        -- Dialogue based on mafia point progress
        for _, threshold in ipairs(mafiaPointThresholds) do
            if mafiaPoints >= threshold.points then
                player:printToPlayer(threshold.msg, xi.msg.channel.SAY, 'Sweepstox')
                break
            end
        end
    end
end

return xi.chatStaffTrade
