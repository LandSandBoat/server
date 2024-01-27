-----------------------------------
-- Area: Windurst Waters
--  NPC: Kipo-Opo
-- Type: Cooking Adv. Image Support
-- !pos -119.750 -5.239 64.500 238
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillLevel = player:getSkillLevel(xi.skill.COOKING)
    local cost = xi.crafting.getAdvImageSupportCost(player, xi.skill.COOKING)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.COOKING) then
        if not player:hasStatusEffect(xi.effect.COOKING_IMAGERY) then
            player:startEvent(10015, cost, skillLevel, 0, 495, player:getGil(), 0, 0, 0) -- p1 = skill level
        else
            player:startEvent(10015, cost, skillLevel, 0, 495, player:getGil(), 28589, 0, 0)
        end
    else
        player:startEvent(10015) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    local cost = xi.crafting.getAdvImageSupportCost(player, xi.skill.COOKING)

    if csid == 10015 and option == 1 then
        player:delGil(cost)
        player:messageSpecial(ID.text.COOKING_SUPPORT, 0, 8, 0)
        player:addStatusEffect(xi.effect.COOKING_IMAGERY, 3, 0, 480)
    end
end

return entity
