-----------------------------------
-- Area: Ru'Lude Gardens
-- Door: Windurstian Ambassador
-- Windurst Missions 3.3 "A New Journey" and 4.1 "Magicite"
-- !pos 31 9 -22 243
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/zone")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getNation() == xi.nation.WINDURST and
        player:getRank(xi.nation.WINDURST) >= 4
    then
        player:messageSpecial(ID.text.RESTRICTED)
    else
        player:messageSpecial(ID.text.RESTRICTED + 1)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
