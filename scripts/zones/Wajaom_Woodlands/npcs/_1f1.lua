-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: Engraved Tablet
-- !pos -64 -11 -641 51
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:hasKeyItem(tpz.ki.SICKLEMOON_SALT)) then
        player:startEvent(514)
    else
        player:startEvent(516)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 514 and option == 1) then
        player:delKeyItem(tpz.ki.SICKLEMOON_SALT)
    end

end
