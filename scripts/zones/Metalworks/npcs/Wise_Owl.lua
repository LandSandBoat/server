-----------------------------------
-- Area: Metalworks
--  NPC: Wise Owl
-- Type: Smithing Adv. Image Support
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
    local skillLevel = player:getSkillLevel(xi.skill.SMITHING)
    local cost = xi.crafting.getAdvImageSupportCost(player, xi.skill.SMITHING)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.SMITHING) then
        if not player:hasStatusEffect(xi.effect.SMITHING_IMAGERY) then
            player:startEvent(103, cost, skillLevel, 0, 207, player:getGil(), 0, 4095, 0)
        else
            player:startEvent(103, cost, skillLevel, 0, 207, player:getGil(), 28721, 4095, 0)
        end
    else
        player:startEvent(103)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local cost = xi.crafting.getAdvImageSupportCost(player, xi.skill.SMITHING)

    if csid == 103 and option == 1 then
        if player:getGil() >= cost then
            player:delGil(cost)
            player:delStatusEffectsByFlag(xi.effectFlag.SYNTH_SUPPORT, true)
            player:addStatusEffect(xi.effect.SMITHING_IMAGERY, 3, 0, 480)
            player:messageSpecial(ID.text.SMITHING_SUPPORT, 0, 2, 0)
        else
            player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
        end
    end
end

return entity
