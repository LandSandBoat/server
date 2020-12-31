-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Varchet
-- !pos 116.484 -1 91.554 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

local GAME_WON  = 0
local GAME_LOST = 2
local GAME_TIE  = 3

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, {{"gil", 5}}) then
        player:confirmTrade()

        local vdie1 = math.random(1, 6)
        local vdie2 = math.random(1, 6)
        local vtotal = vdie1 + vdie2
        local pdie1 = math.random(1, 6)
        local pdie2 = math.random(1, 6)
        local ptotal = pdie1 + pdie2

        local result = GAME_LOST
        if ptotal > vtotal then
            result = GAME_WON
        elseif ptotal == vtotal then
            result = GAME_TIE
        end
        player:setLocalVar('VarchetGame', result)
        player:startEvent(519, vdie1, vdie2, vtotal, pdie1, pdie2, ptotal, result)
    else
        player:startEvent(608)
    end
end

function onTrigger(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.EXIT_THE_GAMBLER) == QUEST_ACCEPTED then
        player:startEvent(638)
    else
        player:startEvent(525)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 519 then
        local result = player:getLocalVar('VarchetGame')
        if result == GAME_WON then
            local gilPayout = 10
            player:addGil(gilPayout)
            player:messageSpecial(ID.text.GIL_OBTAINED, gilPayout)

            if player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.EXIT_THE_GAMBLER) == QUEST_ACCEPTED then
                player:setCharVar("exitTheGamblerStat", 1)
                player:showText(player:getEventTarget(), ID.text.VARCHET_KEEP_PROMISE)
            end
        elseif result == GAME_TIE then
            local gilPayout = 5
            player:addGil(gilPayout)
            player:messageSpecial(ID.text.GIL_OBTAINED, gilPayout)
        else
            player:messageSpecial(ID.text.VARCHET_BET_LOST)
        end
        player:setLocalVar('VarchetGame', 0)
    end
end
