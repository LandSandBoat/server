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
    local guildMember = xi.crafting.isGuildMember(player, 8)
    local SkillCap = xi.crafting.getCraftSkillCap(player, xi.skill.SMITHING)
    local SkillLevel = player:getSkillLevel(xi.skill.SMITHING)

    if (guildMember == 1) then
        if (player:hasStatusEffect(xi.effect.SMITHING_IMAGERY) == false) then
            player:startEvent(630, SkillCap, SkillLevel, 2, 205, player:getGil(), 0, 90, 0)
        else
            player:startEvent(630, SkillCap, SkillLevel, 2, 205, player:getGil(), 7054, 90, 0)
        end
    else
        player:startEvent(630, SkillCap, SkillLevel, 2, 201, player:getGil(), 0, 0, 0) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 630 and option == 1) then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 2, 2)
        player:addStatusEffect(xi.effect.SMITHING_IMAGERY, 1, 0, 120)
    end
end

return entity
