-----------------------------------
-- Area: Norg
--  NPC: Fouvia
-- Type: Wyvern Name Changer
-- !pos -84.066 -6.414 47.826 252
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/pets")
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getMainJob() ~= xi.job.DRG) then
        player:showText(npc, ID.text.FOUIVA_DIALOG) -- Oi 'av naw business wi' de likes av you.
    elseif (player:getGil() < 9800) then
        player:showText(npc, ID.text.FOUIVA_DIALOG + 9) -- You don't 'av enough gil.  Come back when you do.
    else
        player:startEvent(130, 0, 0, 0, 0, 0, 0, player:getCharVar("ChangedWyvernName"))
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 130 and option ~= 1073741824) then -- Player didn't cancel out
        player:delGil(9800)
        player:setCharVar("ChangedWyvernName", 1)
        player:setPetName(xi.pet.type.WYVERN, option+1)
    end
end

return entity
