-----------------------------------
-- Area: Windurst Waters
--  NPC: Chomo Jinjahl
-- Guild Merchant NPC: Cooking Guild
-- !pos -105.094 -2.222 73.791 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/shop")
require("scripts/globals/crafting")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildRank = player:getSkillRank(tpz.skill.COOKING)
    local stock = tpz.shop.generalGuildStock[guild.cooking]
    tpz.shop.generalGuild(player, stock, guildRank)
    player:showText(npc, ID.text.CHOMOJINJAHL_SHOP_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
