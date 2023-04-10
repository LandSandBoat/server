-----------------------------------
-- Area: Windurst Woods
--  NPC: Nikkoko
-- Type: Clothcraft Image Support
-- !pos -32.810 -3.25 -113.680 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillCap = xi.crafting.getCraftSkillCap(player, xi.skill.CLOTHCRAFT)
    local skillLevel = player:getSkillLevel(xi.skill.CLOTHCRAFT)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.CLOTHCRAFT) then
        if not player:hasStatusEffect(xi.effect.CLOTHCRAFT_IMAGERY) then
            player:startEvent(10014, skillCap, skillLevel, 1, 511, player:getGil(), 0, 4095, 0) -- p1 = skill level
        else
            player:startEvent(10014, skillCap, skillLevel, 1, 511, player:getGil(), 7101, 4095, 0)
        end
    else
        player:startEvent(10014) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10014 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 4, 1)
        player:addStatusEffect(xi.effect.CLOTHCRAFT_IMAGERY, 1, 0, 120)
    end
end

return entity
