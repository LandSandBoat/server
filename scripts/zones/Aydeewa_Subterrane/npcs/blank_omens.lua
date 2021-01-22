-----------------------------------
-- Area: Aydeewa Subterrane
--  NPC: Blank (Omens Quest)
-- !pos 342.129 36.509 -24.856 68
-----------------------------------
require("scripts/globals/keyitems");
local ID = require("scripts/zones/Aydeewa_Subterrane/IDs");
-----------------------------------
local entity = {}

entity.onTrade = function(player,npc,trade)
end

entity.onTrigger = function(player,npc)
    local omensProgress = player:getCharVar("OmensProgress")

    if
        omensProgress == 3 or
        omensProgress == 4
    then
        player:startEvent(9)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player,csid,option)
end

entity.onEventFinish = function(player,csid,option)
    if csid == 9 then
        player:setCharVar("OmensProgress",5)
    end
end
return entity
