-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Rodaillece
-- !pos -246.943 7.000 46.836 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local pickpocketMask = player:getCharVar("thePickpocketSkipNPC")

    if player:getCharVar("thePickpocket") == 1 and not utils.mask.getBit(pickpocketMask, 3) then
        player:showText(npc, ID.text.PICKPOCKET_RODAILLECE)
        player:setCharVar("thePickpocketSkipNPC", utils.mask.setBit(pickpocketMask, 3, true))
    else
        player:showText(npc, ID.text.RODAILLECE_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
