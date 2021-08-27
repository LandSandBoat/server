-----------------------------------
-- Area: Windurst Waters
--  NPC: Hakeem
-- Type: Cooking Image Support
-- !pos -123.120 -2.999 65.472 238
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local guildMember = xi.crafting.isGuildMember(player, 4)
    local SkillCap = xi.crafting.getCraftSkillCap(player, xi.skill.COOKING)
    local SkillLevel = player:getSkillLevel(xi.skill.COOKING)

    if (guildMember == 1) then
        if (player:hasStatusEffect(xi.effect.COOKING_IMAGERY) == false) then
            player:startEvent(10017, SkillCap, SkillLevel, 2, 495, player:getGil(), 0, 4095, 0) -- p1 = skill level
        else
            player:startEvent(10017, SkillCap, SkillLevel, 2, 495, player:getGil(), 7094, 4095, 0)
        end
    else
        player:startEvent(10017) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 10017 and option == 1) then
        player:messageSpecial(ID.text.COOKING_SUPPORT, 0, 8, 2)
        player:addStatusEffect(xi.effect.COOKING_IMAGERY, 1, 0, 120)
    end
end

return entity
