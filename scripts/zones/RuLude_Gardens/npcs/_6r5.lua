-----------------------------------
-- Area: Ru'Lude Gardens
-- Door: San d'Orian Emb.
-- San d'Oria Missions 3.3 "Appointment to Jeuno" and 4.1 "Magicite"
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local pNation = player:getNation()

    if pNation == xi.nation.SANDORIA then
        if player:getRank(player:getNation()) >= 4 then
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
