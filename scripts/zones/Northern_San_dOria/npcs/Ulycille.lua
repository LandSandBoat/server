-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Ulycille
-- Type: Woodworking Adv. Synthesis Image Support
-- !pos -183.320 9.999 269.651 231
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local guildMember = xi.crafting.isGuildMember(player, 9)
    local SkillLevel = player:getSkillLevel(xi.skill.WOODWORKING)
    local Cost = xi.crafting.getAdvImageSupportCost(player, xi.skill.WOODWORKING)

    if (guildMember == 1) then
        if (player:hasStatusEffect(xi.effect.WOODWORKING_IMAGERY) == false) then
            player:startEvent(623, Cost, SkillLevel, 0, 207, player:getGil(), 0, 4095, 0)
        else
            player:startEvent(623, Cost, SkillLevel, 0, 207, player:getGil(), 28482, 4095, 0)
        end
    else
        player:startEvent(623) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local Cost = xi.crafting.getAdvImageSupportCost(player, xi.skill.WOODWORKING)

    if (csid == 623 and option == 1) then
        player:delGil(Cost)
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 1, 0)
        player:addStatusEffect(xi.effect.WOODWORKING_IMAGERY, 3, 0, 480)
    end
end

return entity
