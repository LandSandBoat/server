-----------------------------------
-- Area: Windurst Waters
--  NPC: Kipo-Opo
-- Type: Cooking Adv. Image Support
-- !pos -119.750 -5.239 64.500 238
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local guildMember = isGuildMember(player, 4)
    local SkillLevel = player:getSkillLevel(xi.skill.COOKING)
    local Cost = getAdvImageSupportCost(player, xi.skill.COOKING)

    if (guildMember == 1) then
        if (player:hasStatusEffect(xi.effect.COOKING_IMAGERY) == false) then
            player:startEvent(10015, Cost, SkillLevel, 0, 495, player:getGil(), 0, 0, 0) -- p1 = skill level
        else
            player:startEvent(10015, Cost, SkillLevel, 0, 495, player:getGil(), 28589, 0, 0)
        end
    else
        player:startEvent(10015) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local Cost = getAdvImageSupportCost(player, xi.skill.COOKING)

    if (csid == 10015 and option == 1) then
        player:delGil(Cost)
        player:messageSpecial(ID.text.COOKING_SUPPORT, 0, 8, 0)
        player:addStatusEffect(xi.effect.COOKING_IMAGERY, 3, 0, 480)
    end
end

return entity
