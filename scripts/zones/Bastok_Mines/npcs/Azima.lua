-----------------------------------
-- Area: Bastok Mines
--  NPC: Azima
-- Alchemy Adv. Synthesis Image Support
-- !pos 123.5 2 1 234
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillLevel  = player:getSkillLevel(xi.skill.ALCHEMY)
    local cost        = xi.crafting.getAdvImageSupportCost(player, xi.skill.ALCHEMY)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.ALCHEMY) then
        if not player:hasStatusEffect(xi.effect.ALCHEMY_IMAGERY) then
            player:startEvent(122, cost, skillLevel, 0, 0xB0001AF, player:getGil(), 0, 0, 0) -- Event doesn't work
        else
            player:startEvent(122, cost, skillLevel, 0, 0xB0001AF, player:getGil(), 0x6FE2, 0, 0)
        end
    else
        player:startEvent(122)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local cost = xi.crafting.getAdvImageSupportCost(player, xi.skill.ALCHEMY)

    if csid == 122 and option == 1 then
        player:delGil(cost)
        player:messageSpecial(ID.text.ALCHEMY_SUPPORT, 0, 7, 0)
        player:addStatusEffect(xi.effect.ALCHEMY_IMAGERY, 3, 0, 480)
    end
end

return entity
