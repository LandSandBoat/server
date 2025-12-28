-----------------------------------
-- Area: Mhaura
--  NPC: Mololo
-- Guild Merchant NPC: Blacksmithing Guild
-- !pos -64.278 -16.624 34.120 249
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local guildSkillId = xi.skill.SMITHING
    xi.shop.generalGuild(player, xi.shop.generalGuildStock[guildSkillId], guildSkillId)
    player:showText(npc, zones[xi.zone.MHAURA].text.SMITHING_GUILD)
end

return entity
