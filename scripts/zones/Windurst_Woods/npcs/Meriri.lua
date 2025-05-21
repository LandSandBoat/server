-----------------------------------
-- Area: Windurst Woods
--  NPC: Meriri
-- Guild Merchant NPC: Clothcrafting Guild
-- !pos -76.471 -3.55 -128.341 241
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local guildSkillId = xi.skill.CLOTHCRAFT
    xi.shop.generalGuild(player, xi.shop.generalGuildStock[guildSkillId], guildSkillId)
    player:showText(npc, ID.text.MERIRI_DIALOG)
end

return entity
