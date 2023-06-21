-----------------------------------
-- Area: Port Windurst
--  NPC: Erabu-Fumulubu
-- Type: Fishing Synthesis Image Support
-- !pos -178.900 -2.789 76.200 240
-----------------------------------
require("scripts/globals/crafting")
local ID = require("scripts/zones/Port_Windurst/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillCap = xi.crafting.getCraftSkillCap(player, xi.skill.FISHING)
    local skillLevel = player:getSkillLevel(xi.skill.FISHING)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.FISHING) then
        if not player:hasStatusEffect(xi.effect.FISHING_IMAGERY) then
            player:startEvent(10012, skillCap, skillLevel, 1, 239, player:getGil(), 0, 0, 0) -- p1 = skill level
        else
            player:startEvent(10012, skillCap, skillLevel, 1, 239, player:getGil(), 19194, 4031, 0)
        end
    else
        player:startEvent(10012) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10012 and option == 1 then
        player:messageSpecial(ID.text.FISHING_SUPPORT, 0, 0, 1)
        player:addStatusEffect(xi.effect.FISHING_IMAGERY, 1, 0, 3600)
    end
end

return entity
