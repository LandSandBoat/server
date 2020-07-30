-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Cletae
-- Guild Merchant NPC: Leathercrafting Guild
-- !pos -189.142 -8.800 14.449 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildRank = player:getSkillRank(tpz.skill.LEATHERCRAFT)
    local stock = tpz.shop.generalGuildStock[guild.leathercraft]
    tpz.shop.generalGuild(player, stock, guildRank)
    player:showText(npc, ID.text.CLETAE_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
