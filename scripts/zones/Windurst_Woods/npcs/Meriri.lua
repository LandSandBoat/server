-----------------------------------
-- Area: Windurst Woods
--  NPC: Meriri
-- Guild Merchant NPC: Clothcrafting Guild
-- !pos -76.471 -3.55 -128.341 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/shop")
require("scripts/globals/crafting")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildRank = player:getSkillRank(tpz.skill.CLOTHCRAFT)
    local stock = tpz.shop.generalGuildStock[guild.clothcraft]
    tpz.shop.generalGuild(player, stock, guildRank)
    player:showText(npc, ID.text.MERIRI_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
