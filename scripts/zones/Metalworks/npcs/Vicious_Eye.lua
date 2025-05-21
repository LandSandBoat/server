-----------------------------------
-- Area: Metalworks
--  NPC: Vicious Eye
-- Type: Guild Merchant (Blacksmithing Guild)
-- !pos -106.132 0.999 -28.757 237
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local guildSkillId = xi.skill.SMITHING
    xi.shop.generalGuild(player, xi.shop.generalGuildStock[guildSkillId], guildSkillId)
    player:showText(npc, zones[xi.zone.METALWORKS].text.VICIOUS_EYE_SHOP_DIALOG)
end

return entity
