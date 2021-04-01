-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Greubaque
-- Type: Smithing Adv. Synthesis Image Support
-- !pos -179.400 10.999 150.000 231
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local guildMember = isGuildMember(player, 8)
    local SkillLevel = player:getSkillLevel(xi.skill.SMITHING)
    local Cost = getAdvImageSupportCost(player, xi.skill.SMITHING)

    if (guildMember == 1) then
        if (player:hasStatusEffect(xi.effect.SMITHING_IMAGERY) == false) then
            player:startEvent(628, Cost, SkillLevel, 0, 205, player:getGil(), 0, 0, 0)
        else
            player:startEvent(628, Cost, SkillLevel, 0, 205, player:getGil(), 28721, 4095, 0)
        end
    else
        player:startEvent(628, Cost, SkillLevel, 0, 201, player:getGil(), 0, 26, 0) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local Cost = getAdvImageSupportCost(player, xi.skill.SMITHING)

    if (csid == 628 and option == 1) then
        player:delGil(Cost)
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 2, 0)
        player:addStatusEffect(xi.effect.SMITHING_IMAGERY, 3, 0, 480)
    end
end

return entity
