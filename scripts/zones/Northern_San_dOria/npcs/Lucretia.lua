-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Lucretia
--  Guild Merchant NPC: Blacksmithing Guild
-- !pos -193.729 3.999 159.412 231
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local guildSkillId = xi.skill.SMITHING
    local stock = xi.shop.generalGuildStock[guildSkillId]
    xi.shop.generalGuild(player, stock, guildSkillId)
    player:showText(npc, ID.text.LUCRETIA_SHOP_DIALOG)
end

return entity
