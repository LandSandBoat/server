-----------------------------------
-- Area: Bastok Mines
--  NPC: Odoba
-- Guild Merchant NPC: Alchemy Guild
-- !pos 108.473 5.017 1.089 234
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/shop")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildSkillId = tpz.skill.ALCHEMY
    local stock = tpz.shop.generalGuildStock[guildSkillId]
    tpz.shop.generalGuild(player, stock, guildSkillId)
    player:showText(npc, ID.text.ODOBA_SHOP_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
