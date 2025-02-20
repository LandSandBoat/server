-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Varchet
-- !pos 116.484 -1 91.554 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

local gameWon  = 0
local gameLost = 2
local gameTie  = 3

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, { { 'gil', 5 } }) then
        player:confirmTrade()

        local vdie1 = math.random(1, 6)
        local vdie2 = math.random(1, 6)
        local vtotal = vdie1 + vdie2
        local pdie1 = math.random(1, 6)
        local pdie2 = math.random(1, 6)
        local ptotal = pdie1 + pdie2

        local result = gameLost
        if ptotal > vtotal then
            result = gameWon
        elseif ptotal == vtotal then
            result = gameTie
        end

        player:setLocalVar('VarchetGame', result)
        player:startEvent(519, vdie1, vdie2, vtotal, pdie1, pdie2, ptotal, result)
    else
        player:startEvent(608)
    end
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.EXIT_THE_GAMBLER) == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(638)
    else
        player:startEvent(525)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 519 then
        local result = player:getLocalVar('VarchetGame')
        if result == gameWon then
            npcUtil.giveCurrency(player, 'gil', 10)

            local eventTarget = player:getEventTarget()
            if
                eventTarget and
                player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.EXIT_THE_GAMBLER) == xi.questStatus.QUEST_ACCEPTED
            then
                player:setCharVar('exitTheGamblerStat', 1)
                player:showText(eventTarget, ID.text.VARCHET_KEEP_PROMISE)
            end
        elseif result == gameTie then
            npcUtil.giveCurrency(player, 'gil', 5)
        else
            player:messageSpecial(ID.text.VARCHET_BET_LOST)
        end

        player:setLocalVar('VarchetGame', 0)
    end
end

return entity
