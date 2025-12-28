-----------------------------------
-- Area: Windurst Woods
--  NPC: Retto-Marutto
-- Guild Merchant NPC: Bonecrafting Guild
-- !pos -6.142 -6.55 -132.639 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local guildSkillId = xi.skill.BONECRAFT
    xi.shop.generalGuild(player, xi.shop.generalGuildStock[guildSkillId], guildSkillId)
    player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.RETTO_MARUTTO_DIALOG)
end

return entity
