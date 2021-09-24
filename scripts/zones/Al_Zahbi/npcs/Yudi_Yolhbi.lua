-----------------------------------
-- Area: Al Zahbi
--  NPC: Yudi Yolhbi
-- Type: Woodworking Normal/Adv. Image Support
-- !pos -71.584 -7 -56.018 48
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Al_Zahbi/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local guildMember = xi.crafting.isGuildMember(player, 9)

    if guildMember == 1 then
        if trade:hasItemQty(2184, 1) and trade:getItemCount() == 1 then
            if player:hasStatusEffect(xi.effect.WOODWORKING_IMAGERY) == false then
                player:tradeComplete()
                player:startEvent(235, 8, 0, 0, 0, 188, 0, 1, 0)
            else
                npc:showText(npc, ID.text.IMAGE_SUPPORT_ACTIVE)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local guildMember = xi.crafting.isGuildMember(player, 9)
    local SkillLevel = player:getSkillLevel(xi.skill.WOODWORKING)

    if guildMember == 1 then
        if player:hasStatusEffect(xi.effect.WOODWORKING_IMAGERY) == false then
            player:startEvent(234, 8, SkillLevel, 0, 511, 188, 0, 1, 2184)
        else
            player:startEvent(234, 8, SkillLevel, 0, 511, 188, 7055, 1, 2184)
        end
    else
        player:startEvent(234, 0, 0, 0, 0, 0, 0, 1, 0) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 234 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 1, 1)
        player:addStatusEffect(xi.effect.WOODWORKING_IMAGERY, 1, 0, 120)
    elseif csid == 235 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 1, 0)
        player:addStatusEffect(xi.effect.WOODWORKING_IMAGERY, 3, 0, 480)
    end
end

return entity
