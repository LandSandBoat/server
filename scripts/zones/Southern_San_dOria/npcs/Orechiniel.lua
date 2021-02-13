-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Orechiniel
-- Type: Leathercraft Adv. Synthesis Image Support
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
    local SkillLevel = player:getSkillLevel(tpz.skill.LEATHERCRAFT)
    local Cost = getAdvImageSupportCost(player, tpz.skill.LEATHERCRAFT)

    if (guildMember == 1) then
        if (player:hasStatusEffect(tpz.effect.LEATHERCRAFT_IMAGERY) == false) then
            player:startEvent(650, Cost, SkillLevel, 0, 239, player:getGil(), 0, 0, 0)
        else
            player:startEvent(650, Cost, SkillLevel, 0, 239, player:getGil(), 28727, 0, 0)
        end
    else
        player:startEvent(650) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local Cost = getAdvImageSupportCost(player, tpz.skill.LEATHERCRAFT)

    if (csid == 650 and option == 1) then
        player:delGil(Cost)
        player:messageSpecial(ID.text.LEATHER_SUPPORT, 0, 5, 0)
        player:addStatusEffect(tpz.effect.LEATHERCRAFT_IMAGERY, 3, 0, 480)
    end
end

return entity
