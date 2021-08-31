-----------------------------------
-- Area: Selbina
--  NPC: Gibol
-- Guild Merchant NPC: Clothcrafting Guild
-- !pos 13.591 -7.287 8.569 248
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/shop")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local guildSkillId = xi.skill.CLOTHCRAFT
    local stock = xi.shop.generalGuildStock[guildSkillId]
    xi.shop.generalGuild(player, stock, guildSkillId)
    player:showText(npc, ID.text.CLOTHCRAFT_SHOP_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
