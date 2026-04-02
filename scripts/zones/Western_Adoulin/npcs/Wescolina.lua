-----------------------------------
-- Area: Western Adoulin (256)
--  NPC: Wescolina
-- Type: GEO AF Commission NPC
-- !pos 30.267 -0.750 33.987 256
-- Sells Geomancy armor pieces for Bayld after completing
-- For Whom the Bell Tolls (GEO AF Quest 3)
-----------------------------------
---@type TNpcEntity
local entity = {}

local commissions =
{
    { item = xi.item.GEOMANCY_GALERO,  cost = 12500, name = 'Geomancy Galero (Head)',   tradeItem = xi.item.FIRE_CRYSTAL },
    { item = xi.item.GEOMANCY_TUNIC,   cost = 15000, name = 'Geomancy Tunic (Body)',    tradeItem = xi.item.ICE_CRYSTAL },
    { item = xi.item.GEOMANCY_SANDALS, cost = 10000, name = 'Geomancy Sandals (Feet)',  tradeItem = xi.item.WIND_CRYSTAL },
}

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.FOR_WHOM_THE_BELL_TOLLS) ~= xi.questStatus.QUEST_COMPLETED then
        player:printToPlayer('Wescolina: I craft geomancy equipment, but only for proven geomancers.', xi.msg.channel.NS_SAY)
        return
    end

    local bayld = player:getCurrency('bayld')
    player:printToPlayer('Wescolina: I can craft Geomancy armor. Trade a crystal to select:', xi.msg.channel.NS_SAY)
    player:printToPlayer('  Fire Crystal  -> Geomancy Galero (Head) - 12,500 Bayld', xi.msg.channel.NS_SAY)
    player:printToPlayer('  Ice Crystal   -> Geomancy Tunic (Body) - 15,000 Bayld', xi.msg.channel.NS_SAY)
    player:printToPlayer('  Wind Crystal  -> Geomancy Sandals (Feet) - 10,000 Bayld', xi.msg.channel.NS_SAY)
    player:printToPlayer('Your Bayld: ' .. bayld, xi.msg.channel.NS_SAY)
end

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.FOR_WHOM_THE_BELL_TOLLS) ~= xi.questStatus.QUEST_COMPLETED then
        return
    end

    for _, commission in ipairs(commissions) do
        if npcUtil.tradeHasExactly(trade, { commission.tradeItem }) then
            local bayld = player:getCurrency('bayld')
            if bayld >= commission.cost then
                if npcUtil.giveItem(player, commission.item) then
                    player:confirmTrade()
                    player:setCurrency('bayld', bayld - commission.cost)
                    player:printToPlayer('Wescolina: Here is your ' .. commission.name .. '!', xi.msg.channel.NS_SAY)
                end
            else
                player:printToPlayer('Wescolina: You need ' .. commission.cost .. ' Bayld. You only have ' .. bayld .. '.', xi.msg.channel.NS_SAY)
            end

            return
        end
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
