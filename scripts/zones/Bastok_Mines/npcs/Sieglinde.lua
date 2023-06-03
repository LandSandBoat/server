-----------------------------------
-- Area: Bastok Mines
--  NPC: Sieglinde
-- Alchemy Synthesis Image Support
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/crafting")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillCap   = xi.crafting.getCraftSkillCap(player, xi.skill.ALCHEMY)
    local skillLevel = player:getSkillLevel(xi.skill.ALCHEMY)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.ALCHEMY) then
        if not player:hasStatusEffect(xi.effect.ALCHEMY_IMAGERY) then
            player:startEvent(124, skillCap, skillLevel, 2, 201, player:getGil(), 0, 4095, 0)
        else
            player:startEvent(124, skillCap, skillLevel, 2, 201, player:getGil(), 7009, 4095, 0)
        end
    else
        player:startEvent(124)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 124 and option == 1 then
        player:messageSpecial(ID.text.ALCHEMY_SUPPORT, 0, 7, 2)
        player:addStatusEffect(xi.effect.ALCHEMY_IMAGERY, 1, 0, 120)
    end
end

return entity
