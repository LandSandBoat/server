-----------------------------------
-- Area: West Sarutabaruta
--  NPC: Ipupu
-- Note: Involved in Quest "Glyph Hanger"
-- !pos 251.745 -5.5 35.539 115
-----------------------------------
local ID = require("scripts/zones/West_Sarutabaruta/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.NOTES_FROM_HARIGAORIGA) then
        player:startEvent(47, 0, tpz.ki.NOTES_FROM_HARIGAORIGA)
    else
        player:showText(npc, ID.text.IPUPU_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 47 then
        player:delKeyItem(tpz.ki.NOTES_FROM_HARIGAORIGA)
        player:addKeyItem(tpz.ki.NOTES_FROM_IPUPU)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.NOTES_FROM_IPUPU)
    end
end
