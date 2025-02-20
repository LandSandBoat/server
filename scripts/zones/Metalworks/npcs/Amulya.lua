-----------------------------------
-- Area: Metalworks
--  NPC: Amulya
-- Type: Guild Merchant (Blacksmithing Guild)
-- !pos -106.093 0.999 -24.564 237
-----------------------------------
local ID = zones[xi.zone.METALWORKS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(5332, 8, 23, 2) then
        player:showText(npc, ID.text.AMULYA_SHOP_DIALOG)
    end
end

return entity
