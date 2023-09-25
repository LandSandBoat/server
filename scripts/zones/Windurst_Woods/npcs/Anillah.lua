-----------------------------------
-- Area: Windurst Woods
--  NPC: Anillah
-- Type: Clothcraft Image Support
-- !pos -34.800 -2.25 -119.950 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillCap    = xi.crafting.getCraftSkillCap(player, xi.skill.CLOTHCRAFT)
    local skillLevel  = xi.crafting.getRealSkill(player, xi.skill.CLOTHCRAFT)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.CLOTHCRAFT) then
        if not player:hasStatusEffect(xi.effect.CLOTHCRAFT_IMAGERY) then
            player:startEvent(10015, skillCap, skillLevel, 2, 511, player:getGil(), 0, 0, 0)
        else
            player:startEvent(10015, skillCap, skillLevel, 2, 511, player:getGil(), 7108, 0, 0)
        end
    else
        player:startEvent(10015) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10015 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 4, 2)
        player:addStatusEffect(xi.effect.CLOTHCRAFT_IMAGERY, 1, 0, 120)
    end
end

return entity
