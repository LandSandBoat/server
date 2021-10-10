-----------------------------------
-- Area: Ru'Lude Gardens
-- Door: Bastokan Emb.
-- Bastok Missions 3.3 "Jeuno" and 4.1 "Magicite"
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()

    if pNation == xi.nation.BASTOK then
        if player:getRank(pNation) >= 4 then
            player:messageSpecial(ID.text.RESTRICTED)
        else
            player:messageSpecial(ID.text.RESTRICTED + 1) -- you have no letter of introduction
        end
    else
        player:messageSpecial(ID.text.RESTRICTED + 1) -- you have no letter of introduction
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
