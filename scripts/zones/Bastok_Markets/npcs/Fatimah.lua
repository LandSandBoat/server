-----------------------------------
-- Area: Bastok Markets
--  NPC: Fatimah
-- Type: Goldsmithing Adv. Synthesis Image Support
-- !pos -193.849 -7.824 -56.372 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/status")
require("scripts/globals/crafting")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local guildMember = isGuildMember(player, 6)
    local SkillLevel = player:getSkillLevel(xi.skill.GOLDSMITHING)
    local Cost = getAdvImageSupportCost(player, xi.skill.GOLDSMITHING)

    if guildMember == 1 then
        if player:hasStatusEffect(xi.effect.GOLDSMITHING_IMAGERY) == false then
            player:startEvent(302, Cost, SkillLevel, 0, 0xB0001AF, player:getGil(), 0, 0, 0) -- Event doesn't work
        else
            player:startEvent(302, Cost, SkillLevel, 0, 0xB0001AF, player:getGil(), 28674, 0, 0)
        end
    else
        player:startEvent(302)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local Cost = getAdvImageSupportCost(player, xi.skill.GOLDSMITHING)

    if csid == 302 and option == 1 then
        if player:getGil() >= Cost then
            player:delGil(Cost)
            player:delStatusEffectsByFlag(xi.effectFlag.SYNTH_SUPPORT, true)
            player:addStatusEffect(xi.effect.GOLDSMITHING_IMAGERY, 3, 0, 480)
            player:messageSpecial(ID.text.GOLDSMITHING_SUPPORT, 0, 3, 0)
        else
            player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
        end
    end
end

return entity
