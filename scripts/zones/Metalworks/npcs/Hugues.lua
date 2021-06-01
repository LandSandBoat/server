-----------------------------------
-- Area: Metalworks
--  NPC: Hugues
-- Type: Smithing Synthesis Image Support
-- !pos -106.336 2.000 26.117 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/status")
require("scripts/globals/crafting")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local guildMember = isGuildMember(player, 8)
    local SkillCap = getCraftSkillCap(player, xi.skill.SMITHING)
    local SkillLevel = player:getSkillLevel(xi.skill.SMITHING)

    if guildMember == 1 then
        if player:hasStatusEffect(xi.effect.SMITHING_IMAGERY) == false then
            player:startEvent(104, SkillCap, SkillLevel, 1, 207, player:getGil(), 0, 4095, 0)
        else
            player:startEvent(104, SkillCap, SkillLevel, 1, 207, player:getGil(), 7101, 4095, 0)
        end
    else
        player:startEvent(104)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 104 and option == 1 then
        player:delStatusEffectsByFlag(xi.effectFlag.SYNTH_SUPPORT, true)
        player:addStatusEffect(xi.effect.SMITHING_IMAGERY, 1, 0, 120)
        player:messageSpecial(ID.text.SMITHING_SUPPORT, 0, 2, 1)
    end
end

return entity
