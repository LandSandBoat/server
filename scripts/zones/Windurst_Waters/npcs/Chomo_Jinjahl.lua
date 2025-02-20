-----------------------------------
-- Area: Windurst Waters
--  NPC: Chomo Jinjahl
-- Guild Merchant NPC: Cooking Guild
-- !pos -105.094 -2.222 73.791 238
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local guildSkillId = xi.skill.COOKING
    local stock = xi.shop.generalGuildStock[guildSkillId]
    xi.shop.generalGuild(player, stock, guildSkillId)
    player:showText(npc, ID.text.CHOMOJINJAHL_SHOP_DIALOG)
end

return entity
