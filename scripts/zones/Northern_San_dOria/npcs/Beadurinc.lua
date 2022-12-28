-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Beadurinc
-- Type: Smithing Synthesis Image Support
-- !pos -182.300 10.999 146.650 231
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillCap = xi.crafting.getCraftSkillCap(player, xi.skill.SMITHING)
    local skillLevel = player:getSkillLevel(xi.skill.SMITHING)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.SMITHING) then
        if not player:hasStatusEffect(xi.effect.SMITHING_IMAGERY) then
            player:startEvent(630, skillCap, skillLevel, 2, 205, player:getGil(), 0, 90, 0)
        else
            player:startEvent(630, skillCap, skillLevel, 2, 205, player:getGil(), 7054, 90, 0)
        end
    else
        player:startEvent(630, skillCap, skillLevel, 2, 201, player:getGil(), 0, 0, 0) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 630 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 2, 2)
        player:addStatusEffect(xi.effect.SMITHING_IMAGERY, 1, 0, 120)
    end
end

return entity
