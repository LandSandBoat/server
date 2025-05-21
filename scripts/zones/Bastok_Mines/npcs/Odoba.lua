-----------------------------------
-- Area: Bastok Mines
--  NPC: Odoba
-- Guild Merchant NPC: Alchemy Guild
-- !pos 108.473 5.017 1.089 234
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local guildSkillId = xi.skill.ALCHEMY
    xi.shop.generalGuild(player, xi.shop.generalGuildStock[guildSkillId], guildSkillId)
    player:showText(npc, zones[xi.zone.BASTOK_MINES].text.ODOBA_SHOP_DIALOG)
end

return entity
