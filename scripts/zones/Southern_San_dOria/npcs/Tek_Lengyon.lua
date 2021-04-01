-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Tek Lengyon
-- Type: Leathercraft Synthesis Image Support
-- !pos -190.120 -2.999 2.770 230
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local guildMember = isGuildMember(player, 7)
    local SkillCap = getCraftSkillCap(player, xi.skill.LEATHERCRAFT)
    local SkillLevel = player:getSkillLevel(xi.skill.LEATHERCRAFT)

    if (guildMember == 1) then
        if (player:hasStatusEffect(xi.effect.LEATHERCRAFT_IMAGERY) == false) then
            player:startEvent(652, SkillCap, SkillLevel, 2, 239, player:getGil(), 0, 0, 0)
        else
            player:startEvent(652, SkillCap, SkillLevel, 2, 239, player:getGil(), 7075, 0, 0)
        end
    else
        player:startEvent(652) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 652 and option == 1) then
        player:messageSpecial(ID.text.LEATHER_SUPPORT, 0, 5, 2)
        player:addStatusEffect(xi.effect.LEATHERCRAFT_IMAGERY, 1, 0, 120)
    end
end

return entity
