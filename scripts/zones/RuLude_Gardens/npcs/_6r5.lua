-----------------------------------
-- Area: Ru'Lude Gardens
-- Door: San d'Orian Emb.
-- San d'Oria Missions 3.3 "Appointment to Jeuno" and 4.1 "Magicite"
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getNation() == xi.nation.SANDORIA and
        player:getRank(pNation) >= 4
    then
        player:messageSpecial(ID.text.RESTRICTED)
    else
        player:messageSpecial(ID.text.RESTRICTED + 1) -- you have no letter of introduction
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
