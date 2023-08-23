-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Orechiniel
-- Type: Leathercraft Adv. Synthesis Image Support
-----------------------------------
require("scripts/globals/crafting")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillLevel = player:getSkillLevel(xi.skill.LEATHERCRAFT)
    local cost = xi.crafting.getAdvImageSupportCost(player, xi.skill.LEATHERCRAFT)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.LEATHERCRAFT) then
        if not player:hasStatusEffect(xi.effect.LEATHERCRAFT_IMAGERY) then
            player:startEvent(650, cost, skillLevel, 0, 239, player:getGil(), 0, 0, 0)
        else
            player:startEvent(650, cost, skillLevel, 0, 239, player:getGil(), 28727, 0, 0)
        end
    else
        player:startEvent(650) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local cost = xi.crafting.getAdvImageSupportCost(player, xi.skill.LEATHERCRAFT)

    if csid == 650 and option == 1 then
        player:delGil(cost)
        player:messageSpecial(ID.text.LEATHER_SUPPORT, 0, 5, 0)
        player:addStatusEffect(xi.effect.LEATHERCRAFT_IMAGERY, 3, 0, 480)
    end
end

return entity
