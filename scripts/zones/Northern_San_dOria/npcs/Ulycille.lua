-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Ulycille
-- Type: Woodworking Adv. Synthesis Image Support
-- !pos -183.320 9.999 269.651 231
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 9)
    local SkillLevel = player:getSkillLevel(tpz.skill.WOODWORKING)
    local Cost = getAdvImageSupportCost(player, tpz.skill.WOODWORKING)

    if (guildMember == 1) then
        if (player:hasStatusEffect(tpz.effect.WOODWORKING_IMAGERY) == false) then
            player:startEvent(623, Cost, SkillLevel, 0, 207, player:getGil(), 0, 4095, 0)
        else
            player:startEvent(623, Cost, SkillLevel, 0, 207, player:getGil(), 28482, 4095, 0)
        end
    else
        player:startEvent(623) -- Standard Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local Cost = getAdvImageSupportCost(player, tpz.skill.WOODWORKING)

    if (csid == 623 and option == 1) then
        player:delGil(Cost)
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 1, 0)
        player:addStatusEffect(tpz.effect.WOODWORKING_IMAGERY, 3, 0, 480)
    end
end
