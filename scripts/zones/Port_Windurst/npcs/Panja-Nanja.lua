-----------------------------------
-- Area: Port Windurst
--  NPC: Panja-Nanja
-- Type: Fishing Adv. Image Support
-- !pos -194.499 -3 58.692 240
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillLevel = player:getSkillLevel(xi.skill.FISHING)
    local cost = xi.crafting.getAdvImageSupportCost(player, xi.skill.FISHING)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.FISHING) then
        if not player:hasStatusEffect(xi.effect.FISHING_IMAGERY) then
            player:startEvent(10011, cost, skillLevel, 0, 239, player:getGil(), 0, 0, 0) -- p1 = skill level
        else
            player:startEvent(10011, cost, skillLevel, 0, 239, player:getGil(), 38586, 30, 0)
        end
    else
        player:startEvent(10011) -- Standard Dialogue, incorrect
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    local cost = xi.crafting.getAdvImageSupportCost(player, xi.skill.FISHING)

    if csid == 10011 and option == 1 then
        player:delGil(cost)
        player:messageSpecial(ID.text.FISHING_SUPPORT, 0, 0, 0)
        player:addStatusEffect(xi.effect.FISHING_IMAGERY, 2, 0, 7200)
    end
end

return entity
