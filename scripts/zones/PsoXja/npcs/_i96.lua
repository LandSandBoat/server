-----------------------------------
-- Area: Pso'Xja
--  NPC: _i96 (Stone Gate)
-- Notes: Red Bracelet Door
-- !pos -310.000 -1.925 -238.399 9
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local Z=player:getZPos()

    if (Z >= -238) then
        if (player:hasKeyItem(tpz.ki.GREEN_BRACELET) == true) then -- Green Bracelet
            player:startEvent(62)
        else
            player:messageSpecial(ID.text.ARCH_GLOW_GREEN)
        end
    elseif (Z <= -239) then
        player:messageSpecial(ID.text.CANNOT_OPEN_SIDE)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
