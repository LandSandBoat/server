-----------------------------------
-- Area: Bastok Mines
--  NPC: Titus
-- Alchemy Synthesis Image Support
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillCap   = xi.crafting.getCraftSkillCap(player, xi.skill.ALCHEMY)
    local skillLevel = player:getSkillLevel(xi.skill.ALCHEMY)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.ALCHEMY) then
        if not player:hasStatusEffect(xi.effect.ALCHEMY_IMAGERY) then
            player:startEvent(123, skillCap, skillLevel, 1, 137, player:getGil(), 0, 0, 0)
        else
            player:startEvent(123, skillCap, skillLevel, 1, 137, player:getGil(), 6758, 0, 0)
        end
    else
        player:startEvent(123)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 123 and option == 1 then
        player:messageSpecial(ID.text.ALCHEMY_SUPPORT, 0, 7, 1)
        player:addStatusEffect(xi.effect.ALCHEMY_IMAGERY, 1, 0, 120)
    end
end

return entity
