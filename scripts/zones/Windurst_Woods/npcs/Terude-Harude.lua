-----------------------------------
-- Area: Windurst Woods
--  NPC: Terude-Harude
-- Type: Clothcraft Adv. Image Support
-- !pos -32.350 -2.679 -116.450 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillLevel = player:getSkillLevel(xi.skill.CLOTHCRAFT)
    local cost = xi.crafting.getAdvImageSupportCost(player, xi.skill.CLOTHCRAFT)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.CLOTHCRAFT) then
        if not player:hasStatusEffect(xi.effect.CLOTHCRAFT_IMAGERY) then
            player:startEvent(10013, cost, skillLevel, 0, 511, player:getGil(), 0, 4095, 0)
        else
            player:startEvent(10013, cost, skillLevel, 0, 511, player:getGil(), 28754, 0, 0)
        end
    else
        player:startEvent(10013) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local cost = xi.crafting.getAdvImageSupportCost(player, xi.skill.CLOTHCRAFT)

    if csid == 10013 and option == 1 then
        player:delGil(cost)
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 4, 0)
        player:addStatusEffect(xi.effect.CLOTHCRAFT_IMAGERY, 3, 0, 480)
    end
end

return entity
