-----------------------------------
-- Area: Windurst Woods
--  NPC: Meriri
-- Guild Merchant NPC: Clothcrafting Guild
-- !pos -76.471 -3.55 -128.341 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/shop")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local guildSkillId = tpz.skill.CLOTHCRAFT
    local stock = tpz.shop.generalGuildStock[guildSkillId]
    tpz.shop.generalGuild(player, stock, guildSkillId)
    player:showText(npc, ID.text.MERIRI_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
