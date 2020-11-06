-----------------------------------
-- Area: Phanauet Channel
--  NPC: Riche
-- Type: Standard NPC
-- !pos 5.945 -3.75 13.612 1
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.keyItem.TONBERRY_BLACKBOARD) then
        player:startEvent(5, 1, 627, 1682, 63, 3, 30, 30, 0)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 5 then
        player:delKeyItem(tpz.keyItem.TONBERRY_BLACKBOARD) -- No message as the cutscene ends with the NPC taking it
        player:setCharVar('TEA_WITH_A_TONBERRY_PROG', 3)
    end
end
