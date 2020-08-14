-----------------------------------
-- Area: Maze of Shakhrami
--  NPC: Excavation Point
-- Used in Quest: The Holy Crest
-- !pos 234 0.1 -110 198
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/helm")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getCharVar("TheHolyCrest_Event") == 3 and not player:hasItem(1159) and npcUtil.tradeHas(trade, 605) then
        if npcUtil.giveItem(player, 1159) then -- Wyvern Egg
            player:confirmTrade()
        end
    else
        tpz.helm.onTrade(player, npc, trade, tpz.helm.type.EXCAVATION, 60)
    end

end

function onTrigger(player, npc)
    tpz.helm.onTrigger(player, tpz.helm.type.EXCAVATION)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
