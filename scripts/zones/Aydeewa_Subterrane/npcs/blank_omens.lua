-----------------------------------
-- Area: Aydeewa Subterrane
--  NPC: Blank (Omens Quest)
-- !pos 342.129 36.509 -24.856 68
-----------------------------------
require("scripts/globals/keyitems");
local ID = require("scripts/zones/Aydeewa_Subterrane/IDs");
-----------------------------------

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    if player:getCharVar("OmensProgress") == 4 then
        player:startEvent(9)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 9 then
        player:setCharVar("OmensProgress",5)
    end
end