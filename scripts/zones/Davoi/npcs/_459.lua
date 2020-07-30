-----------------------------------
-- Area: Davoi
--  NPC: Wall of Dark Arts
-- Involved in Mission: Magicite
-- !pos -22 1 -66 149
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:hasKeyItem(tpz.ki.CREST_OF_DAVOI_KI)) then
        player:startEvent(54)
    else
        player:startEvent(55)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
