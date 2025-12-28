-----------------------------------
-- Area: Port Bastok
--  NPC: Blabbivix
-- Standard merchant, though he acts like a guild merchant
-- !pos -110.209 4.898 22.957 236
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(60418, 11, 22, 3) then
        player:showText(npc, zones[xi.zone.PORT_BASTOK].text.BLABBIVIX_SHOP_DIALOG)
    end
end

return entity
