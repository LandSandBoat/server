-----------------------------------
-- Area: Provenance
--  NPC: Grumblix
-- Custom: Goblin Mafia NPC
-----------------------------------
require('modules/custom/lua/gobhook')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local mafiaPoints = player:getCurrency('legion_point')
    local mafianmDate = player:getVar('mafianmdate')
    local mafianmIntro = player:getVar('mafianms_intro')

    -- Initialise wanted item if not set
    local saleIndex = GetServerVariable('MafiaWantedItem')
    if saleIndex == 0 then
        saleIndex = math.random(1, #xi.mafia.grumEndItem)
        SetServerVariable('MafiaWantedItem', saleIndex)
    end

    local currentSaleItem = xi.mafia.grumEndItem[saleIndex]

    -- ========================================
    -- OLD SUPPLY TRADING SYSTEM
    -- ========================================
    -- local penalty1 = xi.mafia.grumItems[GetServerVariable('Sale1')].amount - (xi.mafia.grumItems[GetServerVariable('Sale1')].divisor * GetServerVariable('Sale1Streak'))
    -- local itempayout1 = math.max(penalty1, xi.mafia.grumItems[GetServerVariable('Sale1')].min)
    -- local penalty2 = xi.mafia.grumItems[GetServerVariable('Sale2')].amount - (xi.mafia.grumItems[GetServerVariable('Sale2')].divisor * GetServerVariable('Sale2Streak'))
    -- local itempayout2 = math.max(penalty2, xi.mafia.grumItems[GetServerVariable('Sale2')].min)
    -- local penalty3 = xi.mafia.grumItems[GetServerVariable('Sale3')].amount - (xi.mafia.grumItems[GetServerVariable('Sale3')].divisor * GetServerVariable('Sale3Streak'))
    -- local itempayout3 = math.max(penalty3, xi.mafia.grumItems[GetServerVariable('Sale3')].min)

    -- Trade Sale1 item for gil
    -- if npcUtil.tradeHasExactly(trade, { { xi.mafia.grumItems[GetServerVariable('Sale1')].itemid, xi.mafia.grumItems[GetServerVariable('Sale1')].qnt } }) then
    --     player:confirmTrade()
    --     npcUtil.giveCurrency(player, 'gil', itempayout1)
    --     player:printToPlayer(string.format('Heres %s Gil for your assistance.', itempayout1), xi.msg.channel.SAY, 'Grumblix')
    --     if GetServerVariable('Sale1Streak') >= 20 then
    --         SetServerVariable('Sale1', math.random(1, #xi.mafia.grumItems))
    --         SetServerVariable('Sale1Streak', 0)
    --     else
    --         SetServerVariable('Sale1Streak', GetServerVariable('Sale1Streak') + 1)
    --     end

    -- Trade Sale2 item for gil
    -- elseif npcUtil.tradeHasExactly(trade, { { xi.mafia.grumItems[GetServerVariable('Sale2')].itemid, xi.mafia.grumItems[GetServerVariable('Sale2')].qnt } }) then
    --     player:confirmTrade()
    --     npcUtil.giveCurrency(player, 'gil', itempayout2)
    --     player:printToPlayer(string.format('Heres %s Gil for your assistance.', itempayout2), xi.msg.channel.SAY, 'Grumblix')
    --     if GetServerVariable('Sale2Streak') >= 20 then
    --         SetServerVariable('Sale2', math.random(1, #xi.mafia.grumItems))
    --         SetServerVariable('Sale2Streak', 0)
    --     else
    --         SetServerVariable('Sale2Streak', GetServerVariable('Sale2Streak') + 1)
    --     end

    -- Trade Sale3 item for gil
    -- elseif npcUtil.tradeHasExactly(trade, { { xi.mafia.grumItems[GetServerVariable('Sale3')].itemid, xi.mafia.grumItems[GetServerVariable('Sale3')].qnt } }) then
    --     player:confirmTrade()
    --     npcUtil.giveCurrency(player, 'gil', itempayout3)
    --     player:printToPlayer(string.format('Heres %s Gil for your assistance.', itempayout3), xi.msg.channel.SAY, 'Grumblix')
    --     if GetServerVariable('Sale3Streak') >= 20 then
    --         SetServerVariable('Sale3', math.random(1, #xi.mafia.grumItems))
    --         SetServerVariable('Sale3Streak', 0)
    --     else
    --         SetServerVariable('Sale3Streak', GetServerVariable('Sale3Streak') + 1)
    --     end
    -- ========================================
    -- END OLD SUPPLY TRADING SYSTEM
    -- ========================================

    -- Bribe to change desired item (50k gil)
    if npcUtil.tradeHasExactly(trade, { { xi.item.GIL, 50000 } }) then
        player:confirmTrade()
        player:printToPlayer('I guess since you\'re bribing me I can bend my desires...', xi.msg.channel.SAY, 'Grumblix')
        SetServerVariable('MafiaWantedItem', math.random(1, #xi.mafia.grumEndItem))

    -- Trade Goblin Offering for 3k points
    elseif npcUtil.tradeHasExactly(trade, { { xi.item.GOBLIN_OFFERING, 1 } }) then
        player:confirmTrade()
        player:printToPlayer('Ooohh... very nice. Thank you for bringing this to me. Here\'s something for you.', xi.msg.channel.SAY, 'Grumblix')
        player:addCurrency('legion_point', 3000)
        player:printToPlayer('Your Mafia reputation has gone up by 3000 points!', xi.msg.channel.SAY, 'Grumblix')

    -- Trade current desired item for mafia points
    elseif currentSaleItem and
        npcUtil.tradeHasExactly(trade, { { currentSaleItem.item, currentSaleItem.qnt } })
    then
        player:confirmTrade()
        player:addCurrency('legion_point', currentSaleItem.points)
        player:printToPlayer(string.format('Your Mafia reputation has gone up by %s points!', currentSaleItem.points), xi.msg.channel.SAY, 'Grumblix')
        -- Randomize to a new item after successful trade
        SetServerVariable('MafiaWantedItem', math.random(1, #xi.mafia.grumEndItem))

    -- Buy NM hunt info (10 gil + 3000 mafia points, weekly reset)
    elseif npcUtil.tradeHasExactly(trade, { { xi.item.GIL, 10 } }) then
        if mafianmIntro == 0 then
            player:printToPlayer('I don\'t have anything like that available for you yet', xi.msg.channel.SAY, 'Grumblix')
            return
        end

        if mafiaPoints < 3000 then
            player:printToPlayer('You don\'t have enough Mafia points for that. Come back when you have at least 3000.', xi.msg.channel.SAY, 'Grumblix')
            return
        end

        if mafianmDate > GetSystemTime() then
            player:printToPlayer('I don\'t have any new info on any marks yet. Come back later.', xi.msg.channel.SAY, 'Grumblix')
            return
        end

        player:confirmTrade()
        player:printToPlayer('Okay, so this guy is a good looking mark. Good stuffs, but he hides out in weird spots.', xi.msg.channel.SAY, 'Grumblix')
        player:printToPlayer('The info I got says... \'dark maze-like cavern... out of place door\' and they told me to use this to draw him out.', xi.msg.channel.SAY, 'Grumblix')
        player:printToPlayer('Be sure to bring friends and be ready for anything!', xi.msg.channel.SAY, 'Grumblix')

        npcUtil.giveKeyItem(player, xi.ki.MARBLED_MUTTON_CHOP)
        player:setVar('mafianmdate', GetSystemTime() + 604800) -- 1 week cooldown
        player:delCurrency('legion_point', 3000)
    end
end

entity.onTrigger = function(player, npc)
    local gobQuest = player:getVar('gobquest')
    local mafianmIntro = player:getVar('mafianms_intro')
    local ghookedCount = player:getVar('ghooked')

    -- Initialize wanted item if not set
    local saleIndex = GetServerVariable('MafiaWantedItem')
    if saleIndex == 0 then
        saleIndex = math.random(1, #xi.mafia.grumEndItem)
        SetServerVariable('MafiaWantedItem', saleIndex)
    end

    local currentSaleItem = xi.mafia.grumEndItem[saleIndex]

    -- ========================================
    -- OLD SUPPLY TRADING DIALOGUE
    -- ========================================
    -- local item1 = xi.mafia.grumItems[GetServerVariable('Sale1')]
    -- local item2 = xi.mafia.grumItems[GetServerVariable('Sale2')]
    -- local item3 = xi.mafia.grumItems[GetServerVariable('Sale3')]
    -- player:printToPlayer('The Mafia needs supplies and is willing to compensate you for your work. Currently we are looking for:', xi.msg.channel.SAY, 'Grumblix')
    -- player:printToPlayer(string.format('%s starting payout: %s in the amount of %s', item1.itemname, item1.amount, item1.qnt), xi.msg.channel.SAY, 'Grumblix')
    -- player:printToPlayer(string.format('%s starting payout: %s in the amount of %s', item2.itemname, item2.amount, item2.qnt), xi.msg.channel.SAY, 'Grumblix')
    -- player:printToPlayer(string.format('%s starting payout: %s in the amount of %s', item3.itemname, item3.amount, item3.qnt), xi.msg.channel.SAY, 'Grumblix')
    -- player:printToPlayer('Every turn-in drives the value of said item down until we dont need it anymore', xi.msg.channel.SAY, 'Grumblix')
    -- ========================================
    -- END OLD SUPPLY TRADING DIALOGUE
    -- ========================================

    -- First time interaction
    if gobQuest == 0 then
        player:setVar('gobquest', 1)
        player:printToPlayer('You are now involved in the Goblin Mafia! Find Goblin Footprints around the world to learn where our stashing points are.', xi.msg.channel.SAY, 'Grumblix')
        return
    end

    -- Unlock NM hunt system after finding 10+ footprints
    if mafianmIntro == 0 and ghookedCount >= 10 then
        player:printToPlayer('Hey buddy, you\'ve been representing the Goblin Mafia well. To show you our appreciation, I\'m gonna cut you in.', xi.msg.channel.SAY, 'Grumblix')
        player:printToPlayer('Every week or so, we get information on some marks with some great stuff on them.', xi.msg.channel.SAY, 'Grumblix')
        player:printToPlayer('Just trade me some gil and cash in some Mafia points and I\'ll give you the info.', xi.msg.channel.SAY, 'Grumblix')
        player:printToPlayer('I guess you could check the Era Wiki for Mafia NMs. Whatever a wiki is.', xi.msg.channel.SAY, 'Grumblix')
        player:setVar('mafianms_intro', 1)
        return
    end

    -- Display current wanted item
    if currentSaleItem then
        local mafiaPoints = player:getCurrency('legion_point')
        player:printToPlayer(string.format('Your current Mafia balance: %s points', mafiaPoints), xi.msg.channel.SAY, 'Grumblix')
        player:printToPlayer(string.format('I\'m looking for %s x%s. I can give you %s Mafia points for it.', currentSaleItem.itemname, currentSaleItem.qnt, currentSaleItem.points), xi.msg.channel.SAY, 'Grumblix')
    else
        player:printToPlayer('I\'m not looking for anything specific right now. Check back later!', xi.msg.channel.SAY, 'Grumblix')
    end
end

return entity
