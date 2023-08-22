-----------------------------------
-- Area: Bastok Markets
--  NPC: Teerth
--  Guild Merchant NPC: Goldsmithing Guild
-- !pos -205.190 -7.814 -56.507 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local guildSkillId = xi.skill.GOLDSMITHING
    local stock = xi.shop.generalGuildStock[guildSkillId]
    xi.shop.generalGuild(player, stock, guildSkillId)
    player:showText(npc, ID.text.TEERTH_SHOP_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
