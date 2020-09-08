-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Dahjal
-- first in conquest Npc
-- !zone 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    if (FlyerForRegine == 1) then
        count = trade:getItemCount()
        MagicFlyer = trade:hasItemQty(532, 1)
        if (MagicFlyer == true and count == 1) then
            player:messageSpecial(ID.text.FLYER_REFUSED)
        end
    end

end

function onTrigger(player, npc)

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
