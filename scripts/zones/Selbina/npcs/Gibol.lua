-----------------------------------
-- Area: Selbina
--  NPC: Gibol
-- Guild Merchant NPC: Clothcrafting Guild
-- !pos 13.591 -7.287 8.569 248
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local guildSkillId = xi.skill.CLOTHCRAFT
    xi.shop.generalGuild(player, xi.shop.generalGuildStock[guildSkillId], guildSkillId)
    player:showText(npc, zones[xi.zone.SELBINA].text.CLOTHCRAFT_SHOP_DIALOG)
end

return entity
