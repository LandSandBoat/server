-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Sulbahn
-- Type: Alchemy Adv. Image Support
-- !pos -10.470 -6.25 -141.700 241
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.ALCHEMY) then
        if npcUtil.tradeHas(trade, 2184) then
            if not player:hasStatusEffect(xi.effect.ALCHEMY_IMAGERY) then
                player:confirmTrade()
                player:startEvent(637, 17160, 1, 19405, 21215, 30030, 0, 7, 0)
            else
                npc:showText(npc, ID.text.IMAGE_SUPPORT_ACTIVE)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local skillLevel = player:getSkillLevel(xi.skill.ALCHEMY)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.ALCHEMY) then
        player:startEvent(636, 2, skillLevel, 0, 511, 0, 0, 7, 2184)
    else
        player:startEvent(636, 0, 0, 0, 0, 0, 0, 7, 0) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 637 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 7, 0)
        player:addStatusEffect(xi.effect.ALCHEMY_IMAGERY, 3, 0, 480)
    end
end

return entity
