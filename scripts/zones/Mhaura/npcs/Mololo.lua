-----------------------------------
-- Area: Mhaura
--  NPC: Mololo
-- Guild Merchant NPC: Blacksmithing Guild
-- !pos -64.278 -16.624 34.120 249
-----------------------------------
local ID = require("scripts/zones/Mhaura/IDs")
require("scripts/globals/shop")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local guildSkillId = tpz.skill.SMITHING
    local stock = tpz.shop.generalGuildStock[guildSkillId]
    tpz.shop.generalGuild(player, stock, guildSkillId)
    player:showText(npc, ID.text.SMITHING_GUILD)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
