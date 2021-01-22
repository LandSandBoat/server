-----------------------------------
-- Area: Bastok Mines
--  NPC: Sieglinde
-- Alchemy Synthesis Image Support
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local guildMember = isGuildMember(player, 1)
    local SkillCap = getCraftSkillCap(player, tpz.skill.SMITHING)
    local SkillLevel = player:getSkillLevel(tpz.skill.SMITHING)

    if (guildMember == 1) then
        if (player:hasStatusEffect(tpz.effect.ALCHEMY_IMAGERY) == false) then
            player:startEvent(124, SkillCap, SkillLevel, 2, 201, player:getGil(), 0, 4095, 0)
        else
            player:startEvent(124, SkillCap, SkillLevel, 2, 201, player:getGil(), 7009, 4095, 0)
        end
    else
        player:startEvent(124)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 124 and option == 1) then
        player:messageSpecial(ID.text.ALCHEMY_SUPPORT, 0, 7, 2)
        player:addStatusEffect(tpz.effect.ALCHEMY_IMAGERY, 1, 0, 120)
    end
end

return entity
