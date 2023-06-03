-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Kemha Flasehp
-- Type: Fishing Normal/Adv. Image Support
-- !pos -28.4 -6 -98 50
-----------------------------------
require("scripts/globals/crafting")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.FISHING) then
        if npcUtil.tradeHas(trade, 2184) then
            if not player:hasStatusEffect(xi.effect.FISHING_IMAGERY) then
                player:confirmTrade()
                player:startEvent(643, 8, 0, 0, 0, 188, 0, 6, 0)
            else
                npc:showText(npc, ID.text.IMAGE_SUPPORT_ACTIVE)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.FISHING) then
        if not player:hasStatusEffect(xi.effect.FISHING_IMAGERY) then
            player:startEvent(642, 8, 0, 0, 511, 1, 0, 0, 2184)
        else
            player:startEvent(642, 8, 0, 0, 511, 1, 19267, 0, 2184)
        end
    else
        player:startEvent(642) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 642 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 0, 1)
        player:addStatusEffect(xi.effect.FISHING_IMAGERY, 1, 0, 3600)
    elseif csid == 643 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 0, 0)
        player:addStatusEffect(xi.effect.FISHING_IMAGERY, 2, 0, 7200)
    end
end

return entity
