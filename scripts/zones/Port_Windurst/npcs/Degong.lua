-----------------------------------
-- Area: Port Windurst
--  NPC: Degong
-- Type: Fishing Synthesis Image Support
-- !pos -178.400 -3.835 60.480 240
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillCap = xi.crafting.getCraftSkillCap(player, xi.skill.FISHING)
    local skillLevel = player:getSkillLevel(xi.skill.FISHING)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.FISHING) then
        if not player:hasStatusEffect(xi.effect.FISHING_IMAGERY) then
            player:startEvent(10013, skillCap, skillLevel, 2, 239, player:getGil(), 0, 30, 0) -- p1 = skill level
        else
            player:startEvent(10013, skillCap, skillLevel, 2, 239, player:getGil(), 19293, 30, 0)
        end
    else
        player:startEvent(10013) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10013 and option == 1 then
        player:messageSpecial(ID.text.FISHING_SUPPORT, 0, 0, 2)
        player:addStatusEffect(xi.effect.FISHING_IMAGERY, 1, 0, 3600)
    end
end

return entity
