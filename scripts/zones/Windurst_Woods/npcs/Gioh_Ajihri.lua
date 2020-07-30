-----------------------------------
-- Area: Windurst Woods
--  NPC: Gioh Ajihri
-- Starts & Finishes Repeatable Quest: Twinstone Bonding
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getCharVar("GiohAijhriSpokenTo") == 1 and not player:needToZone() and npcUtil.tradeHas(trade, 13360) then
        player:startEvent(490)
    end
end

function onTrigger(player, npc)
    local twinstoneBonding = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.TWINSTONE_BONDING)

    if twinstoneBonding == QUEST_COMPLETED then
        if player:needToZone() then
            player:startEvent(491, 0, 13360)
        else
            player:startEvent(488, 0, 13360)
        end
    elseif twinstoneBonding == QUEST_ACCEPTED then
        player:startEvent(488, 0, 13360)
    elseif twinstoneBonding == QUEST_AVAILABLE and player:getFameLevel(WINDURST) >= 2 then
        player:startEvent(487, 0, 13360)
    else
        player:startEvent(424)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 487 then
        player:addQuest(WINDURST, tpz.quest.id.windurst.TWINSTONE_BONDING)
        player:setCharVar("GiohAijhriSpokenTo", 1)
    elseif csid == 490 then
        player:confirmTrade()
        player:needToZone(true)
        player:setCharVar("GiohAijhriSpokenTo", 0)

        if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.TWINSTONE_BONDING) == QUEST_ACCEPTED then
            npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.TWINSTONE_BONDING, {item=17154, fame=80, title=tpz.title.BOND_FIXER})
        else
            player:addFame(WINDURST, 10)
            player:addGil(GIL_RATE*900)
            player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*900)
        end
    elseif csid == 488 then
        player:setCharVar("GiohAijhriSpokenTo", 1)
    end
end
