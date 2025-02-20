-----------------------------------
-- Area: Bastok Markets
--  NPC: Teerth
--  Guild Merchant NPC: Goldsmithing Guild
-- !pos -205.190 -7.814 -56.507 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local guildSkillId = xi.skill.GOLDSMITHING
    local stock = xi.shop.generalGuildStock[guildSkillId]
    xi.shop.generalGuild(player, stock, guildSkillId)
    player:showText(npc, ID.text.TEERTH_SHOP_DIALOG)
end

return entity
