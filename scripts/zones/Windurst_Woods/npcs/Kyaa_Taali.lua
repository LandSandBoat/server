-----------------------------------
-- Area: Windurst Woods
--  NPC: Kyaa Taali
-- Type: Bonecraft Image Support
-- !pos -10.470 -6.25 -141.700 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillCap = xi.crafting.getCraftSkillCap(player, xi.skill.BONECRAFT)
    local skillLevel = player:getSkillLevel(xi.skill.BONECRAFT)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.BONECRAFT) then
        if not player:hasStatusEffect(xi.effect.BONECRAFT_IMAGERY) then
            player:startEvent(10020, skillCap, skillLevel, 2, 509, player:getGil(), 0, 0, 0)
        else
            player:startEvent(10020, skillCap, skillLevel, 2, 511, player:getGil(), 7147, 0, 0)
        end
    else
        player:startEvent(10020) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10020 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 6, 2)
        player:addStatusEffect(xi.effect.BONECRAFT_IMAGERY, 1, 0, 120)
    end
end

return entity
